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
    context.read<AppBloc>().workersRepository.workersStream.listen((event) {
      print("Server notification");
      context.read<GalleryBloc>().add(const WorkersListUpdated());
    });

    context.read<AppBloc>().ensureAuthenticated().then((value) {
      print("HomeView -> ensureAuthenticated: $value");
      context.read<GalleryBloc>().add(const WorkersSubscriptionRequested());
      context.read<GalleryBloc>().add(const FiltersUpdated());
    });

    final HomeTab selectedTab =
        context.select((HomeCubit cubit) => cubit.state.selectedTab);

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
        appBar: AppBar(
          title: Text(selectedTab == HomeTab.page1
              ? "ELENCO LAVORATORI"
              : (selectedTab == HomeTab.page2 &&
                      context.read<HomeCubit>().state.workerToEdit != null)
                  ? "MODIFICA LAVORATORE"
                  : "CREA UN NUOVO LAVORATORE"),
          leading: context
                      .select((HomeCubit cubit) => cubit.state.selectedTab) ==
                  HomeTab.page1
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const LogoutAlertDialog());
                  },
                  tooltip: "Esci",
                  icon: const Icon(Icons.logout),
                )
              : IconButton(
                  tooltip: "Torna alla lista",
                  onPressed: () {
                    if (context.read<CreateBloc>().state !=
                        const CreateState()) {
                      showDialog(
                              context: context,
                              builder: (context) => const CancelAlertDialog())
                          .then((value) {
                        if (value == true) {
                          context.read<CreateBloc>().add(const ResetForm());
                          context.read<HomeCubit>().setTab(HomeTab.page1);
                        }
                      });
                    } else {
                      context.read<HomeCubit>().setTab(HomeTab.page1);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${context.read<AppBloc>().state.employee.firstname} ${context.read<AppBloc>().state.employee.lastname}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    context.read<AppBloc>().state.employee.email,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            )
          ],
          centerTitle: true,
        ),
        floatingActionButton:
            (context.select((HomeCubit cubit) => cubit.state.selectedTab) ==
                    HomeTab.page1)
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      context.read<HomeCubit>().setTab(HomeTab.page2);
                    },
                  )
                : null,
        body: IndexedStack(
          index: context
              .select((HomeCubit cubit) => cubit.state.selectedTab)
              .index,
          children: [
            const GalleryPage(),
            CreatePage(
              toEdit:
                  context.select((HomeCubit cubit) => cubit.state.workerToEdit),
            )
          ],
        ),
      ),
    );
  }
}

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({super.key});

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

class CancelAlertDialog extends StatelessWidget {
  const CancelAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Vuoi tornare indietro?"),
      content: const Text(
          "Tornando alla lista dei lavoratori perderai le attuali modifiche\nSicuro di volerlo fare?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("NO")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("SI"))
      ],
    );
  }
}
