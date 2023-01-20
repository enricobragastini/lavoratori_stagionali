import 'package:flutter/material.dart';

class WorkerCard extends StatelessWidget {
  const WorkerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    minRadius: 40,
                    child: Text(
                      "MMD",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Matteo Messina Denaro",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Icon(Icons.edit)
            ],
          ),
        ),
      ),
    );
  }
}
