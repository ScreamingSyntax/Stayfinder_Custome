import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../constants/ip.dart';
import '../screens/screens_export.dart';

class CurrentlyBookedCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String roomBookedDetails;
  final String ratings;
  final String accommodationType;
  final String location;
  final String date;
  const CurrentlyBookedCard({
    super.key,
    required this.image,
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
      height: 166,
      child: Row(
        children: [
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "${getIpNoBackSlash()}${image}",
              maxHeightDiskCache: 200,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 117,
                  height: 117,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider)),
                );
              },
              placeholder: (context, url) => Container(
                    width: 117,
                    height: 117,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  ),
              errorWidget: (context, url, error) => Container(
                    width: 117,
                    height: 117,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  )),
          // Container(
          //   width: 117,
          //   height: 117,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage("assets/images/soaltee.png"))),
          // ),
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
                    if (roomBookedDetails != "")
                      Text("Seater Beds : $roomBookedDetails",
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
                          IconlyLight.time_circle,
                          color: UsedColors.mainColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          // width: 100,
                          child: Text(
                            "${date}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: UsedColors.mainColor, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
