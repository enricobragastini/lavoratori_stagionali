import "package:flutter/material.dart";
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/filters_box.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/search_bar.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/worker_card.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';
import 'package:lavoratori_stagionali/app/bloc/app_bloc.dart';

import 'package:filter/filter.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double searchContainerBorderRadius = 40;

    return BlocListener<GalleryBloc, GalleryState>(
      listenWhen: (previous, current) {
        if (previous.status == GalleryStatus.loading &&
            current.status != GalleryStatus.loading) {
          Navigator.of(context).pop();
        }
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == GalleryStatus.loading) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              });
        } else if (state.status == GalleryStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text("ERROR: ${state.errorMessage!}"),
              // backgroundColor: Theme.of(context).colorScheme.primary,
              showCloseIcon: true,
              closeIconColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(milliseconds: 5000),
            ));
        }
      },
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("ELENCO LAVORATORI"),
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
              body: Center(
                child: ListView(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(searchContainerBorderRadius)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.width < 1600)
                              ? 100
                              : 200,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "CERCA",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SearchBar(
                                  hintText: "Cerca",
                                  suffixIcon: IconButton(
                                    icon: Icon(state.showFilters
                                        ? Icons.expand_less
                                        : Icons.expand_more),
                                    tooltip: state.showFilters
                                        ? "Nascondi filtri"
                                        : "Visualizza filtri",
                                    onPressed: () => context
                                        .read<GalleryBloc>()
                                        .add(ShowFiltersChanged(
                                            showFilters: !state.showFilters)),
                                  ),
                                  onChanged: (search) => context
                                      .read<GalleryBloc>()
                                      .add(KeywordsUpdated(keywords: search))),
                              if (state.showFilters)
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 20),
                                    child: FiltersBox(
                                      allLanguages: state.allLanguages,
                                      selectedLanguages:
                                          state.selectedLanguages,
                                      onLanguageToggled: (language) => context
                                          .read<GalleryBloc>()
                                          .add(LanguageToggled(
                                              language: language)),
                                      allLicences: state.allLicences,
                                      selectedLicences: state.selectedLicences,
                                      onLicenceToggled: (licence) => context
                                          .read<GalleryBloc>()
                                          .add(
                                              LicenceToggled(licence: licence)),
                                      withOwnCar: state.filter.withOwnCar,
                                      withOwnCarToggled: (value) => context
                                          .read<GalleryBloc>()
                                          .add(WithOwnCarToggled(value: value)),
                                      allLocations: state.allLocations,
                                      selectedLocations:
                                          state.selectedLocations,
                                      onLocationToggled: (location) => context
                                          .read<GalleryBloc>()
                                          .add(LocationToggled(
                                              location: location)),
                                      allTasks: state.allTasks,
                                      selectedTasks: state.selectedTasks,
                                      onTaskToggled: (task) => context
                                          .read<GalleryBloc>()
                                          .add(TaskToggled(task: task)),
                                      allPeriods: state.filter.periods,
                                      onAddPeriod: (period) => context
                                          .read<GalleryBloc>()
                                          .add(PeriodAdded(period: period)),
                                      onDeletePeriod: (period) => context
                                          .read<GalleryBloc>()
                                          .add(PeriodDeleted(period: period)),
                                      searchMode: state.searchMode,
                                      searchModeToggled: (searchMode) => context
                                          .read<GalleryBloc>()
                                          .add(SearchModeToggled(
                                              searchMode: searchMode)),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<GalleryBloc, GalleryState>(
                      builder: (context, state) {
                        if (state.filteredWorkers.isNotEmpty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            constraints: const BoxConstraints(maxWidth: 1800),
                            width: double.infinity,
                            // height: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                for (final worker in state.filteredWorkers)
                                  WorkerCard(
                                    worker: worker,
                                    onTap: () => context
                                        .read<HomeCubit>()
                                        .editWorker(worker),
                                    onDelete: () => context
                                        .read<GalleryBloc>()
                                        .add(WorkerDeleteRequested(
                                            worker: worker)),
                                  )
                              ],
                            ),
                          );
                        } else if (state.filteredWorkers.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 100.0),
                              child: Text(
                                "La tua ricerca non ha prodotto risultati!",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 100.0),
                              child: Text(
                                "Nessun lavoratore presente in anagrafica\nAggiungine uno!",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
