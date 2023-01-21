import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              constraints: const BoxConstraints(maxWidth: 900),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0, top: 10),
                    child: Text(
                      "AGGIUNGI UN NUOVO LAVORATORE",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                      child: Wrap(
                    runAlignment: WrapAlignment.center,
                    runSpacing: 15,
                    children: [
                      TextFormField(
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
                      TextFormField(
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
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Telefono*",
                        ),
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
                      TextFormField(
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
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Data di Nascita (gg/mm/aaaa)*",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Questo è un campo obbligatorio";
                          }
                          try {
                            DateFormat('dd/MM/yyyy').parse(value);
                          } catch (e) {
                            return 'Inserire una data valida';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
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
                      TextFormField(
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
                      TextFormField(
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
                      )
                    ],
                  ))
                ],
              ))),
    );
  }
}
