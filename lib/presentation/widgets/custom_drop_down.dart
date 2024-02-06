import 'package:flutter/cupertino.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../logic/cubits/drop_down/drop_down_state.dart';

class CustomDropDownButton extends StatelessWidget {
  final DropDownValueState state;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  const CustomDropDownButton({
    super.key,
    required this.state,
    this.onChanged,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // isDense: trie,
      dropdownColor: Color(0xffe5e5e5),
      focusColor: Color(0xffe5e5e5),
      onChanged: onChanged,
      items: items,
      value: state.value,
      padding: EdgeInsets.all(5),

      style: TextStyle(
          color: UsedColors.fadeTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w400),

      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          IconlyLight.arrow_down_2,
          color: UsedColors.mainColor,
          size: 16,
        ),
      ),
    );
  }
}
