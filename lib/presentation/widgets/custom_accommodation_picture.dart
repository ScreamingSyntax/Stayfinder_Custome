import '../../constants/ip.dart';
import '../../data/data_exports.dart';
import '../screens/screens_export.dart';
import 'widgets_export.dart';

class MainAccommodationPicture extends StatelessWidget {
  const MainAccommodationPicture({
    super.key,
    required this.accommodation,
  });

  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        key: UniqueKey(),
        imageUrl: "${getIpNoBackSlash()}${accommodation.image}",
        maxHeightDiskCache: 200,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 314,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: imageProvider)),
          );
        },
        placeholder: (context, url) => Container(
              height: 314,
              // width: 75,
              decoration: BoxDecoration(

                  // borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ),
        errorWidget: (context, url, error) => Container(
              height: 314,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ));
  }
}
