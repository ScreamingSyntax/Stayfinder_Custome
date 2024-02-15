import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CustomVerifiedWidget extends StatelessWidget {
  final bool value;
  const CustomVerifiedWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      value ? Icons.verified : Icons.cancel,
      size: 14,
      color: value ? Color(0xff7951AC) : Colors.red,
      // color: Colors,
    );
  }
}

class RoomDetailWidgetRental extends StatelessWidget {
  final bool value;
  const RoomDetailWidgetRental(
      {super.key, required this.value, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRedHatFont(
            text: '\u2022 ${text} :',
            fontSize: 13,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600),
        SizedBox(
          width: 10,
        ),
        CustomRedHatFont(
            text: this.value ? 'Available' : 'Unavailable',
            fontSize: 13,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600),
      ],
    );
  }
}
