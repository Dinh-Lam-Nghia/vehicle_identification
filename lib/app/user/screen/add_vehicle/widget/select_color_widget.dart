import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class SelectColorWidget extends StatelessWidget {
  const SelectColorWidget(
      {super.key,
      required this.mainColor,
      required this.setMainColor,
      required this.setColor});
  final ColorSwatch mainColor;
  final Function(ColorSwatch<dynamic>?) setMainColor;
  final VoidCallback setColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        contentPadding: const EdgeInsets.all(10.0),
        title: Center(
          child: Text(
            S.of(context).selectColor.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        content: MaterialColorPicker(
          colors: fullMaterialColors,
          selectedColor: mainColor,
          onMainColorChange: setMainColor,
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(S.of(context).cancel,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setColor.call();
            },
            child: Text(S.of(context).ok,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
