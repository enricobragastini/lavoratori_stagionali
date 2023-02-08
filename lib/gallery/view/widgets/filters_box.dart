import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/multi_selector_widget.dart';

class FiltersBox extends StatelessWidget {
  const FiltersBox({
    super.key,
    required this.allLanguages,
    required this.selectedLanguages,
    required this.onLanguageToggled,
    required this.allLocations,
    required this.selectedLocations,
    required this.onLocationToggled,
    required this.allLicences,
    required this.selectedLicences,
    required this.onLicenceToggled,
    required this.allTasks,
    required this.selectedTasks,
    required this.onTaskToggled,
  });

  final List<String> allLanguages;
  final List<String> selectedLanguages;
  final void Function(String) onLanguageToggled;

  final List<String> allLocations;
  final List<String> selectedLocations;
  final void Function(String) onLocationToggled;

  final List<String> allLicences;
  final List<String> selectedLicences;
  final void Function(String) onLicenceToggled;

  final List<String> allTasks;
  final List<String> selectedTasks;
  final void Function(String) onTaskToggled;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 10,
      spacing: 10,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              "Filtri",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        MultiSelectorWidget(
          title: "Lingue:",
          list: allLanguages,
          selected: selectedLanguages,
          onAdd: onLanguageToggled,
          onDelete: onLanguageToggled,
        ),
        MultiSelectorWidget(
          title: "Patenti:",
          list: allLicences,
          selected: selectedLicences,
          onAdd: onLicenceToggled,
          onDelete: onLicenceToggled,
        ),
        MultiSelectorWidget(
          title: "Comuni:",
          list: allLocations,
          selected: selectedLocations,
          onAdd: onLocationToggled,
          onDelete: onLocationToggled,
        ),
        MultiSelectorWidget(
          title: "Mansioni:",
          list: allTasks,
          selected: selectedTasks,
          onAdd: onTaskToggled,
          onDelete: onTaskToggled,
        )
      ],
    );
  }
}
