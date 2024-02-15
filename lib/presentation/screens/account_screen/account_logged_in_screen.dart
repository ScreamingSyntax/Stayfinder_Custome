import 'package:boxicons/boxicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stayfinder_customer/constants/ip.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            BlocBuilder<UserDetailsStorageBloc, UserDetailsStorageState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: UsedColors.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        AccountSectionTopPart(),
                        EditAccountCard(
                          image: state.user!.image!,
                          email: state.user!.email.toString(),
                          name: state.user!.full_name.toString(),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: UsedColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: HistorySection()),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: UsedColors.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ReviewsSection()),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomRedHatFont(
            text: "Reviews",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                var state = context.read<UserDetailsStorageBloc>().state;
                // if(state )
                context.read<FetchAddedReviewsCubit>()
                  ..fetchAddedReviews(token: state.user!.token!);
                Navigator.pushNamed(context, "/myReviews");
              },
              child: AccountSmallCards(
                topWidget: Icon(
                  Boxicons.bxs_message_square_check,
                  size: 35,
                  color: UsedColors.mainColor,
                ),
                text: "Your Reviews",
              ),
            ),
            SizedBox(
              width: 30,
            ),
            InkWell(
              onTap: () {
                context.read<FetchToReviewCubit>()
                  ..fetchToReview(
                      token: context
                          .read<UserDetailsStorageBloc>()
                          .state
                          .user!
                          .token!);
                Navigator.pushNamed(context, "/toReview");
              },
              child: AccountSmallCards(
                topWidget: Icon(
                  Boxicons.bx_message_add,
                  size: 35,
                  color: UsedColors.mainColor,
                ),
                text: "To Review",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HistorySection extends StatelessWidget {
  const HistorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: CustomRedHatFont(
              text: "History",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<UserDetailsStorageBloc, UserDetailsStorageState>(
          builder: (context, state) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    context.read<FetchBookingHistoryCubit>()
                      ..fetchBookingHistory(token: state.user!.token!);
                    Navigator.pushNamed(context, "/bookHistory");
                  },
                  child: AccountSmallCards(
                    topWidget: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/booking.png"))),
                    ),
                    text: "Booking",
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                BlocBuilder<FetchBookingRequestHistoryCubit,
                    FetchBookingRequestHistoryState>(
                  builder: (context, state2) {
                    return InkWell(
                      onTap: () {
                        context.read<FetchBookingRequestHistoryCubit>()
                          ..fetchBookingRequestHistory(
                              token: state.user!.token!);

                        Navigator.pushNamed(context, "/bookRequestHistory");
                      },
                      child: AccountSmallCards(
                        topWidget: Icon(
                          IconlyBold.activity,
                          size: 35,
                          color: UsedColors.mainColor,
                        ),
                        text: "Requests",
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () {
                    context.read<FetchWishlistCubit>()
                      ..fetchWishlist(
                          token: context
                              .read<UserDetailsStorageBloc>()
                              .state
                              .user!
                              .token!);
                    Navigator.pushNamed(context, "/wishList");
                  },
                  child: AccountSmallCards(
                    topWidget: Icon(
                      IconlyLight.document,
                      size: 35,
                      color: UsedColors.mainColor,
                    ),
                    text: "WishLists",
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class AccountSmallCards extends StatelessWidget {
  final Widget topWidget;
  final String text;
  const AccountSmallCards({
    super.key,
    required this.topWidget,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 97,
      height: 107,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 87, width: 87, child: topWidget),
          Text(
            text,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: UsedColors.fadeTextColor),
          )
        ],
      ),
    );
  }
}

class AccountSectionTopPart extends StatelessWidget {
  const AccountSectionTopPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRedHatFont(
                text: "Account", fontWeight: FontWeight.w600, fontSize: 24),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/resetPass");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 29,
                    width: 79,
                    decoration: BoxDecoration(
                        color: UsedColors.mainColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Reset Pass",
                      style: TextStyle(
                          fontSize: 11, color: UsedColors.backgroundColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    context.read<UserDetailsStorageBloc>()
                      ..add(UserDetailsLogout());
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 29,
                      width: 39,
                      decoration: BoxDecoration(
                          color: UsedColors.backgroundColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Boxicons.bxs_door_open,
                        color: UsedColors.mainColor,
                      )),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
      ],
    );
  }
}

class EditAccountCard extends StatelessWidget {
  final String name;
  final String image;
  final String email;
  final Function() onTap;
  const EditAccountCard(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: "${getIpNoBackSlash()}${image}",
            maxHeightDiskCache: 200,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider)),
              );
            },
            placeholder: (context, url) => Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logos/logo.png"))),
                ),
            errorWidget: (context, url, error) => Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/logos/logo.png"))),
                )),
        // Container(
        //   height: 75,
        //   width: 75,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(100),
        //       image: DecorationImage(
        //           fit: BoxFit.cover,
        //           image: AssetImage("assets/images/user.png")
        //           )
        //           ),
        // ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRedHatFont(
                      text: name, fontWeight: FontWeight.w500, fontSize: 16),
                  SizedBox(
                    height: 6,
                  ),
                  CustomRedHatFont(
                    text: email,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: UsedColors.fadeOutColor,
                  )
                ],
              ),
              InkWell(
                onTap: () => onTap,
                child: Icon(
                  IconlyLight.edit,
                  color: UsedColors.mainColor,
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
