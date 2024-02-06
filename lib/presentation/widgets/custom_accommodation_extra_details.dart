import 'widgets_export.dart';

class AccommodationExtraDetails extends StatelessWidget {
  final String topHead;
  final Widget body;
  const AccommodationExtraDetails({
    super.key,
    required this.topHead,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // topHead,
          Text(
            topHead,
            style: TextStyle(
                color: UsedColors.fadeOutColor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          // Text(
          //   "Price",
          //   style: TextStyle(
          //       color: UsedColors.fadeOutColor,
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500),
          // ),
          SizedBox(
            height: 5,
          ),
          body
          // Text(
          //   "Rs 30000",
          //   style: TextStyle(
          //       color: UsedColors.fadeOutColor,
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500),
          // ),
        ],
      ),
    );
  }
}
