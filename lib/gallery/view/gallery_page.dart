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
      child: Scaffold(
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
                      bottomLeft: Radius.circular(searchContainerBorderRadius),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SearchBar(
                              hintText: "Cerca",
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.expand_more),
                                onPressed: () {},
                              ),
                              onChanged: (search) => context
                                  .read<GalleryBloc>()
                                  .add(KeywordsUpdated(keywords: search))),
                        ),
                        // const Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                        //   child: FiltersBox(),
                        // )
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            constraints: const BoxConstraints(maxWidth: 800),
                            width: double.infinity,
                            height: double.infinity,
                            child: ListView.builder(
                              itemCount: state.filteredWorkers.length,
                              itemBuilder: (context, index) => WorkerCard(
                                worker: state.filteredWorkers[index],
                                onTap: () => context
                                    .read<HomeCubit>()
                                    .editWorker(state.filteredWorkers[index]),
                                onDelete: () => context.read<GalleryBloc>().add(
                                    WorkerDeleteRequested(
                                        worker: state.filteredWorkers[index])),
                              ),
                            ));
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
          )),
    );
  }
}
