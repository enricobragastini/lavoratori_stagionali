import "package:flutter/material.dart";
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/worker_card.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 10),
                      child: Text(
                        "ELENCO LAVORATORI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        child: ListView(
                      children: [
                        for (final worker in state.workers)
                          WorkerCard(
                            name: worker.firstname,
                            surname: worker.lastname,
                            email: worker.email,
                            telephone: worker.phone,
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
        ));
  }
}
