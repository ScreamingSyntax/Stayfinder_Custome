import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../constants/constant_exports.dart';
import '../screens_export.dart';

class HotelWithoutTierViewScreen extends StatelessWidget {
  final Map data;

  const HotelWithoutTierViewScreen({super.key, required this.data});
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
      child: Scaffold(
        backgroundColor: UsedColors.backgroundColor,
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
              List<Room> rooms = state.rooms!;
              return RefreshIndicator(
                onRefresh: () async {
                  return loadAccommodation(context, data['id']);
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainAccommodationPicture(accommodation: accommodation),
                      HotelWithoutTierTopView(accommodation: accommodation),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomReviewSection(context: context),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      HotelWithoutTierRoomsView(
                          rooms: rooms, accommodation: accommodation)
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [],
            );
          },
        ),
      ),
    );
  }
}

class HotelWithoutTierRoomsView extends StatelessWidget {
  const HotelWithoutTierRoomsView({
    super.key,
    required this.rooms,
    required this.accommodation,
  });

  final List<Room> rooms;
  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 7,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
        color: UsedColors.cardColor,
        // borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: Border.all(color: UsedColors.fadeOutColor, width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Rooms To Book",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Container(
              height: 450,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                // padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: rooms.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HotelWithoutTierRoomCard(
                      room: rooms[index],
                      accommodation: accommodation,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelWithoutTierTopView extends StatelessWidget {
  const HotelWithoutTierTopView({
    super.key,
    required this.accommodation,
  });

  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: UsedColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // border: Border.all(color: UsedColors.fadeOutColor, width: 1)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amenities",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    CustomAmenitiesScrollable(
                        room: Room(), accommodation: accommodation),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelWithoutTierRoomCard extends StatelessWidget {
  const HotelWithoutTierRoomCard(
      {super.key, required this.room, required this.accommodation});

  final Room room;
  final Accommodation accommodation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341,
      height: 440,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: UsedColors.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        // border: Border.all(color: UsedColors.fadeOutColor, width: 1)
      ),
      child: Column(
        children: [
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "${getIpNoBackSlash()}${room.room_images![0]!.images}",
              maxHeightDiskCache: 200,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 126,
                  // width: 118,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          image: imageProvider)),
                );
              },
              placeholder: (context, url) => Container(
                    // width: 75,
                    height: 126,
                    // width: 118,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  ),
              errorWidget: (context, url, error) => Container(
                    height: 126,
                    // width: 118,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logos/logo.png"))),
                  )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${numberToWord(room.seater_beds!)} Seater Bed",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Rs ${room.per_day_rent}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: UsedColors.mainColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),

                Container(
                  height: 170,
                  child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3 / 0.7),
                    children: [
                      AmenitiesAvailabilityChipCard(
                        text: "A.C",
                        value: room.ac_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Water Bottle",
                        value: room.water_bottle_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Iron",
                        value: room.steam_iron_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Fan",
                        value: room.fan_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Kettle",
                        value: room.kettle_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Coffee",
                        value: room.coffee_powder_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Tea",
                        value: room.tea_powder_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "Hair Dryer",
                        value: room.hair_dryer_availability!,
                      ),
                      AmenitiesAvailabilityChipCard(
                        text: "T.V",
                        value: room.tv_availability!,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Rooms: ${room.room_count}",
                        style: TextStyle(
                            color: UsedColors.mainColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomMaterialButton(
                          buttonColor: room.room_count == 0
                              ? UsedColors.mainColor.withOpacity(0.2)
                              : null,
                          height: 39,
                          onPressed: room.room_count == 0
                              ? () {}
                              : () {
                                  if (context
                                          .read<UserDetailsStorageBloc>()
                                          .state
                                          .isLoggedIn ==
                                      false) {
                                    showPopup(
                                        context: context,
                                        description: "You need to Login First",
                                        title: "Login Required",
                                        type: ToastificationType.error);
                                    Navigator.pushNamed(context, "/login");
                                    return;
                                  }
                                  context.read<StoreBookDetailsCubit>()
                                    ..clearEverything();
                                  print("The room si ${room}");
                                  context.read<StoreBookDetailsCubit>()
                                    ..storeRoomDetails(
                                        room: room,
                                        roomId: room.id!,
                                        accommodation: accommodation);
                                  Navigator.pushNamed(context, "/book");
                                },
                          text: room.room_count == 0 ? "Unavailable" : "Book",
                          width: 120),
                    ],
                  ),
                )

                // );
                // GridView.builder(
                //   itemCount: 3,
                //   shrinkWrap: true,
                //   gridDelegate:
                //       SliverGridDelegateWithFixedCrossAxisCount(
                //           crossAxisCount: 1,
                //           // childAspectRatio: 3 / 4,
                //           // mainAxisExtent: 0.1,
                //           mainAxisSpacing: 0,
                //           crossAxisSpacing: 02),
                //   itemBuilder: (context, index) {
                //     return Container(
                //       width: 100,
                //       height: 100,
                //       decoration: BoxDecoration(
                //           color: UsedColors.fadeOutColor,
                //           border: Border(),
                //           borderRadius:
                //               BorderRadius.circular(10)),
                //       child: Text(
                //         "data",
                //         style: TextStyle(
                //             color: UsedColors.mainColor),
                //       ),
                //     );
                //   },
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
