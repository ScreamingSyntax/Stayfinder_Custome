import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import '../../../constants/constant_exports.dart';
import '../screens_export.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';

class HostelViewScreen extends StatelessWidget {
  final Map map;

  const HostelViewScreen({super.key, required this.map});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarCheck(context, () {}),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
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
                                width: MediaQuery.of(context).size.width / 4,
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
                                width: MediaQuery.of(context).size.width / 4,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
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
                                width: MediaQuery.of(context).size.width / 4,
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
                                width: MediaQuery.of(context).size.width / 4,
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
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: rooms.length,
                              itemBuilder: (context, index) {
                                Room room = rooms[index];
                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 118,
                                        child: FlutterCarousel(
                                            items: [
                                              CachedNetworkImage(
                                                  key: UniqueKey(),
                                                  imageUrl:
                                                      "${getIpNoBackSlash()}${room.room_images![0]!.images}",
                                                  maxHeightDiskCache: 200,
                                                  imageBuilder:
                                                      (context, imageProvider) {
                                                    return Container(
                                                      height: 88,
                                                      width: 118,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              image:
                                                                  imageProvider)),
                                                    );
                                                  },
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        // width: 75,
                                                        height: 88,
                                                        width: 118,
                                                        decoration:
                                                            BoxDecoration(
                                                                // borderRadius: BorderRadius.circular(100),
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        "assets/logos/logo.png"))),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                            height: 88,
                                                            width: 118,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        "assets/logos/logo.png"))),
                                                          )),
                                              CachedNetworkImage(
                                                  key: UniqueKey(),
                                                  imageUrl:
                                                      "${getIpNoBackSlash()}${room.room_images![1]!.images}",
                                                  maxHeightDiskCache: 200,
                                                  imageBuilder:
                                                      (context, imageProvider) {
                                                    return Container(
                                                      height: 88,
                                                      width: 118,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              image:
                                                                  imageProvider)),
                                                    );
                                                  },
                                                  placeholder: (context, url) =>
                                                      Container(
                                                        // width: 75,
                                                        height: 88,
                                                        width: 118,
                                                        decoration:
                                                            BoxDecoration(
                                                                // borderRadius: BorderRadius.circular(100),
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        "assets/logos/logo.png"))),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                            height: 88,
                                                            width: 118,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        "assets/logos/logo.png"))),
                                                          )),
                                            ],
                                            options: CarouselOptions(
                                                // controller: buttonCarsouselController,
                                                height: 88,
                                                enlargeCenterPage: true,
                                                viewportFraction: 0.9,
                                                aspectRatio: 2.0,
                                                showIndicator: false,
                                                initialPage: 0,
                                                autoPlayAnimationDuration:
                                                    Duration(seconds: 1),
                                                autoPlay: true,
                                                // showIndicator: true,
                                                scrollDirection:
                                                    Axis.horizontal)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${numberToWord(room.seater_beds!)} Seater Bed",
                                                style: TextStyle(
                                                    color: UsedColors.textColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Washroom ${room.washroom_status}",
                                                style: TextStyle(
                                                    color: UsedColors.mainColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                            fontSize: 12,
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
                                                            fontSize: 14,
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
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
    );
  }
}
