import 'package:stayfinder_customer/constants/ip.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CardBookHistoryRequestCard extends StatelessWidget {
  final String name;
  final int requestId;
  final int roomId;
  final String status;
  final String roomBookedDetails;
  final String ratings;
  final String accommodationType;
  final String location;
  final String image;
  const CardBookHistoryRequestCard({
    super.key,
    required this.name,
    required this.roomBookedDetails,
    required this.ratings,
    required this.accommodationType,
    required this.location,
    required this.requestId,
    required this.roomId,
    required this.status,
    required this.image,
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
                    Row(
                      children: [
                        Icon(
                          IconlyLight.activity,
                          color: UsedColors.mainColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          status,
                          style: TextStyle(
                              color: status == "rejected"
                                  ? UsedColors.mainColor
                                  : UsedColors.fadeOutColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
