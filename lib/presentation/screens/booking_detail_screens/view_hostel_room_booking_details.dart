import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stayfinder_customer/constants/constant_exports.dart';
import 'package:stayfinder_customer/data/data_exports.dart';

import '../../../logic/logic_exports.dart';
import '../../widgets/widgets_export.dart';
import 'booking_detail_api_call.dart';

class HostelRoomBookingHistory extends StatelessWidget {
  final Map data;

  HostelRoomBookingHistory({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchParticularBookingDetailsCubit,
          FetchParticularBookingDetailsState>(
        builder: (context, state) {
          if (state is FetchParticularBookingDetailsLoading) {
            return CircularProgressIndicator();
          }
          if (state is FetchParticularBookingDetailsError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRedHatFont(
                      text: state.message,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CustomMaterialButton(
                        width: MediaQuery.of(context).size.width / 4,
                        text: "Retry",
                        onPressed: () async {
                          // if (state is LoginLoaded) {
                          CallBookingDetailedDetailsParticularAPi
                              .fetchHotelWithTierApis(
                                  id: data["id"].toString(),
                                  accommodation: data["accommodation"],
                                  context: context);
                          // }

                          // CallHotelWithTierAPi.fetchHotelWithTierApis(
                          //     context: context,
                          //     token: data['token'],
                          //     accommodationID: data['id'].toString());
                          // fetchHotelWithTierApis(
                          //     accommodationID: data['id'].toString(),
                          //     token: data['token'],
                          //     context: context);
                        },
                        height: 45),
                  )
                ],
              ),
            );
          }
          if (state is FetchParticularBookingDetailsLoaded) {
            Room room = state.room!;
            Accommodation accommodation = state.accommodation!;

            BookModel booked = state.booked!;
            return RefreshIndicator(
                onRefresh: () async {
                  CallBookingDetailedDetailsParticularAPi
                      .fetchHotelWithTierApis(
                          id: data["id"].toString(),
                          accommodation: data["accommodation"],
                          context: context);
                },
                child: SingleChildScrollView(
                    child: Column(children: [
                  Stack(
                    children: [
                      CustomMainImageVIew(
                        imageLink:
                            "${getIpNoBackSlash()}${state.accommodation!.image}",
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: SafeArea(
                              child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          )))
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Booking Details"),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle_outlined,
                                            color: Color(0xff4c4c4c)),
                                        SizedBox(width: 8),
                                        CustomRedHatFont(
                                            text: booked.user!.full_name!,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color: Color(0xff4c4c4c),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        CustomRedHatFont(
                                            text: booked.user!.email!,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.payment_outlined,
                                            color: Color(0xff4c4c4c)),
                                        SizedBox(width: 8),
                                        CustomRedHatFont(
                                          text:
                                              "At Rs ${booked.paid_amount.toString()}",
                                          fontSize: 14,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today_outlined,
                                                color: Color(0xff4c4c4c)),
                                            SizedBox(width: 8),
                                            CustomRedHatFont(
                                              text: booked.check_in.toString(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        Text(" -- "),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month,
                                                color: Color(0xff4c4c4c)),
                                            SizedBox(width: 8),
                                            CustomRedHatFont(
                                              text: booked.check_out.toString(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CustomRedHatFont(
                                      text: accommodation.name!,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomRedHatFont(
                                          text: "Rs",
                                          fontSize: 15,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CustomRedHatFont(
                                          text: accommodation.admission_rate!
                                              .toString(),
                                          fontSize: 23,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                ],
                              ),
                              // if (
                              //         .accommodation!.is_rejected! ||
                              //
                              //         .accommodation!.is_verified!)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Color(0xff4c4c4c).withOpacity(0.5),
                            height: 0.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Boxicons.bx_map_pin,
                                size: 14,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomRedHatFont(
                                  text:
                                      "${accommodation.city}, ${accommodation.address}",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.toilet,
                                    size: 14,
                                    color: Color(0xffFFAB1C),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomRedHatFont(
                                      text: accommodation.number_of_washroom
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Boxicons.bxs_washer,
                                    size: 14,
                                    color: Color(0xffFF5833),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomRedHatFont(
                                      text: accommodation.weekly_laundry_cycles
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  // CustomVerifiedWidget(
                                  //     value:
                                  //         .accommodation!.weekly_laundry_cycles!),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.parking,
                                    size: 14,
                                    color: Color(0xff4C4C4C),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomVerifiedWidget(
                                      value:
                                          accommodation.parking_availability!)
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Icon(
                                  //   Icons.,
                                  //   size: 14,
                                  //   color: Color(0xffFFAB1C),
                                  // ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(500)),
                                      ),
                                      Text(
                                        "Non-Veg",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),

                                  CustomRedHatFont(
                                      text: accommodation.weekly_non_veg_meals
                                          .toString(),
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.food_bank,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "Meals/Day",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: Colors.blue),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomRedHatFont(
                                      text: accommodation.meals_per_day
                                          .toString(),
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text("Booked Room Details"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            HostelViewCard(
                              images: state.roomImage as List<RoomImage>,
                              id: room.id!,
                              onEdit: (p0) {},
                              onChangePhoto: (p0) async {},
                              bedCount: room.seater_beds.toString(),
                              fanAvailability: room.fan_availability!,
                              onDelete: (p0) {},
                              ruppes: room.monthly_rate.toString(),
                              roomIndex: 0,
                              washRoomStatus: room.washroom_status.toString(),
                            )
                          ]))
                ])));
          }
          return Column(
            children: [Text("I am under da water heodad")],
          );
        },
      ),
    );
  }
}

class HostelViewCard extends StatelessWidget {
  final List<RoomImage> images;
  final Function(BuildContext) onEdit;
  final Function(BuildContext) onDelete;
  final Function(BuildContext) onChangePhoto;
  final int roomIndex;
  final bool fanAvailability;
  final String bedCount;

  final String washRoomStatus;
  final String ruppes;
  final int id;

  const HostelViewCard({
    required this.images,
    super.key,
    required this.id,
    required this.onEdit,
    required this.onDelete,
    required this.onChangePhoto,
    required this.roomIndex,
    required this.fanAvailability,
    required this.washRoomStatus,
    required this.ruppes,
    required this.bedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 1,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.transparent,
              onPressed: onEdit,
              foregroundColor: Color(0xff878e92),
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: onChangePhoto,
              backgroundColor: Colors.transparent,
              foregroundColor: Color(0xff514f53),
              icon: Icons.photo,
              label: 'Change',
            ),
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        // endActionPane: ActionPane(motion: motion, children: children),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: FlutterCarousel(
                          items: [
                            Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${getIpNoBackSlash()}${images[0].images}")
                                //  Image.asset(
                                //     "assets/profile/citizenship_back.jpeg")
                                ),
                            Container(
                                height: 100,
                                width: 100,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "${getIpNoBackSlash()}${images[1].images}")),
                          ],
                          options: CarouselOptions(
                              // controller: buttonCarsouselController,
                              height: 100,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              showIndicator: false,
                              initialPage: 0,
                              autoPlay: true,
                              // showIndicator: true,
                              scrollDirection: Axis.horizontal)),
                    ),
                    Expanded(
                      child: Container(
                        // decoration: BoxDecoration(color: Colors.),
                        // color: Colors.red,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Room ${roomIndex}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bed,
                                        // color: Colors.cyan,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      CustomRedHatFont(
                                          text: bedCount,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  ),
                                  // SizedBox()
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.fan,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomVerifiedWidget(
                                          value: fanAvailability)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.toilet,
                                        size: 14,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        washRoomStatus,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.dollarSign,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "rs $ruppes",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
                // Row(
                //   children: [
                //     Container(
                //         height: 50,
                //         width: 50,
                //         child: Image.asset("assets/logos/logo.png"))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
