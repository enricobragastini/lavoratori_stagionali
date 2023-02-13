import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/create/view/view.dart';
import 'package:lavoratori_stagionali/gallery/gallery.dart';

import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';
import 'package:lavoratori_stagionali/create/bloc/create_bloc.dart';
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/network/bloc/network_bloc.dart';
import 'package:workers_repository/workers_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.workersRepository}) : super(key: key);

  final WorkersRepository workersRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) =>
              GalleryBloc(workersRepository: workersRepository),
        ),
        BlocProvider(
          create: (context) => CreateBloc(workersRepository: workersRepository),
        ),
        BlocProvider(
          create: (context) => NetworkBloc()..observeNetwork(),
        )
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().ensureAuthenticated().then((value) {
      print("HomeView -> ensureAuthenticated: $value");
      context.read<GalleryBloc>().add(const WorkersSubscriptionRequested());
      context.read<GalleryBloc>().add(const FiltersUpdated());
    });

    return BlocListener<NetworkBloc, NetworkState>(
      listenWhen: (previous, current) {
        return (previous is NetworkFailure && current is NetworkSuccess) ||
            (previous is NetworkSuccess && current is NetworkFailure);
      },
      listener: (context, state) {
        if (state is NetworkFailure) {
          showDialog(
            context: context,
            builder: (context) {
              return const Dialog.fullscreen(
                child: Center(
                    child: Text(
                  "OPS! Sembra che tu non sia connesso a internet!\nVerifica la tua connessione",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                )),
              );
            },
          );
        } else if (state is NetworkSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            tooltip: "Logout",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const CustomAlertDialog());
            },
            child: const Icon(Icons.logout)),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartDocked,
        body: IndexedStack(
          index: context
              .select((HomeCubit cubit) => cubit.state.selectedTab)
              .index,
          children: [const GalleryPage(), CreatePage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context
              .select((HomeCubit cubit) => cubit.state.selectedTab)
              .index,
          onTap: (index) {
            _tabIndex = index;
            context.read<HomeCubit>().setTab(HomeTab.values[index]);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: "Elenco lavoratori"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: "Nuovo lavoratore")
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text("Sicuro di voler uscire?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("ANNULLA")),
        TextButton(
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
            child: const Text("ESCI"))
      ],
    );
  }
}
