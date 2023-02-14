import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:lavoratori_stagionali/create/view/form_assets.dart';
import 'package:lavoratori_stagionali/create/view/widgets/CustomTextFormField.dart';
import 'package:lavoratori_stagionali/create/view/widgets/EmergencyContactsBox.dart';
import 'package:lavoratori_stagionali/create/view/widgets/LocationsBox.dart';
import 'package:lavoratori_stagionali/create/view/widgets/PeriodsBox.dart';
import 'package:lavoratori_stagionali/create/view/widgets/WorkExperiencesBox.dart';
import 'package:lavoratori_stagionali/home/cubit/home_cubit.dart';
import 'package:lavoratori_stagionali/app/bloc/app_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:workers_repository/workers_repository.dart' show Worker;

import "../bloc/create_bloc.dart";

class CreatePage extends StatelessWidget {
  CreatePage({Key? key, this.toEdit}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _firstnameKey = GlobalKey<FormFieldState>();
  final _lastnameKey = GlobalKey<FormFieldState>();
  final _birthdayKey = GlobalKey<FormFieldState>();
  final _birthplaceKey = GlobalKey<FormFieldState>();
  final _nationalityKey = GlobalKey<FormFieldState>();
  final _addressKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();

  final Worker? toEdit;

  @override
  Widget build(BuildContext context) {
    if (toEdit != null) {
      context.read<CreateBloc>().add(WorkerEditRequested(worker: toEdit!));
    }

    return BlocListener<CreateBloc, CreateState>(
      listenWhen: (previous, current) {
        if (previous.status == CreateStatus.loading &&
            current.status != CreateStatus.loading) {
          Navigator.of(context).pop();
        }
        if (previous.status != CreateStatus.initial &&
            current.status == CreateStatus.initial) {
          context.read<HomeCubit>().setTab(HomeTab.page1);
        }
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == CreateStatus.loading) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              });
        } else if (state.status == CreateStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text("C'è stato un errore!"),
              showCloseIcon: true,
              closeIconColor: Colors.white,
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 5000),
            ));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text("AGGIUNGI UN NUOVO LAVORATORE"),
        //   centerTitle: true,
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(
        //             "${context.read<AppBloc>().state.employee.firstname} ${context.read<AppBloc>().state.employee.lastname}",
        //             style: const TextStyle(fontSize: 18),
        //           ),
        //           Text(
        //             context.read<AppBloc>().state.employee.email,
        //             style: const TextStyle(fontSize: 14),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),

                            // NOME
                            CustomTextFormField(
                              labelText: "Nome*",
                              textFormFieldKey: _firstnameKey,
                              textFormFieldController: firstnameController,
                              onFocusChangeAction: (focus) {
                                if (!focus) {
                                  _firstnameKey.currentState!.validate();
                                  context.read<CreateBloc>().add(
                                      // Genera evento
                                      FirstNameChanged(
                                          firstname:
                                              firstnameController.text.trim()));
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
                                  context.read<CreateBloc>().add(
                                      LastNameChanged(
                                          lastname:
                                              lastnameController.text.trim()));
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
                                  context.read<CreateBloc>().add(PhoneChanged(
                                      phone: phoneController.text.trim()));
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
                                  context.read<CreateBloc>().add(EmailChanged(
                                      email: emailController.text.trim()));
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
                                  context.read<CreateBloc>().add(
                                      BirthDayChanged(
                                          birthday:
                                              birthdayController.text.trim()));
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
                                          birthplace: birthplaceController.text
                                              .trim()));
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
                                          nationality: nationalityController
                                              .text
                                              .trim()));
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
                                      address: addressController.text.trim()));
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                constraints:
                                    const BoxConstraints(maxWidth: 700),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 1.5)),
                                child: MultiSelectDialogField(
                                  initialValue: state.languages,
                                  items: FormAssets.languages
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                constraints:
                                    const BoxConstraints(maxWidth: 700),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 1.5)),
                                child: MultiSelectDialogField(
                                  initialValue: state.licenses,
                                  items: FormAssets.licenses
                                      .map((e) => MultiSelectItem(e, e))
                                      .toList(),
                                  listType: MultiSelectListType.LIST,
                                  onConfirm: (selected) {
                                    selected.sort();
                                    context.read<CreateBloc>().add(
                                        LicensesEdited(licenses: selected));
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
                                    TextStyle(
                                        fontSize: 18.0, color: Colors.white)
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
                                  "Esperienze lavorative passate",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.0),
                              child: Divider(
                                thickness: 3,
                              ),
                            ),

                            // PERIODI e COMUNI
                            const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Disponibilità: Quando e Dove",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 700),
                                child: LocationsBox(
                                  list: state.locations,
                                  onAdd: (location) => context
                                      .read<CreateBloc>()
                                      .add(LocationAdded(location: location)),
                                  onDelete: (location) => context
                                      .read<CreateBloc>()
                                      .add(LocationDeleted(location: location)),
                                ),
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 700),
                                child: PeriodsBox(
                                  list: state.periods,
                                  onAdd: (period) => context
                                      .read<CreateBloc>()
                                      .add(PeriodAdded(period: period)),
                                  onDelete: (period) => context
                                      .read<CreateBloc>()
                                      .add(PeriodDeleted(period: period)),
                                ),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.0),
                              child: Divider(
                                thickness: 3,
                              ),
                            ),

                            // CONTATTI DI EMERGENZA
                            const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Contatti di Emergenza",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),

                            Container(
                              constraints: const BoxConstraints(maxWidth: 700),
                              child: EmergencyContactsBox(
                                list: state.emergencyContacts,
                                onAdd: (emergencyContact) => context
                                    .read<CreateBloc>()
                                    .add(EmergencyContactAdded(
                                        emergencyContact: emergencyContact)),
                                onDelete: (emergencyContact) => context
                                    .read<CreateBloc>()
                                    .add(EmergencyContactDeleted(
                                        emergencyContact: emergencyContact)),
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
                                    child: Text(toEdit != null
                                        ? "APPLICA MODIFICHE"
                                        : "SALVA")),
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
      ),
    );
  }
}
