import 'widgets_export.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData? suffixIcon;
  final Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  final bool? filled;
  final Color? filledColor;
  final Color? borderColor;
  bool? autoFocus;
  double? borderRadius;
  bool? isEnabled;
  bool? obscureText;
  final int? maxLines;
  final int? minLines;
  TextEditingController? controller;
  void Function()? suffixIconOnPressed;
  void Function(String?)? onSaved;
  bool? contentCenter;
  CustomTextFormField(
      {super.key,
      this.suffixIconOnPressed,
      this.borderColor,
      this.contentCenter,
      this.controller,
      required this.hintText,
      this.suffixIcon,
      this.obscureText,
      this.onTapOutside,
      this.validator,
      this.filled,
      this.borderRadius,
      this.autoFocus,
      this.isEnabled,
      this.onSaved,
      this.filledColor,
      this.maxLines,
      this.minLines}) {
    this.contentCenter = contentCenter ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus ?? false,
      controller: controller,
      onTapOutside: onTapOutside,
      validator: validator,
      obscureText: obscureText ?? false,
      onSaved: onSaved ?? null,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
          enabled: isEnabled ?? true,
          isDense: true,
          hintText: hintText,
          filled: filled,
          fillColor: filledColor,
          contentPadding: this.contentCenter!
              ? EdgeInsets.fromLTRB(100.0, 10.0, 20.0, 10.0)
              : null,
          hintStyle: TextStyle(
              fontFamily: 'RedHat',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: borderColor ?? UsedColors.mainColor),
          suffixIcon: this.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(
                    this.suffixIcon,
                    size: 19,
                  ),
                  onPressed: suffixIconOnPressed ?? null,
                  color: UsedColors.mainColor,
                ),
          focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(50),
              borderSide: BorderSide(
                  color: borderColor ?? UsedColors.mainColor, width: 1.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: borderColor ?? UsedColors.mainColor, width: 1.5)),
          border: OutlineInputBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: borderColor ?? UsedColors.mainColor, width: 1.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius != null
                  ? BorderRadius.circular(borderRadius!)
                  : BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: borderColor ?? UsedColors.mainColor))),
    );
  }
}
