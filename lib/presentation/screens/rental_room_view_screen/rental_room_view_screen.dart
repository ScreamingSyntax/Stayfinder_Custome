// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stayfinder_customer/constants/ip.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../screens_export.dart';

class RentalRoomViewScreen extends StatelessWidget {
  final Map data;

  const RentalRoomViewScreen({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RequestBookingCubit, RequestBookingState>(
          listener: (context, state) {
            if (state is RequestBookingError) {
              showPopup(
                  context: context,
                  description: state.message,
                  title: "Error",
                  type: ToastificationType.error);
            }
            if (state is RequestBookingSuccess) {
              showPopup(
                  context: context,
                  description: state.message,
                  title: "Success",
                  type: ToastificationType.success);
            }
          },
        ),
        BlocListener<AddToWishlistCubit, AddToWishlistState>(
          listener: (context, state) {
            // TODO: implement listener

            if (state is AddToWishlistError) {
              showPopup(
                  context: context,
                  description: state.message,
                  title: "Oops..",
                  type: ToastificationType.error);
            }
            if (state is AddToWishlistSuccess) {
              showPopup(
                  context: context,
                  description: state.message,
                  title: "Success",
                  type: ToastificationType.success);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: UsedColors.backgroundColor,
        bottomNavigationBar: BottomNavBarCheck(
          context,
          () async {
            if (context.read<UserDetailsStorageBloc>().state.isLoggedIn ==
                false) {
              showPopup(
                  context: context,
                  description: "You need to Login First",
                  title: "Login Required",
                  type: ToastificationType.error);
              Navigator.pushNamed(context, "/login");
              return;
            }
            var loginState = context.read<UserDetailsStorageBloc>().state;
            bool confirmed = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to proceed?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(false); // Dismiss dialog and return false
                          },
                        ),
                        BlocBuilder<ParticularAccommodationCubit,
                            ParticularAccommodationState>(
                          builder: (context, state) {
                            if (state is ParticularAccommodationLoaded) {
                              return TextButton(
                                child: Text('Confirm'),
                                onPressed: () {
                                  context.read<RequestBookingCubit>()
                                    ..requestBooking(
                                        token: loginState.user!.token!,
                                        roomId: state.rooms![0].id!);
                                  context
                                      .read<FetchBookingRequestCubit>()
                                      .fetchBookingRequests(
                                        token: loginState.user!.token!,
                                      );
                                  Navigator.of(context)
                                      .pop(); // Dismiss dialog and return true
                                },
                              );
                            }
                            return InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text("Please Wait"));
                          },
                        ),
                      ],
                    );
                  },
                ) ??
                false;
          },
        ),
        body: BlocBuilder<ParticularAccommodationCubit,
            ParticularAccommodationState>(
          builder: (context, state) {
            if (state is ParticularAccommodationLoading) {
              return Center(
                child: CustomLoadingWidget(
                  text: "Fetching Accommodation",
                ),
              );
            }
            if (state is ParticularAccommodationInitial) {
              loadAccommodation(context, data['id']);
            }
            if (state is ParticularAccommodationError) {
              return CustomErrorScreen(
                message: state.error,
                onPressed: () => loadAccommodation(context, data['id']),
              );
            }
            if (state is ParticularAccommodationLoaded) {
              Accommodation accommodation = state.accommodation!;
              Room room = state.rooms![0];
              return RefreshIndicator(
                onRefresh: () async {
                  return loadAccommodation(context, data['id']);
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainAccommodationPicture(accommodation: accommodation),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RetntalRoomTopView(
                                accommodation: accommodation, room: room),
                            SizedBox(
                              height: 19,
                            ),
                            RentalRoomAmenitiesView(
                                room: room, accommodation: accommodation),
                            SizedBox(
                              height: 19,
                            ),
                            CustomReviewSection(
                              context: context,
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            RentalRoomBottomView(room: room)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [Text("")],
            );
          },
        ),
      ),
    );
  }
}

class RentalRoomAmenitiesView extends StatelessWidget {
  const RentalRoomAmenitiesView({
    super.key,
    required this.room,
    required this.accommodation,
  });

  final Room room;
  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Amenities",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 19,
          ),
          CustomAmenitiesScrollable(room: room, accommodation: accommodation),
          SizedBox(
            height: 19,
          ),
        ],
      ),
    );
  }
}

class RetntalRoomTopView extends StatelessWidget {
  const RetntalRoomTopView({
    super.key,
    required this.accommodation,
    required this.room,
  });

  final Accommodation accommodation;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
      child: Column(
        children: [
          CustomAccommodationViewBanner(
            name: accommodation.name!,
            city: accommodation.city!,
            onPressed: () {},
            address: accommodation.address!,
          ),
          SizedBox(
            height: 37,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: AccommodationExtraDetails(
                  topHead: "Price",
                  body: Text(
                    "Rs //${accommodation.monthly_rate}",
                    style: TextStyle(
                        color: UsedColors.fadeOutColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 6,
                child: AccommodationExtraDetails(
                  topHead: "Reviews",
                  body: Text(
                    "5",
                    style: TextStyle(
                        color: UsedColors.fadeOutColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 5,
                child: AccommodationExtraDetails(
                  topHead: "Washroom Status",
                  body: Text(
                    room.washroom_status!,
                    style: TextStyle(
                        color: UsedColors.fadeOutColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 19,
          ),
        ],
      ),
    );
  }
}

class RentalRoomBottomView extends StatelessWidget {
  const RentalRoomBottomView({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Images",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 19,
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: room.room_images!.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    CachedNetworkImage(
                        width: 124,
                        key: UniqueKey(),
                        imageUrl:
                            "${getIpNoBackSlash()}${room.room_images![index]!.images}",
                        maxHeightDiskCache: 200,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 116,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    image: imageProvider)),
                          );
                        },
                        placeholder: (context, url) => Container(
                              height: 116,
                              width: 124,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/logos/logo.png"))),
                            ),
                        errorWidget: (context, url, error) => Container(
                            height: 116,
                            width: 124,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/logos/logo.png"))))),
                    SizedBox(
                      width: 20,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
