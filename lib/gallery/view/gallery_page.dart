import "package:flutter/material.dart";
import 'package:lavoratori_stagionali/gallery/view/widgets/worker_card.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => const WorkerCard(),
                ))
              ],
            ),
          ),
        ));
  }
}
