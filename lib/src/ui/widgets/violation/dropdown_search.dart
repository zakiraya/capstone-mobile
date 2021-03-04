import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownSearchBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownSearch<String>(
        validator: (v) => v == null ? "required field" : null,
        hint: "Select a branch",
        label: "Menu mode *",
        showClearButton: true,
        onChanged: (value) {
          print(value.toString());
        },
        dropdownButtonBuilder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.arrow_drop_down,
            size: 24,
            color: Colors.black,
          ),
        ),
        showSelectedItem: true,
        items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
      ),
    );
  }
}
