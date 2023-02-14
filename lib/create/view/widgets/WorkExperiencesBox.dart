import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workers_repository/workers_repository.dart';

import '../../bloc/create_bloc.dart';
import 'customTextFormField.dart';

class WorkExperiencesBox extends StatelessWidget {
  const WorkExperiencesBox(
      {Key? key,
      required this.onAdd,
      required this.onDelete,
      required this.list})
      : super(key: key);

  final void Function(WorkExperience) onAdd;
  final void Function(WorkExperience) onDelete;
  final List<WorkExperience> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ExperienceDialog(),
                ).then((workExperience) {
                  if (workExperience != null) {
                    onAdd(workExperience);
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
                      "Aggiungi Esperienza",
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
          height: 400,
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

  final List<WorkExperience> list;
  final void Function(WorkExperience) onAdd;
  final void Function(WorkExperience) onDelete;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat("dd/MM/yyyy");
    return list.isEmpty
        ? GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => ExperienceDialog(),
            ).then(
              (workExperience) {
                if (workExperience != null) {
                  onAdd(workExperience);
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
                    "Aggiungi una esperienza",
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
                            onTap: () {
                              // TODO: Aggiungere modifica WorkExperience
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "presso: ${list[index].companyName}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Luogo di lavoro: ${list[index].workplace}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Dal ${dateFormatter.format(list[index].start)} al ${dateFormatter.format(list[index].end)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Paga Lorda giornaliera: €${(list[index].dailyPay)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Mansioni: ${list[index].tasks.toString().substring(1, list[index].tasks.toString().length - 1)}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                if (list[index].notes.isNotEmpty)
                                  Text(
                                    "Note: ${list[index].notes}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
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

class ExperienceDialog extends StatelessWidget {
  ExperienceDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _titleKey = GlobalKey<FormFieldState>();
  final _companyNameKey = GlobalKey<FormFieldState>();
  final _startPeriodKey = GlobalKey<FormFieldState>();
  final _endPeriodKey = GlobalKey<FormFieldState>();
  final _dailyPayKey = GlobalKey<FormFieldState>();
  final _workplaceKey = GlobalKey<FormFieldState>();
  final _tasksKey = GlobalKey<FormFieldState>();
  final _notesKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: "");
    TextEditingController companyNameController =
        TextEditingController(text: "");
    TextEditingController startPeriodController =
        TextEditingController(text: "");
    TextEditingController endPeriodController = TextEditingController(text: "");
    TextEditingController dailyPayController = TextEditingController(text: "");
    TextEditingController workplaceController = TextEditingController(text: "");
    TextEditingController tasksController = TextEditingController(text: "");
    TextEditingController notesController = TextEditingController(text: "");

    return AlertDialog(
      title: const Text(
        "Aggiungi una nuova Esperienza Lavorativa",
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
                String tasks = tasksController.text.trim();
                if (tasks.endsWith(";")) {
                  tasks = tasksController.text
                      .substring(0, tasksController.text.length - 1);
                }
                WorkExperience exp = WorkExperience(
                    title: titleController.text.trim(),
                    companyName: companyNameController.text.trim(),
                    start: DateFormat("dd/MM/yyyy")
                        .parse(startPeriodController.text.trim()),
                    end: DateFormat("dd/MM/yyyy")
                        .parse(endPeriodController.text.trim()),
                    dailyPay: double.parse(dailyPayController.text.trim()),
                    workplace: workplaceController.text.trim(),
                    tasks: tasks
                        .trim()
                        .split(';')
                        .where((element) => (element.isNotEmpty))
                        .toList()
                      ..forEach((element) => element.trim()),
                    notes: notesController.text.trim());
                Navigator.of(context).pop(exp);
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
                    textFormFieldKey: _titleKey,
                    labelText: "Titolo / Qualifica*",
                    textFormFieldController: titleController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _titleKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio.";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _companyNameKey,
                    labelText: "Nome Azienda*",
                    textFormFieldController: companyNameController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _companyNameKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio.";
                      }
                      return null;
                    },
                  ),
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
                  CustomTextFormField(
                    textFormFieldKey: _dailyPayKey,
                    textFormFieldController: dailyPayController,
                    labelText: "Paga Lorda Giornaliera (in Euro)*",
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _dailyPayKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio.";
                      }
                      value = value.replaceAll(',', '.');
                      const pattern = r'^[0-9]+(?:[.][0-9]+)?$';
                      if (!RegExp(pattern).hasMatch(value)) {
                        return "Inserire un valore numerico valido.";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _workplaceKey,
                    textFormFieldController: workplaceController,
                    labelText: "Luogo di lavoro*",
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _workplaceKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio.";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _tasksKey,
                    labelText: "Mansioni (separate da punto e virgola)*",
                    textFormFieldController: tasksController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _tasksKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio.";
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _notesKey,
                    labelText: "Note",
                    textFormFieldController: notesController,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
