import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:lavoratori_stagionali/create/view/widgets/CustomTextFormField.dart';
import 'package:lavoratori_stagionali/create/view/widgets/WorkExperiencesBox.dart';
import 'package:textfield_tags/textfield_tags.dart';

import "../bloc/create_bloc.dart";

class CreatePage extends StatelessWidget {
  CreatePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _firstnameKey = GlobalKey<FormFieldState>();
  final _lastnameKey = GlobalKey<FormFieldState>();
  final _birthdayKey = GlobalKey<FormFieldState>();
  final _birthplaceKey = GlobalKey<FormFieldState>();
  final _nationalityKey = GlobalKey<FormFieldState>();
  final _addressKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Aggiungi un nuovo lavoratore"),
        centerTitle: true,
      ),
      body: BlocBuilder<CreateBloc, CreateState>(
        builder: (context, state) {
          TextEditingController firstnameController =
              TextEditingController(text: state.firstname);
          TextEditingController lastnameController =
              TextEditingController(text: state.lastname);
          TextEditingController birthdayController =
              TextEditingController(text: state.birthday);
          TextEditingController birthplaceController =
              TextEditingController(text: state.birthplace);
          TextEditingController nationalityController =
              TextEditingController(text: state.nationality);
          TextEditingController addressController =
              TextEditingController(text: state.address);
          TextEditingController phoneController =
              TextEditingController(text: state.phone);
          TextEditingController emailController =
              TextEditingController(text: state.email);

          return Center(
            child: Container(
              height: double.infinity,
              constraints: const BoxConstraints(maxWidth: 900),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        children: [
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Dati Anagrafici",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),

// NOME
                          CustomTextFormField(
                            labelText: "Nome*",
                            textFormFieldKey: _firstnameKey,
                            textFormFieldController: firstnameController,
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _firstnameKey.currentState!.validate();
                                context.read<CreateBloc>().add(FirstNameChanged(
                                    firstname: firstnameController.text));
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Questo è un campo obbligatorio";
                              }
                              return null;
                            },
                          ),

// COGNOME
                          CustomTextFormField(
                            labelText: "Cognome*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _lastnameKey.currentState!.validate();
                                context.read<CreateBloc>().add(LastNameChanged(
                                    lastname: lastnameController.text));
                              }
                            },
                            textFormFieldKey: _lastnameKey,
                            textFormFieldController: lastnameController,
                            onChangedAction: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Questo è un campo obbligatorio";
                              }
                              return null;
                            },
                          ),

// TELEFONO
                          CustomTextFormField(
                            labelText: "Telefono*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _phoneKey.currentState!.validate();
                                context.read<CreateBloc>().add(
                                    PhoneChanged(phone: phoneController.text));
                              }
                            },
                            textFormFieldKey: _phoneKey,
                            textFormFieldController: phoneController,
                            onChangedAction: (value) {},
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

// EMAIl
                          CustomTextFormField(
                            labelText: "Email*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _emailKey.currentState!.validate();
                                context.read<CreateBloc>().add(
                                    EmailChanged(email: emailController.text));
                              }
                            },
                            textFormFieldKey: _emailKey,
                            textFormFieldController: emailController,
                            onChangedAction: (value) {},
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

// DATA NASCITA
                          CustomTextFormField(
                            labelText: "Data di Nascita (gg/mm/aaaa)*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _birthdayKey.currentState!.validate();
                                context.read<CreateBloc>().add(BirthDayChanged(
                                    birthday: birthdayController.text));
                              }
                            },
                            textFormFieldKey: _birthdayKey,
                            textFormFieldController: birthdayController,
                            onChangedAction: (value) {},
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

// LUOGO DI NASCITA
                          CustomTextFormField(
                            onFocusChangeAction: ((focus) {
                              if (!focus) {
                                _birthplaceKey.currentState!.validate();
                                context.read<CreateBloc>().add(
                                    BirthPlaceChanged(
                                        birthplace: birthplaceController.text));
                              }
                            }),
                            textFormFieldKey: _birthplaceKey,
                            textFormFieldController: birthplaceController,
                            onChangedAction: (value) {},
                            labelText: "Luogo di Nascita*",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Questo è un campo obbligatorio";
                              }
                              return null;
                            },
                          ),

// NAZIONALITA
                          CustomTextFormField(
                            labelText: "Nazionalità*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _nationalityKey.currentState!.validate();
                                context.read<CreateBloc>().add(
                                    NationalityChanged(
                                        nationality:
                                            nationalityController.text));
                              }
                            },
                            textFormFieldKey: _nationalityKey,
                            textFormFieldController: nationalityController,
                            onChangedAction: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Questo è un campo obbligatorio";
                              }
                              return null;
                            },
                          ),

// INDIRIZZO
                          CustomTextFormField(
                            labelText:
                                "Indirizzo (Via/Piazza, Comune, Città, CAP)*",
                            onFocusChangeAction: (focus) {
                              if (!focus) {
                                _addressKey.currentState!.validate();
                                context.read<CreateBloc>().add(AddressChanged(
                                    address: addressController.text));
                              }
                            },
                            textFormFieldKey: _addressKey,
                            textFormFieldController: addressController,
                            onChangedAction: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Questo è un campo obbligatorio";
                              }
                              return null;
                            },
                          ),

// DIVIDER
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Divider(
                              thickness: 3,
                            ),
                          ),

// ESPERIENZE LAVORATIVE
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Esperienze lavorative",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),

                          Container(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: WorkExperiencesBox(
                              list: state.workExperiences,
                              onAdd: (workExperience) {
                                context.read<CreateBloc>().add(
                                    WorkExperienceAdded(
                                        workExperience: workExperience));
                              },
                            ),
                          ),

// DIVIDER
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Divider(
                              thickness: 3,
                            ),
                          ),

                          // PULSANTE di SALVATAGGIO
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<CreateBloc>()
                                          .add(const SaveRequested());
                                    }
                                  },
                                  child: const Text("SALVA")),
                            ),
                          ),
                        ],
                      ))
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
