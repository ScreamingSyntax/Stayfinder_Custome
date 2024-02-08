import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class BookStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
        child: BlocBuilder<FetchBookingRequestCubit, FetchBookingRequestState>(
          builder: (context, state) {
            if (context.read<UserDetailsStorageBloc>().state.isLoggedIn ==
                false) {
              return BookingsLoggedOutScreen();
            }
            if (state is FetchBookingRequestLoading) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: CustomLoadingWidget(
                      text: "Getting Accommodations",
                    ),
                  ),
                ],
              );
            }
            if (state is FetchBookingRequestError) {
              return Column(
                children: [
                  CustomErrorScreen(
                    message: state.message,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomMaterialButton(
                      height: 45,
                      onPressed: () {
                        CallBookingDetailsParticularAPi.fetchHotelWithTierApis(
                            token: context
                                .read<UserDetailsStorageBloc>()
                                .state
                                .user!
                                .token!,
                            context: context);
                      },
                      text: "Retry",
                      width: MediaQuery.of(context).size.width / 2)
                ],
              );
            }
            if (state is FetchBookingRequestInitial) {
              CallBookingDetailsParticularAPi.fetchHotelWithTierApis(
                  token:
                      context.read<UserDetailsStorageBloc>().state.user!.token!,
                  context: context);
            }
            if (state is FetchBookingRequestSuccesss) {
              return RefreshIndicator(
                onRefresh: () async {
                  var loginState = context.read<UserDetailsStorageBloc>().state;
                  context.read<FetchBookingRequestCubit>().fetchBookingRequests(
                        token: loginState.user!.token!,
                      );
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        if (state.bookedCustomers.length == 0 &&
                            state.bookingRequests.length == 0)
                          Column(
                            children: [
                              Text(
                                "Your Bookings",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/no_results_found.png"))),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "You haven't booked a place to stay yet.",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: 12, wordSpacing: 2),
                                ),
                              )
                            ],
                          ),
                        CurrentBookings(state),
                        SizedBox(
                          height: 20,
                        ),
                        BookingRequests(state),
                      ],
                    ),
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

  Column BookingRequests(FetchBookingRequestSuccesss state) {
    return Column(
      children: [
        if (state.bookingRequests.length != 0)
          Align(
            alignment: Alignment.center,
            child: CustomRedHatFont(
                text: "Your Requests",
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        SizedBox(
          height: 19,
        ),
        ListView.builder(
            itemCount: state.bookingRequests.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              BookingRequest bookModel = state.bookingRequests[index];
              Accommodation accommodation = bookModel.room!.accommodation!;
              RoomAccommodation room = bookModel.room!;
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  BookRequestCustomCard(
                    onPressed: () {
                      context.read<StoreBookDetailsCubit>()..clearEverything();
                      print("The room si ${room}");
                      context.read<StoreBookDetailsCubit>()
                        ..storeRoomDetails(
                            requestId: bookModel.id,
                            room: Room(
                                ac_availability: room.ac_availability,
                                accommodation: room.accommodation!.id!,
                                bed_availability: room.bed_availability,
                                carpet_availability: room.carpet_availability,
                                coffee_powder_availability:
                                    room.coffee_powder_availability,
                                dustbin_availability: room.dustbin_availability,
                                fan_availability: room.fan_availability,
                                hair_dryer_availability:
                                    room.hair_dryer_availability,
                                id: room.id,
                                kettle_availability: room.kettle_availability,
                                water_bottle_availability:
                                    room.water_bottle_availability,
                                mat_availability: room.mat_availability,
                                milk_powder_availability:
                                    room.milk_powder_availability,
                                monthly_rate: room.monthly_rate,
                                per_day_rent: room.per_day_rent,
                                room_count: room.room_count,
                                seater_beds: room.seater_beds,
                                sofa_availability: room.sofa_availability,
                                steam_iron_availability: room.sofa_availability,
                                tea_powder_availability:
                                    room.tea_powder_availability,
                                tv_availability: room.tv_availability,
                                washroom_status: room.washroom_status),
                            roomId: room.id!,
                            accommodation: accommodation);
                      Navigator.pushNamed(context, "/book");
                    },
                    roomId: bookModel.room!.id!,
                    requestId: bookModel.id!,
                    status: bookModel.status!,
                    accommodationType: accommodation.type!,
                    location: "${accommodation.city}, ${accommodation.address}",
                    name: accommodation.name!,
                    ratings: "5",
                    roomBookedDetails: accommodation.type == "rent_room"
                        ? ""
                        : room.seater_beds.toString(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ],
    );
  }

  Column CurrentBookings(FetchBookingRequestSuccesss state) {
    return Column(
      children: [
        if (state.bookedCustomers.length != 0)
          Align(
            alignment: Alignment.center,
            child: CustomRedHatFont(
                text: "Currently Booked",
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        SizedBox(
          height: 19,
        ),
        ListView.builder(
            itemCount: state.bookedCustomers.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              BookModel bookModel = state.bookedCustomers[index];
              Accommodation accommodation = bookModel.room!.accommodation!;
              RoomAccommodation room = bookModel.room!;
              return Column(
                children: [
                  // Text(data)
                  SizedBox(
                    height: 10,
                  ),
                  CurrentlyBookedCard(
                    accommodationType: accommodation.type!,
                    date: "${bookModel.check_in} - ${bookModel.check_out}",
                    location: "${accommodation.city}, ${accommodation.address}",
                    name: accommodation.name!,
                    price: bookModel.paid_amount!,
                    ratings: "5",
                    roomBookedDetails: accommodation.type == "rent_room"
                        ? ""
                        : room.seater_beds.toString(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ],
    );
  }
}

class BookingsLoggedOutScreen extends StatelessWidget {
  const BookingsLoggedOutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/otp_screen.png"))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Oops.... You might need to login first",
          ),
          SizedBox(
            height: 20,
          ),
          CustomMaterialButton(
            height: 39,
            width: 120,
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            text: "Login/ Signup",
          ),
        ],
      ),
    );
  }
}
