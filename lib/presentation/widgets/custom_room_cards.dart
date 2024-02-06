import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import '../../constants/constant_exports.dart';
import '../screens/screens_export.dart';
import '../theme/colors.dart';

class CustomAccommodationCard extends StatelessWidget {
  final String image;
  final String name;
  final String ratings;
  final String city;
  final String address;
  final String type;
  const CustomAccommodationCard({
    super.key,
    required this.image,
    required this.name,
    required this.ratings,
    required this.city,
    required this.address,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "${getIpNoBackSlash()}${image}",
              maxHeightDiskCache: 200,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 116,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: imageProvider)),
                );
              },
              placeholder: (context, url) => Container(
                    // width: 75,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  ),
              errorWidget: (context, url, error) => Container(
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  )),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 116,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           fit: BoxFit.cover,
          //           filterQuality: FilterQuality.low,
          //           image: NetworkImage(
          //             "${getIpNoBackSlash()}${image}",
          //           )),
          //       borderRadius: BorderRadius.circular(15)),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRedHatFont(
                        text: name, fontWeight: FontWeight.w900, fontSize: 14),
                    Row(
                      children: [
                        Text(
                          "[ $ratings ]",
                          style: TextStyle(
                              color: UsedColors.fadeOutColor, fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          IconlyBold.star,
                          size: 16,
                          color: UsedColors.starColor,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconlyLight.location,
                          color: UsedColors.fadeOutColor,
                          size: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "$city, $address",
                          style: TextStyle(
                              fontSize: 12, color: UsedColors.fadeOutColor),
                        )
                      ],
                    ),
                    Text(
                      "$type",
                      style: TextStyle(
                        color: UsedColors.fadeOutColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: UsedColors.borderColorFade)),
    );
  }
}
