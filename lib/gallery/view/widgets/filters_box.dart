import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/multi_selector_widget.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/period_selector_widget.dart';
import 'package:workers_repository/workers_repository.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
    required this.allPeriods,
    required this.onAddPeriod,
    required this.onDeletePeriod,
    required this.withOwnCar,
    required this.withOwnCarToggled,
    required this.searchMode,
    required this.searchModeToggled,
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

  final List<Period> allPeriods;
  final void Function(Period) onAddPeriod;
  final void Function(Period) onDeletePeriod;

  final bool withOwnCar;
  final void Function(bool) withOwnCarToggled;

  final SearchMode searchMode;
  final void Function(SearchMode) searchModeToggled;

  @override
  Widget build(BuildContext context) {
    const double dividerHeight = 3;

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
        const Divider(height: dividerHeight),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: MultiSelectorWidget(
                title: "Patenti:",
                list: allLicences,
                selected: selectedLicences,
                onAdd: onLicenceToggled,
                onDelete: onLicenceToggled,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Text(
                    "Solo automuniti: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                      value: withOwnCar,
                      onChanged: (value) => withOwnCarToggled(value!)),
                ],
              ),
            )
          ],
        ),
        const Divider(height: dividerHeight),
        MultiSelectorWidget(
          title: "Comuni:",
          list: allLocations,
          selected: selectedLocations,
          onAdd: onLocationToggled,
          onDelete: onLocationToggled,
        ),
        const Divider(height: dividerHeight),
        MultiSelectorWidget(
          title: "Mansioni:",
          list: allTasks,
          selected: selectedTasks,
          onAdd: onTaskToggled,
          onDelete: onTaskToggled,
        ),
        const Divider(height: dividerHeight),
        PeriodSelectorWidget(
          title: "Periodo: ",
          list: allPeriods,
          tooltip: "Aggiungi Periodo",
          onAdd: onAddPeriod,
          onDelete: onDeletePeriod,
        ),
        const Divider(
          height: dividerHeight,
        ),
        Row(
          children: [
            const Text(
              "Modalità di ricerca: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20,
            ),
            ToggleSwitch(
              minWidth: 120.0,
              cornerRadius: 10.0,
              customTextStyles: const [
                TextStyle(fontSize: 18.0, color: Colors.white),
                TextStyle(fontSize: 18.0, color: Colors.white)
              ],
              activeBgColors: [
                [Theme.of(context).colorScheme.primary],
                [Theme.of(context).colorScheme.primary]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: (searchMode == SearchMode.AND ? 0 : 1),
              totalSwitches: 2,
              labels: const ['AND', 'OR'],
              radiusStyle: false,
              onToggle: (index) => searchModeToggled(
                  (index == 0) ? SearchMode.AND : SearchMode.OR),
            ),
          ],
        ),
      ],
    );
  }
}
