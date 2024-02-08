import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class BookRequestCustomCard extends StatelessWidget {
  final String name;
  final int requestId;
  final int roomId;
  final String status;
  final String roomBookedDetails;
  final String ratings;
  final String accommodationType;
  final String location;
  final void Function() onPressed;

  const BookRequestCustomCard({
    super.key,
    required this.name,
    required this.onPressed,
    required this.roomBookedDetails,
    required this.ratings,
    required this.accommodationType,
    required this.location,
    required this.requestId,
    required this.roomId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(5),
      height: 186,
      child: Row(
        children: [
          Container(
            width: 117,
            height: 117,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/soaltee.png"))),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                  ],
                ),
                SizedBox(
                  height: 05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomMaterialButton(
                        height: 35,
                        buttonColor: status == "accepted"
                            ? UsedColors.mainColor
                            : UsedColors.mainColor.withOpacity(0.5),
                        onPressed: status == "accepted"
                            ? onPressed
                            : () {
                                showPopup(
                                    context: context,
                                    description: "Your request is pending",
                                    title: "Please waiit",
                                    type: ToastificationType.info);
                              },
                        text: status == "accepted" ? "Book" : "Pending",
                        width: 35),
                    if (accommodationType != "rent_room")
                      Container(
                        width: 50,
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.bed,
                              color: UsedColors.textColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomRedHatFont(
                              text: roomBookedDetails,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: UsedColors.textColor,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
