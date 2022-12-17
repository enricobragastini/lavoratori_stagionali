import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/app/app.dart';
import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
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
          child: const Icon(Icons.logout),
          tooltip: "Logout",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const CustomAlertDialog());
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      body: IndexedStack(
        index:
            context.select((HomeCubit cubit) => cubit.state.selectedTab).index,
        children: const [Page1(), Page2()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) {
          _tabIndex = index;
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Workers"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Aggiungi")
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.redAccent,
        body: Center(
          child: Text(
            "Page 1",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
          child: Text(
        "Page 2",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      )),
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
