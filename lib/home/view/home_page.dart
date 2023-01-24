import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/create/view/view.dart';
import 'package:lavoratori_stagionali/gallery/gallery.dart';

import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';
import 'package:lavoratori_stagionali/create/bloc/create_bloc.dart';
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
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
          create: (context) => GalleryBloc(workersRepository: workersRepository)
            ..add(const WorkersSubscriptionRequested()),
        ),
        BlocProvider(
          create: (context) => CreateBloc(workersRepository: workersRepository),
        ),
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
    return Scaffold(
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
        index:
            context.select((HomeCubit cubit) => cubit.state.selectedTab).index,
        children: [const GalleryPage(), CreatePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
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
