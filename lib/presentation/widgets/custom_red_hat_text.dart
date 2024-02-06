import 'package:stayfinder_customer/presentation/theme/colors.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CustomRedHatFont extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight fontWeight;
  final double fontSize;

  const CustomRedHatFont({
    super.key,
    required this.text,
    this.color,
    required this.fontWeight,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: 'Redhat',
          color: this.color ?? UsedColors.textColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
