import 'widgets_export.dart';

class BottomRequestAvailability extends StatelessWidget {
  final void Function()? onPressed;
  const BottomRequestAvailability({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 2.3,
              child: Icon(IconlyBold.heart)),
          MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 3,
            height: 48,
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            textColor: UsedColors.backgroundColor,
            color: UsedColors.mainColor,
            child: Text("Request Availability"),
          )
        ],
      ),
    );
  }
}
