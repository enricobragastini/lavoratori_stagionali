import "package:flutter/material.dart";
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/filters_box.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/search_bar.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/worker_card.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';

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
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.only(
                          bottomLeft:
                              Radius.circular(searchContainerBorderRadius),
                          bottomRight:
                              Radius.circular(searchContainerBorderRadius)),
                      child: Container(
                        // height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 200),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "CERCA",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SearchBar(
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
                            ),
                            if (state.showFilters)
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 20),
                                  child: FiltersBox(
                                    allLanguages: state.allLanguages,
                                    selectedLanguages: state.selectedLanguages,
                                    onLanguageToggled: (language) => context
                                        .read<GalleryBloc>()
                                        .add(LanguageToggled(
                                            language: language)),
                                    allLicences: state.allLicences,
                                    selectedLicences: state.selectedLicences,
                                    onLicenceToggled: (licence) => context
                                        .read<GalleryBloc>()
                                        .add(LicenceToggled(licence: licence)),
                                    allLocations: state.allLocations,
                                    selectedLocations: state.selectedLocations,
                                    onLocationToggled: (location) => context
                                        .read<GalleryBloc>()
                                        .add(LocationToggled(
                                            location: location)),
                                    allTasks: state.allTasks,
                                    selectedTasks: state.selectedTasks,
                                    onTaskToggled: (task) => context
                                        .read<GalleryBloc>()
                                        .add(TaskToggled(task: task)),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: BlocBuilder<GalleryBloc, GalleryState>(
                        builder: (context, state) {
                          if (state.filteredWorkers.isNotEmpty) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              constraints: const BoxConstraints(maxWidth: 1800),
                              width: double.infinity,
                              height: double.infinity,
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
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 100.0),
                              child: Text(
                                "La tua ricerca non ha prodotto risultati!",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 100.0),
                              child: Text(
                                "Nessun lavoratore presente in anagrafica\nAggiungine uno!",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
