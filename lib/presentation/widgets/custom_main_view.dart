import 'package:cached_network_image/cached_network_image.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CustomMainImageVIew extends StatelessWidget {
  final String imageLink;
  const CustomMainImageVIew({
    super.key,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) {
            return Container(
              width: 135,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: imageProvider,
                      fit: BoxFit.cover)),
            );
          },
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          imageUrl: imageLink,
          height: 250,
          placeholder: (context, url) => Container(
                width: 135,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    // borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logos/logo.png"))),
              ),
          errorWidget: (context, url, error) => Container(
                width: 135,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/logos/logo.png"))),
              )),
    );
  }
}
