import 'package:flutter/material.dart';
import 'package:workers_repository/workers_repository.dart'
    show EmergencyContact;

import '../widgets/CustomTextFormField.dart';

class EmergencyContactsBox extends StatelessWidget {
  const EmergencyContactsBox(
      {Key? key,
      required this.onAdd,
      required this.onDelete,
      required this.list})
      : super(key: key);

  final void Function(EmergencyContact) onAdd;
  final void Function(EmergencyContact) onDelete;
  final List<EmergencyContact> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => ExperienceDialog(),
                ).then((emergencyContact) {
                  if (emergencyContact != null) {
                    onAdd(emergencyContact);
                  }
                }),
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 190, 0, 0)),
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
                      "Aggiungi Contatto di Emergenza",
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
                color: const Color.fromARGB(255, 190, 0, 0), width: 1.5),
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

  final List<EmergencyContact> list;
  final void Function(EmergencyContact) onAdd;
  final void Function(EmergencyContact) onDelete;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => ExperienceDialog(),
            ).then(
              (emergencyContact) {
                if (emergencyContact != null) {
                  onAdd(emergencyContact);
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
                    "Aggiungi un contatto di emergenza",
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
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(255, 190, 0, 0),
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
                                  "${list[index].firstname} ${list[index].lastname}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.email),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        list[index].email,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        list[index].phone,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ],
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
    TextEditingController firstnameController = TextEditingController(text: "");
    TextEditingController lastnameController = TextEditingController(text: "");
    TextEditingController emailController = TextEditingController(text: "");
    TextEditingController phoneController = TextEditingController(text: "");

    return AlertDialog(
      title: const Text(
        "Aggiungi un Contatto di Emergenza",
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
                EmergencyContact exp = EmergencyContact(
                  firstname: firstnameController.text.trim(),
                  lastname: lastnameController.text.trim(),
                  phone: phoneController.text.trim(),
                  email: emailController.text.trim(),
                );
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
                    labelText: "Nome*",
                    textFormFieldController: firstnameController,
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
                    labelText: "Cognome*",
                    textFormFieldController: lastnameController,
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
                    labelText: "Email*",
                    textFormFieldController: emailController,
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
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Inserire una email valida';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    textFormFieldKey: _endPeriodKey,
                    labelText: "Telefono*",
                    textFormFieldController: phoneController,
                    onFocusChangeAction: (focus) {
                      if (!focus) {
                        _endPeriodKey.currentState!.validate();
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Questo è un campo obbligatorio";
                      }
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Inserire un numero di telefono valido';
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
