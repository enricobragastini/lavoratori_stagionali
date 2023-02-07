import "package:flutter/material.dart";
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/worker_card.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GalleryBloc, GalleryState>(
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
          Navigator.of(context).pop();
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
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("ELENCO LAVORATORI"),
            centerTitle: true,
          ),
          body: Center(
            child: BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  constraints: const BoxConstraints(maxWidth: 1400),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                          child: ListView(
                        children: [
                          for (final worker in state.workers)
                            WorkerCard(
                              worker: worker,
                              onDelete: () => context
                                  .read<GalleryBloc>()
                                  .add(WorkerDeleteRequested(worker: worker)),
                            )
                        ],
                      ))
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
