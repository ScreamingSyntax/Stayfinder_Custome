import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import '../theme/colors.dart';

class StayFinderLogo extends StatelessWidget {
  const StayFinderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Stay",
          style: TextStyle(
              color: UsedColors.mainColor,
              fontSize: 48,
              fontFamily: 'Kapakana'),
        ),
        Text(
          "Finder",
          style: TextStyle(
              fontSize: 32,
              color: UsedColors.textColor,
              fontFamily: 'Italiana'),
        )
      ],
    );
  }
}
