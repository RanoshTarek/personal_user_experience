
import 'package:flutter/material.dart';

class DefaultDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final T? value;

  const DefaultDropDown(
      {Key? key,
        required this.items,
        required this.onChanged,
        required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )),
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
            size: 28,
            color: Colors.blue,
          ),
          value: value,
          onChanged: onChanged,
          items: items),
    );
  }
}
