import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workers_repository/workers_repository.dart';

import 'customTextFormField.dart';

class PeriodsBox extends StatelessWidget {
  const PeriodsBox(
      {Key? key,
      required this.onAdd,
      required this.onDelete,
      required this.list})
      : super(key: key);

  final void Function(Period) onAdd;
  final void Function(Period) onDelete;
  final List<Period> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => PeriodsDialog(),
                ).then((period) {
                  if (period != null) {
                    onAdd(period);
                  }
                }),
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    size: 30,
                  ),
                  Center(
                    child: Text(
                      "Aggiungi Periodo",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1.5),
            color: Colors.black12,
          ),
          child: Box(
            list: list,
            onAdd: onAdd,
            onDelete: onDelete,
          ),
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  const Box(
      {super.key,
      required this.list,
      required this.onAdd,
      required this.onDelete});

  final List<Period> list;
  final void Function(Period) onAdd;
  final void Function(Period) onDelete;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat("dd/MM/yyyy");
    return list.isEmpty
        ? GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => PeriodsDialog(),
            ).then(
              (period) {
                if (period != null) {
                  onAdd(period);
                }
              },
            ),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_circle_outline, size: 60),
                  Text(
                    "Aggiungi un periodo",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            child: Text((index + 1).toString()),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 8,
                          child: GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Periodo dal ${dateFormatter.format(list[index].start)} al ${dateFormatter.format(list[index].end)}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () => onDelete(list[index]),
                                icon: const Icon(Icons.delete)))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class PeriodsDialog extends StatelessWidget {
  PeriodsDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _startPeriodKey = GlobalKey<FormFieldState>();
  final _endPeriodKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController startPeriodController = TextEditingController(
        text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
    TextEditingController endPeriodController = TextEditingController(text: "");

    return AlertDialog(
      title: const Text(
        "Aggiungi un periodo",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Annulla",
              style: TextStyle(fontSize: 18),
            )),
        TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop(Period(
                    start: DateFormat("dd/MM/yyyy")
                        .parse(startPeriodController.text.trim()),
                    end: DateFormat("dd/MM/yyyy")
                        .parse(endPeriodController.text.trim())));
              }
            },
            child: const Text(
              "Salva",
              style: TextStyle(fontSize: 18),
            )),
      ],
      actionsPadding: const EdgeInsets.only(bottom: 15, right: 15),
      content: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  CustomTextFormField(
                    textFormFieldKey: _startPeriodKey,
                    labelText: "Data di Inizio (dd/mm/yyyy)*",
                    textFormFieldController: startPeriodController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _startPeriodKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio";
                      }
                      String pattern =
                          "^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\\/)\\d{4}\$";
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Inserire una data valida (dd/mm/yyyy)';
                      }
                      try {
                        DateFormat('dd/MM/yyyy').parse(value);
                      } catch (e) {
                        return 'Inserire una data valida (dd/mm/yyyy)';
                      }
                      if (DateFormat('dd/MM/yyyy').parse(value).isBefore(
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day))) {
                        return "La data di inizio non può essere prima di oggi";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _endPeriodKey,
                    labelText: "Data di Fine(dd/mm/yyyy)*",
                    textFormFieldController: endPeriodController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _endPeriodKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio";
                      }
                      String pattern =
                          "^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\\/)\\d{4}\$";
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Inserire una data valida (dd/mm/yyyy)';
                      }
                      try {
                        DateFormat('dd/MM/yyyy').parse(value);
                      } catch (e) {
                        return 'Inserire una data valida (dd/mm/yyyy)';
                      }
                      if (DateFormat('dd/MM/yyyy').parse(value).isBefore(
                          DateFormat('dd/MM/yyyy')
                              .parse(startPeriodController.text))) {
                        return "La Data di Fine non può essere prima della Data di Inizio!";
                      }
                      return null;
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
