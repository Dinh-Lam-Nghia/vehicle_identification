import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown(
      {super.key,
      required this.listRole,
      required this.onChanged,
      required this.value});
  final List<String> listRole;
  final String value;
  final Function(String?, BuildContext) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: value,
        items: listRole.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          onChanged(value, context);
        });
  }
}
