import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:lavoratori_stagionali/create/view/widgets/CustomTextFormField.dart';
import 'package:lavoratori_stagionali/create/view/widgets/WorkExperiencesBox.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
    List<String> languages = [
      "Afrikaans",
      "Albanese",
      "Amarico",
      "Arabo",
      "Armeno",
      "Assamese",
      "Aymara",
      "Azero",
      "Bambara",
      "Basco",
      "Bengalese",
      "Bhojpuri",
      "Bielorusso",
      "Birmano",
      "Bosniaco",
      "Bulgaro",
      "Catalano",
      "Cebuano",
      "Ceco",
      "Chichewa",
      "Chirghiso",
      "Ci",
      "Cinese",
      "Coreano",
      "Corso",
      "Creolo haitiano",
      "Croato",
      "Curdo",
      "Danese",
      "Dhivehi",
      "Dogri",
      "Ebraico",
      "Esperanto",
      "Estone",
      "Ewe",
      "Filippino",
      "Finlandese",
      "Francese",
      "Frisone",
      "Gaelico scozzese",
      "Galiziano",
      "Gallese",
      "Georgiano",
      "Giapponese",
      "Giavanese",
      "Greco",
      "Guaraní",
      "Gujarati",
      "Hausa",
      "Hawaiano",
      "Hindi",
      "Hmong",
      "Igbo",
      "Ilocano",
      "Indonesiano",
      "Inglese",
      "Irlandese",
      "Islandese",
      "Italiano",
      "Kannada",
      "Kazako",
      "Khmer",
      "Kinyarwanda",
      "Konkani",
      "Krio",
      "Lao",
      "Latino",
      "Lettone",
      "Lingala",
      "Lituano",
      "Luganda",
      "Lussemburghese",
      "Macedone",
      "Maithili",
      "Malayalam",
      "Malese",
      "Malgascio",
      "Maltese",
      "Maori",
      "Marathi",
      "Meiteilon (Manipuri)",
      "Mizo",
      "Mongolo",
      "Nepalese",
      "Norvegese",
      "Odia (Oriya)",
      "Olandese",
      "Oromo",
      "Pashto",
      "Persiano",
      "Polacco",
      "Portoghese",
      "Punjabi",
      "Quechua",
      "Rumeno",
      "Russo",
      "Samoano",
      "Sanscrito",
      "Sepedi",
      "Serbo",
      "Sesotho",
      "Shona",
      "Sindhi",
      "Singalese",
      "Slovacco",
      "Sloveno",
      "Somalo",
      "Spagnolo",
      "Sundanese",
      "Svedese",
      "Swahili",
      "Tagico",
      "Tamil",
      "Tataro",
      "Tedesco",
      "Telugu",
      "Thai",
      "Tigrino",
      "Tsonga",
      "Turco",
      "Turcomanno",
      "Ucraino",
      "Uiguro",
      "Ungherese",
      "Urdu",
      "Uzbeco",
      "Vietnamita",
      "Xhosa",
      "Yiddish",
      "Yoruba",
      "Zulu",
    ];

    final List<String> licenses = [
      "AM",
      "A1",
      "A2",
      "A",
      "B1",
      "B",
      "BE",
      "C1",
      "C1E",
      "C",
      "CE",
      "D1",
      "D1E",
      "D",
      "DE"
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("AGGIUNGI UN NUOVO LAVORATORE"),
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

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Divider(
                              thickness: 3,
                            ),
                          ),

// LINGUE PARLATE
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Lingue parlate",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(maxWidth: 700),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.5)),
                              child: MultiSelectDialogField(
                                initialValue: state.languages,
                                items: languages
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                listType: MultiSelectListType.LIST,
                                onConfirm: (selected) {
                                  selected.sort();
                                  context.read<CreateBloc>().add(
                                      LanguagesEdited(languages: selected));
                                },
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Divider(
                              thickness: 3,
                            ),
                          ),

// PATENTI DI GUIDA
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Patenti di guida / Automunito",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(maxWidth: 700),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.5)),
                              child: MultiSelectDialogField(
                                initialValue: state.licenses,
                                items: licenses
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                listType: MultiSelectListType.LIST,
                                onConfirm: (selected) {
                                  selected.sort();
                                  context
                                      .read<CreateBloc>()
                                      .add(LicensesEdited(licenses: selected));
                                },
                              ),
                            ),
                          ),

// AUTOMUNITO
                          Container(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Row(children: [
                              const Text(
                                "Automunito: ",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ToggleSwitch(
                                minWidth: 120.0,
                                cornerRadius: 10.0,
                                activeBgColors: [
                                  [Colors.green[800]!],
                                  [Colors.red[800]!]
                                ],
                                customTextStyles: const [
                                  TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                  TextStyle(fontSize: 18.0, color: Colors.white)
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: Colors.grey,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: state.withOwnCar ? 0 : 1,
                                totalSwitches: 2,
                                labels: const ['SI', 'NO'],
                                radiusStyle: false,
                                onToggle: (index) {
                                  context.read<CreateBloc>().add(
                                      WithOwnCarEdited(
                                          withOwnCarEdited: (index == 0)));
                                },
                              ),
                            ]),
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
                              onDelete: (workExperience) {
                                context.read<CreateBloc>().add(
                                    WorkExperienceDeleted(
                                        workExperience: workExperience));
                              },
                            ),
                          ),

// PULSANTE di SALVATAGGIO
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 80),
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
