import 'package:boxicons/boxicons.dart';
import 'package:stayfinder_customer/constants/constant_exports.dart';
import 'package:stayfinder_customer/data/data_exports.dart';

import '../../../logic/logic_exports.dart';
import '../../widgets/widgets_export.dart';
import 'booking_detail_api_call.dart';

class RentalRoomBookingScreen extends StatelessWidget {
  final Map data;

  const RentalRoomBookingScreen({super.key, required this.data});
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
            BookModel booked = state.booked!;
            return RefreshIndicator(
              onRefresh: () async {
                // if (state is LoginLoaded) {
                return CallBookingDetailedDetailsParticularAPi
                    .fetchHotelWithTierApis(
                        id: data["id"].toString(),
                        accommodation: data["accommodation"],
                        context: context);
              },
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(children: [
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
                            offset: Offset(0, 3), // changes position of shadow
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
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
                                      text: state.accommodation!.name!,
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
                                          text: state
                                              .accommodation!.monthly_rate!
                                              .toString(),
                                          fontSize: 23,
                                          color: Color(0xff4c4c4c),
                                          fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                ],
                              ),
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
                                      "${state.accommodation!.city}, ${state.accommodation!.address}",
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
                                      text: state
                                          .accommodation!.number_of_washroom
                                          .toString(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.dumpster,
                                    size: 14,
                                    color: Color(0xffFF5833),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomVerifiedWidget(
                                      value: state.accommodation!
                                          .trash_dispose_availability!),
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
                                      value: state
                                          .accommodation!.parking_availability!)
                                ],
                              ),
                            ],
                          ),

                          // ListView.builder(
                          //   itemCount: 5,
                          //   itemBuilder: (context, index) {
                          //   return
                          // },)

                          // CustomRedHatFont(text: "", fontSize: fontSize, fontWeight: fontWeight)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRedHatFont(
                                  text: "Room Images",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.roomImage!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            RoomImageRental(
                                                image: NetworkImage(
                                                    "${getIpNoBackSlash()}${state.roomImage![index]!.images}")),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRedHatFont(
                                  text: "Room Details",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RoomDetailWidgetRental(
                            text: "Bed",
                            value: state.room!.bed_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Fan",
                            value: state.room!.fan_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Sofa",
                            value: state.room!.sofa_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Mat",
                            value: state.room!.mat_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Carpet",
                            value: state.room!.carpet_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CustomRedHatFont(
                                  text: '\u2022 Washroom Status :',
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                width: 10,
                              ),
                              CustomRedHatFont(
                                  text: state.room!.washroom_status!,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Dustbin",
                            value: state.room!.dustbin_availability!,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RoomDetailWidgetRental(
                            text: "Trash Disposable",
                            value: state
                                .accommodation!.trash_dispose_availability!,
                          ),
                        ],
                      ),
                      // color: Colors.amber,

                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ])
              ])),
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}

class RoomImageRental extends StatelessWidget {
  const RoomImageRental({super.key, required this.image});
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xff29383F).withOpacity(0.8),
              width: 2,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.cover, image: image)),
    );
  }
}
