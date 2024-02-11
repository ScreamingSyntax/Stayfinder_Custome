import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import '../../../constants/constant_exports.dart';
import '../screens_export.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HostelViewScreen extends StatelessWidget {
  final Map map;

  const HostelViewScreen({super.key, required this.map});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToWishlistCubit, AddToWishlistState>(
      listener: (context, state) {
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
      child: BlocListener<RequestBookingCubit, RequestBookingState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RequestBookingLoading) {
            showPopup(
                context: context,
                description: "Requesting Please Wait...",
                title: "Loading...",
                type: ToastificationType.info);
          }
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
        child: Scaffold(
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
                loadAccommodation(context, map['id']);
              }
              if (state is ParticularAccommodationError) {
                return CustomErrorScreen(
                  message: state.error,
                  onPressed: () => loadAccommodation(context, map['id']),
                );
              }
              if (state is ParticularAccommodationLoaded) {
                Accommodation accommodation = state.accommodation!;
                List<Room> rooms = state.rooms!;
                return RefreshIndicator(
                  onRefresh: () async {
                    return loadAccommodation(context, map['id']);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainAccommodationPicture(accommodation: accommodation),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: AccommodationExtraDetails(
                                      topHead: "Price",
                                      body: Text(
                                        "Rs ${accommodation.monthly_rate}",
                                        style: TextStyle(
                                            color: UsedColors.fadeOutColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
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
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: AccommodationExtraDetails(
                                      topHead: "Meals / Day",
                                      body: Text(
                                        accommodation.meals_per_day!.toString(),
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
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: AccommodationExtraDetails(
                                      topHead: "Non-Veg meals/day",
                                      body: Text(
                                        "${accommodation.weekly_non_veg_meals}",
                                        style: TextStyle(
                                            color: UsedColors.fadeOutColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: AccommodationExtraDetails(
                                      topHead: "Weekly Laundry Cycles",
                                      body: Text(
                                        accommodation.weekly_laundry_cycles
                                            .toString(),
                                        style: TextStyle(
                                            color: UsedColors.fadeOutColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: AccommodationExtraDetails(
                                      topHead: "Washroom Count",
                                      body: Text(
                                        accommodation.number_of_washroom!
                                            .toString(),
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
                                height: 37,
                              ),
                              Text(
                                "Rooms",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: rooms.length,
                                  itemBuilder: (context, index) {
                                    Room room = rooms[index];
                                    return Column(
                                      children: [
                                        Slidable(
                                          closeOnScroll: true,
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            extentRatio: 1,
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) async {
                                                  if (context
                                                          .read<
                                                              UserDetailsStorageBloc>()
                                                          .state
                                                          .isLoggedIn ==
                                                      false) {
                                                    showPopup(
                                                        context: context,
                                                        description:
                                                            "You need to Login First",
                                                        title: "Login Required",
                                                        type: ToastificationType
                                                            .error);
                                                    Navigator.pushNamed(
                                                        context, "/login");
                                                    return;
                                                  }
                                                  var loginState = context
                                                      .read<
                                                          UserDetailsStorageBloc>()
                                                      .state;
                                                  // Show dialog for confirmation
                                                  bool confirmed =
                                                      await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Confirmation'),
                                                                content: Text(
                                                                    'Are you sure you want to proceed?'),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Cancel'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(
                                                                              false); // Dismiss dialog and return false
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: Text(
                                                                        'Confirm'),
                                                                    onPressed:
                                                                        () {
                                                                      context.read<
                                                                          RequestBookingCubit>()
                                                                        ..requestBooking(
                                                                            token:
                                                                                loginState.user!.token!,
                                                                            roomId: room.id!);
                                                                      context.read<
                                                                          FetchBookingRequestCubit>()
                                                                        ..fetchBookingRequests(
                                                                          token: loginState
                                                                              .user!
                                                                              .token!,
                                                                        );
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(); // Dismiss dialog and return true
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;

                                                  if (confirmed) {}
                                                  // context.read(
                                                  //)
                                                  // var loginState = context
                                                  //     .read<
                                                  //         UserDetailsStorageBloc>()
                                                  //     .state;
                                                  // context
                                                  //     .read<RequestBookingCubit>()
                                                  //   ..requestBooking(
                                                  //       token: loginState
                                                  //           .user!.token!,
                                                  //       roomId: room.id!);
                                                },
                                                foregroundColor:
                                                    UsedColors.mainColor,
                                                icon: Icons.book,
                                                label: 'Request Booking',
                                              )
                                            ],
                                          ),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 118,
                                                  child: FlutterCarousel(
                                                      items: [
                                                        CachedNetworkImage(
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                "${getIpNoBackSlash()}${room.room_images![0]!.images}",
                                                            maxHeightDiskCache:
                                                                200,
                                                            imageBuilder: (context,
                                                                imageProvider) {
                                                              return Container(
                                                                height: 88,
                                                                width: 118,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        image:
                                                                            imageProvider)),
                                                              );
                                                            },
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                                      // width: 75,
                                                                      height:
                                                                          88,
                                                                      width:
                                                                          118,
                                                                      decoration: BoxDecoration(
                                                                          // borderRadius: BorderRadius.circular(100),
                                                                          image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/logos/logo.png"))),
                                                                    ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                                      height:
                                                                          88,
                                                                      width:
                                                                          118,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              100),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: AssetImage("assets/logos/logo.png"))),
                                                                    )),
                                                        CachedNetworkImage(
                                                            key: UniqueKey(),
                                                            imageUrl:
                                                                "${getIpNoBackSlash()}${room.room_images![1]!.images}",
                                                            maxHeightDiskCache:
                                                                200,
                                                            imageBuilder: (context,
                                                                imageProvider) {
                                                              return Container(
                                                                height: 88,
                                                                width: 118,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        image:
                                                                            imageProvider)),
                                                              );
                                                            },
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                                      // width: 75,
                                                                      height:
                                                                          88,
                                                                      width:
                                                                          118,
                                                                      decoration: BoxDecoration(
                                                                          // borderRadius: BorderRadius.circular(100),
                                                                          image: DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/logos/logo.png"))),
                                                                    ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                                      height:
                                                                          88,
                                                                      width:
                                                                          118,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              100),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: AssetImage("assets/logos/logo.png"))),
                                                                    )),
                                                      ],
                                                      options: CarouselOptions(
                                                          // controller: buttonCarsouselController,
                                                          height: 88,
                                                          enlargeCenterPage:
                                                              true,
                                                          viewportFraction: 0.9,
                                                          aspectRatio: 2.0,
                                                          showIndicator: false,
                                                          initialPage: 0,
                                                          autoPlayAnimationDuration:
                                                              Duration(
                                                                  seconds: 1),
                                                          autoPlay: true,
                                                          // showIndicator: true,
                                                          scrollDirection:
                                                              Axis.horizontal)),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${numberToWord(room.seater_beds!)} Seater Bed",
                                                          style: TextStyle(
                                                              color: UsedColors
                                                                  .textColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Text(
                                                          "Washroom ${room.washroom_status}",
                                                          style: TextStyle(
                                                              color: UsedColors
                                                                  .mainColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Rs",
                                                                  style: TextStyle(
                                                                      color: UsedColors
                                                                          .fadeOutColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  room.monthly_rate
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: UsedColors
                                                                          .fadeOutColor,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              room.fan_availability ==
                                                                      true
                                                                  ? "Has Fan"
                                                                  : "No Fan",
                                                              style: TextStyle(
                                                                  color: UsedColors
                                                                      .mainColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: [Text("$map")],
              );
            },
          ),
        ),
      ),
    );
  }
}
