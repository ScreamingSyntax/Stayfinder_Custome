import 'widgets_export.dart';

class AmenitiesAvailabilityChipCard extends StatelessWidget {
  final bool? value;
  final String text;
  const AmenitiesAvailabilityChipCard(
      {super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value ?? false,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
          color: UsedColors.chipColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: UsedColors.textColor,
          ),
        ),
      ),
    );
  }
}
