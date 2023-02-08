import 'package:flutter/material.dart';
import 'package:lavoratori_stagionali/gallery/view/widgets/multi_selector_widget.dart';

class FiltersBox extends StatelessWidget {
  const FiltersBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 10,
      spacing: 10,
      children: [
        MultiSelectorWidget(
          title: "Titolo: ",
          width: 75,
          list: const ["Primo", "Secondo", "Terzo"],
          selected: const ["Primo", "Secondo"],
          onAdd: (_) {},
          onDelete: (_) {},
        )
      ],
    );
  }
}
