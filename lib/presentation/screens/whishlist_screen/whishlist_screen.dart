import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:iconly/iconly.dart';
import 'package:stayfinder_customer/presentation/theme/colors.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class WhishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomRedHatFont(
                  text: "Currently Booked",
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 19,
            ),
            CurrentlyBookedCardIfNotRentalRoom(
              accommodationType: "Tier Hotel",
              date: "12 sep - 13 sep",
              location: "Dharan, Chatachowkaaaaaaaaaa",
              name: "Soaltee",
              price: "20000",
              ratings: "5",
              roomBookedDetails: "Silver Tier 1 - tier",
            )
          ],
        ),
      ),
    );
  }
}

class CurrentlyBookedCardIfNotRentalRoom extends StatelessWidget {
  final String name;
  final String price;
  final String roomBookedDetails;
  final String ratings;
  final String accommodationType;
  final String location;
  final String date;
  const CurrentlyBookedCardIfNotRentalRoom({
    super.key,
    required this.price,
    required this.name,
    required this.roomBookedDetails,
    required this.ratings,
    required this.accommodationType,
    required this.location,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      child: Row(
        children: [
          Container(
            width: 96,
            height: 87,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/soaltee.png"))),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomRedHatFont(
                        text: name, fontWeight: FontWeight.w500, fontSize: 16),
                    Icon(
                      FontAwesomeIcons.map,
                      color: UsedColors.mainColor,
                      size: 18,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: Row(
                        children: [
                          CustomRedHatFont(
                              text: "Rs",
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            price,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    Text(roomBookedDetails,
                        style: TextStyle(
                            fontSize: 10,
                            overflow: TextOverflow.ellipsis,
                            color: UsedColors.fadeOutColor,
                            fontWeight: FontWeight.w500))
                    // Text("Rs"),
                    // Text("12000"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(
                            IconlyBold.star,
                            color: UsedColors.starColor,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // Text("4.5",
                          // style: ,
                          // )
                          CustomRedHatFont(
                            text: ratings,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: UsedColors.starColor,
                          ),
                        ],
                      ),
                    ),
                    Text(accommodationType,
                        style: TextStyle(
                            fontSize: 10,
                            color: UsedColors.fadeOutColor,
                            fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CustomRedHatFont(text: , fontWeight: fontWeight, fontSize: fontSize)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyLight.location,
                          color: UsedColors.mainColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: UsedColors.mainColor, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                    Text(
                      date,
                      style:
                          TextStyle(color: UsedColors.mainColor, fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
