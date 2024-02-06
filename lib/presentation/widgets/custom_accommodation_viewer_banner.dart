import 'widgets_export.dart';

class CustomAccommodationViewBanner extends StatelessWidget {
  final String name;
  final String city;
  final String address;
  final void Function()? onPressed;
  const CustomAccommodationViewBanner(
      {super.key,
      required this.name,
      required this.city,
      required this.address,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: UsedColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              city + ", " + address,
              style: TextStyle(
                  color: UsedColors.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconlyLight.location,
                size: 16,
                weight: 2,
              ),
              SizedBox(
                width: 9,
              ),
              InkWell(
                onTap: onPressed,
                child: Text(
                  "Show in map",
                  style: TextStyle(
                      color: UsedColors.mainColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
