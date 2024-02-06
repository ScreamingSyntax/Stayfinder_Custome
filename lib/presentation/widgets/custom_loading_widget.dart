import 'widgets_export.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String text;
  const CustomLoadingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        CircularProgressIndicator(
          color: UsedColors.mainColor,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: TextStyle(
            color: UsedColors.fadeTextColor,
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
