import 'package:stayfinder_customer/logic/logic_exports.dart';

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
    return Stack(
      children: [
        CachedNetworkImage(
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
                )),
        Positioned(
            top: 30,
            left: 20,
            child: SafeArea(
                child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ))),
        BlocProvider(
          create: (context) => BooleanChangeCubit(),
          child: Builder(builder: (context) {
            return Positioned(
                right: 10,
                bottom: 5,
                child: InkWell(
                  onTap: () {
                    context.read<BooleanChangeCubit>()..change();
                    var state = context.read<UserDetailsStorageBloc>().state;
                    if (state.isLoggedIn == true) {
                      context.read<AddToWishlistCubit>()
                        ..addToWishList(
                            token: state.user!.token!,
                            itemId: accommodation.id!);
                    } else {
                      showPopup(
                          context: context,
                          description: "You need to login first",
                          title: "Login Required",
                          type: ToastificationType.error);
                    }
                  },
                  child: BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
                    builder: (context, state) {
                      return Icon(
                        state.value == false
                            ? IconlyLight.heart
                            : IconlyBold.heart,
                        color: UsedColors.mainColor,
                        size: 30,
                      );
                    },
                  ),
                ));
          }),
        )
      ],
    );
  }
}
