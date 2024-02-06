// ignore_for_file: must_be_immutable
import 'widgets_export.dart';

class CustomMaterialButton extends StatelessWidget {
  void Function()? onPressed;
  final String text;
  final double width;
  final double height;
  Color? buttonColor;
  CustomMaterialButton(
      {super.key,
      required this.height,
      required this.onPressed,
      required this.text,
      this.buttonColor,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: UsedColors.backgroundColor),
      ),
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: this.buttonColor ?? UsedColors.mainColor,
    );
  }
}
