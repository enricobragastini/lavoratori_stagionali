import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workers_repository/workers_repository.dart';

import '../../bloc/create_bloc.dart';
import '../widgets/CustomTextFormField.dart';

class WorkExperiencesBox extends StatelessWidget {
  const WorkExperiencesBox({Key? key, required this.onAdd, required this.list})
      : super(key: key);

  final void Function(WorkExperience) onAdd;
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
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 1.5),
            color: Colors.white,
          ),
          child: Box(list: list),
        ),
      ],
    );
  }
}

class Box extends StatelessWidget {
  const Box({super.key, required this.list});

  final List<WorkExperience> list;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Nessuna esperienza aggiunta.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              )
            ],
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(child: Text(index.toString())),
                    title: Text(
                      list[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(list[index].companyName),
                    trailing: const Icon(Icons.delete),
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
                WorkExperience exp = WorkExperience(
                    title: titleController.text,
                    companyName: companyNameController.text,
                    start: DateFormat("dd/MM/yyyy")
                        .parse(startPeriodController.text),
                    end: DateFormat("dd/MM/yyyy")
                        .parse(endPeriodController.text),
                    tasks: tasksController.text.split(';'),
                    notes: notesController.text);
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
                    textFormFieldKey: _tasksKey,
                    labelText: "Incarichi (separati da punto e virgola)*",
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
