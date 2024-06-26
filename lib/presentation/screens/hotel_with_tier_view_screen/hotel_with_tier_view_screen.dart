import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../constants/constant_exports.dart';
import '../../../data/data_exports.dart';
import '../../../logic/logic_exports.dart';
import '../screens_export.dart';

class HotelWithTierViewScreen extends StatelessWidget {
  final Map data;

  const HotelWithTierViewScreen({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            List<HotelTier> hotelTier = state.hotel_tier!;
            return RefreshIndicator(
                child: SingleChildScrollView(
                  child: Column(
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
                              height: 32,
                            ),
                            Text(
                              "Amenities",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CustomAmenitiesScrollable(
                                  room: Room(), accommodation: accommodation),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Text(
                              "Tiers",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: hotelTier.length,
                                itemBuilder: (context, index) {
                                  if (hotelTier[index].rooms == null ||
                                      hotelTier[index].rooms!.length <= 0) {
                                    return SizedBox();
                                  }
                                  return Container(
                                    // color: Colors.black,
                                    child: Column(
                                      children: [
                                        CustomHotelTierDescriptionCard(
                                            hotelTier: hotelTier[index]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          height: 350,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: hotelTier[index]
                                                  .rooms!
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (context, roomIndex) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: HotelWithTierRoomCard(
                                                    room: hotelTier[index]
                                                        .rooms![roomIndex]!,
                                                  ),
                                                );
                                              }),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
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
                onRefresh: () async {
                  return loadAccommodation(context, data['id']);
                });
          }
          return Column(
            children: [Text("hotel With Tier View Screen")],
          );
        },
      ),
    );
  }
}

class CustomHotelTierDescriptionCard extends StatelessWidget {
  const CustomHotelTierDescriptionCard({
    super.key,
    required this.hotelTier,
  });

  final HotelTier hotelTier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341,
      height: 225,
      decoration: BoxDecoration(
          color: UsedColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: UsedColors.fadeOutColor, width: 1)),
      child: Column(
        children: [
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: "${getIpNoBackSlash()}${hotelTier.image}",
              maxHeightDiskCache: 200,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 124,
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
                    height: 124,
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
                    height: 124,
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${hotelTier.tier_name}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: UsedColors.textColor),
                    ),
                    Text(
                      "Rs 2000 - 3000",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: UsedColors.mainColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${hotelTier.description}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: UsedColors.fadeOutColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelWithTierRoomCard extends StatelessWidget {
  const HotelWithTierRoomCard({
    super.key,
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 341,
      height: 310,
      decoration: BoxDecoration(
          color: UsedColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: UsedColors.fadeOutColor, width: 1)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
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
                  padding: EdgeInsets.symmetric(vertical: 15),
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
                          height: 39,
                          onPressed: () {},
                          text: "Book",
                          width: 120)
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
