import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter_bloc/flutter_bloc.dart";
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
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    constraints: const BoxConstraints(maxWidth: 900),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0, top: 10),
                          child: Text(
                            "AGGIUNGI UN NUOVO LAVORATORE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Wrap(
                              runAlignment: WrapAlignment.center,
                              runSpacing: 15,
                              children: [
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _firstnameKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          FirstNameChanged(
                                              firstname:
                                                  firstnameController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _firstnameKey,
                                    controller: firstnameController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Nome*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _lastnameKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          LastNameChanged(
                                              lastname:
                                                  lastnameController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _lastnameKey,
                                    controller: lastnameController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Cognome*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _phoneKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          PhoneChanged(
                                              phone: phoneController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _phoneKey,
                                    controller: phoneController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Telefono*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      String pattern =
                                          r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                      RegExp regExp = RegExp(pattern);
                                      if (!regExp.hasMatch(value)) {
                                        return 'Inserire un numero di telefono valido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _emailKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          EmailChanged(
                                              email: emailController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _emailKey,
                                    controller: emailController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Email*",
                                    ),
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
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _birthdayKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          BirthDayChanged(
                                              birthday:
                                                  birthdayController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _birthdayKey,
                                    controller: birthdayController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText:
                                          "Data di Nascita (gg/mm/aaaa)*",
                                    ),
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
                                ),
                                Focus(
                                  onFocusChange: ((focus) {
                                    if (!focus) {
                                      _birthplaceKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          BirthPlaceChanged(
                                              birthplace:
                                                  birthplaceController.text));
                                    }
                                  }),
                                  child: TextFormField(
                                    key: _birthplaceKey,
                                    controller: birthplaceController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Luogo di Nascita*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _nationalityKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          NationalityChanged(
                                              nationality:
                                                  nationalityController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _nationalityKey,
                                    controller: nationalityController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText: "Nazionalità*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Focus(
                                  onFocusChange: (focus) {
                                    if (!focus) {
                                      _addressKey.currentState!.validate();
                                      context.read<CreateBloc>().add(
                                          AddressChanged(
                                              address: addressController.text));
                                    }
                                  },
                                  child: TextFormField(
                                    key: _addressKey,
                                    controller: addressController,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      labelText:
                                          "Indirizzo (Via/Piazza, Comune, Città, CAP)*",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Questo è un campo obbligatorio";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
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
                    ))),
          );
        },
      ),
    );
  }
}
