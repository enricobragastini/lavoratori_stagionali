import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:workers_repository/workers_repository.dart' show Period;

class PeriodSelectorWidget extends StatelessWidget {
  const PeriodSelectorWidget(
      {super.key,
      required this.title,
      required this.list,
      required this.tooltip,
      required this.onAdd,
      required this.onDelete});

  final String title;
  final List<Period> list;
  final String tooltip;
  final void Function(Period) onAdd;
  final void Function(Period) onDelete;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  for (final element in list)
                    SizedBox(
                      child: InputChip(
                        label: Text(
                          "Dal ${dateFormat.format(element.start)} a ${dateFormat.format(element.end)}",
                        ),
                        selected: false,
                        onPressed: () {},
                        onDeleted: () => onDelete(element),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 13),
                      ),
                    ),
                  Tooltip(
                    message: "Aggiungi periodo",
                    child: RawMaterialButton(
                      elevation: 1,
                      fillColor: Theme.of(context).colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      constraints:
                          const BoxConstraints.expand(width: 42, height: 42),
                      shape: const CircleBorder(),
                      onPressed: () async {
                        final DateTimeRange? result = await showDateRangePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030, 12, 31),
                          currentDate: DateTime.now(),
                          helpText: 'SELEZIONA PERIODO',
                          fieldStartHintText: 'Data di inizio',
                          fieldEndLabelText: 'Data di inizio',
                          fieldEndHintText: 'Data di fine',
                          fieldStartLabelText: 'Data di fine',
                          saveText: 'Fatto',
                          builder: (context, child) => Padding(
                              padding: const EdgeInsets.all(100.0),
                              child: child),
                        );

                        if (result != null) {
                          onAdd(Period(start: result.start, end: result.end));
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Ink(
                  //     decoration: ShapeDecoration(
                  //         color: Theme.of(context).colorScheme.primary,
                  //         shape: const CircleBorder()),
                  //     child: IconButton(
                  //       icon: const Icon(Icons.add),
                  //       iconSize: 17,
                  //       color: Colors.white,
                  //       tooltip: tooltip,
                  //       onPressed: () async {
                  //         final DateTimeRange? result =
                  //             await showDateRangePicker(
                  //           context: context,
                  //           initialEntryMode: DatePickerEntryMode.calendarOnly,
                  //           firstDate: DateTime.now(),
                  //           lastDate: DateTime(2030, 12, 31),
                  //           currentDate: DateTime.now(),
                  //           helpText: 'SELEZIONA PERIODO',
                  //           fieldStartHintText: 'Data di inizio',
                  //           fieldEndLabelText: 'Data di inizio',
                  //           fieldEndHintText: 'Data di fine',
                  //           fieldStartLabelText: 'Data di fine',
                  //           saveText: 'Fatto',
                  //           builder: (context, child) => Padding(
                  //               padding: const EdgeInsets.all(100.0),
                  //               child: child),
                  //         );

                  //         if (result != null) {
                  //           onAdd(Period(start: result.start, end: result.end));
                  //         }
                  //       },
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 15, vertical: 13),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
