import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:age_calculator/age_calculator.dart';

import 'package:workers_repository/workers_repository.dart';

class WorkerCard extends StatelessWidget {
  const WorkerCard(
      {Key? key,
      required this.worker,
      required this.onTap,
      required this.onDelete})
      : super(key: key);

  final Worker worker;

  final void Function() onTap;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    List<String> initials = [];

    for (String s in worker.firstname.split(" ")) {
      if (s.isNotEmpty) {
        initials.add(s[0]);
      }
    }
    for (String s in worker.lastname.split(" ")) {
      if (s.isNotEmpty) {
        initials.add(s[0]);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        constraints:
            BoxConstraints(maxWidth: constraints.maxWidth < 1600 ? 800 : 700),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        minRadius: 40,
                        child: Text(
                          initials.join(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${worker.firstname} ${worker.lastname}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        _TinyTextWithIcon(
                            text: worker.email, icon: Icons.email),
                        _TinyTextWithIcon(
                            text: worker.phone, icon: Icons.phone),
                        _TinyTextWithIcon(
                          text:
                              "Nato/a il ${DateFormat('dd/MM/yyyy').format(worker.birthday)} (${AgeCalculator.age(worker.birthday).years} anni) a ${worker.birthplace}",
                          icon: Icons.cake,
                        ),
                        _TinyTextWithIcon(
                            text:
                                "Lingue parlate: ${worker.languages.toString().replaceAll('[', '').replaceAll(']', '')}",
                            icon: Icons.language),
                        _TinyTextWithIcon(
                            text:
                                "Patente di guida: ${worker.licenses.toString().replaceAll('[', '').replaceAll(']', '')}",
                            icon: Icons.drive_eta),
                        _TinyTextWithIcon(
                            text:
                                "${worker.workExperiences.length} Esperienze lavorative",
                            icon: Icons.work),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: onDelete, icon: const Icon(Icons.delete))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TinyTextWithIcon extends StatelessWidget {
  const _TinyTextWithIcon({Key? key, required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
