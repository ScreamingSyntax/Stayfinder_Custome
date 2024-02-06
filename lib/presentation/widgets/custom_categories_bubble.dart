import '../theme/colors.dart';
import 'widgets_export.dart';

class CustomCategoriesBubble extends StatelessWidget {
  final IconData iconMain;
  final String text;
  const CustomCategoriesBubble({
    super.key,
    required this.iconMain,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 71,
      height: 111,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 53,
            height: 50,
            decoration: BoxDecoration(
                color: UsedColors.backgroundColor,
                borderRadius: BorderRadius.circular(200)),
            child: Icon(
              iconMain,
              color: UsedColors.fadeOutColor,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          // Text(")
          CustomRedHatFont(
            text: text,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: UsedColors.backgroundColor,
          )
        ],
      ),
      decoration: BoxDecoration(
          color: UsedColors.mainColor,
          borderRadius: BorderRadius.circular(200)),
    );
  }
}
