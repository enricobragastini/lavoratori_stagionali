import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:workers_repository/workers_repository.dart';

class LocationsBox extends StatelessWidget {
  const LocationsBox(
      {Key? key,
      required this.onAdd,
      required this.onDelete,
      required this.list})
      : super(key: key);

  final void Function(String) onAdd;
  final void Function(String) onDelete;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) => LocationDialog(),
                ).then((location) {
                  if (location != null) {
                    onAdd(location);
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
                      "Aggiungi Comune",
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

  final List<String> list;
  final void Function(String) onAdd;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => LocationDialog(),
            ).then(
              (location) {
                if (location != null) {
                  onAdd(location);
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
                    "Aggiungi un comune",
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
                                  list[index],
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

class LocationDialog extends StatelessWidget {
  LocationDialog({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  Future<List<String>> comuniFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/comuni.json');
    final data = await json.decode(response);
    final List<String> comuni = [];
    for (final d in data) {
      comuni.add("${d["nome"]} (${d["sigla"]})");
    }
    return comuni;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> comuni = comuniFromJson();

    return FutureBuilder(
      future: comuni,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlertDialog(
            title: const Text(
              "Aggiungi un Comune",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            actions: const [],
            actionsPadding: const EdgeInsets.only(bottom: 15, right: 15),
            content: SizedBox(
              width: 600,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const Text(
                    "Digita il nome di un comune e selezionalo per aggiungerlo alla lista",
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Autocomplete(
                      onSelected: (location) {
                        Navigator.of(context).pop(location);
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        const double optionHeight = 60;
                        const int maxOptions = 5;
                        return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(4.0)),
                                ),
                                child: SizedBox(
                                  width: 600,
                                  height: (options.length < maxOptions)
                                      ? optionHeight * options.length
                                      : optionHeight * maxOptions,
                                  child: ListView.builder(
                                    itemCount: options.length,
                                    shrinkWrap: false,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);
                                      return SizedBox(
                                        height: optionHeight,
                                        child: InkWell(
                                          onTap: () => onSelected(option),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  option,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )));
                      },
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text == "") {
                          return const Iterable<String>.empty();
                        }
                        return snapshot.data!.where(
                          (element) {
                            return element.toLowerCase().startsWith(
                                textEditingValue.text.toLowerCase());
                          },
                        ).toList()
                          ..sort(((a, b) => a.length.compareTo(b.length)));
                      },
                    ),
                  ),
                ],
              )),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Unexpected Error"));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
