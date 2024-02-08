import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../data/data_exports.dart';
import '../screens_export.dart';

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchBookingHistoryCubit, FetchBookingHistoryState>(
        builder: (context, state) {
          if (state is FetchBookingHistoryLoading) {
            return Center(
              child: CustomLoadingWidget(
                text: "Fetching Accommodation",
              ),
            );
          }
          if (state is FetchBookingHistoryError) {
            return BlocBuilder<UserDetailsStorageBloc, UserDetailsStorageState>(
              builder: (context, state2) {
                return CustomErrorScreen(
                  message: state.message,
                  onPressed: () => context.read<FetchBookingHistoryCubit>()
                    ..fetchBookingHistory(token: state2.user!.token!),
                );
              },
            );
          }
          if (state is FetchBookingHistorySuccess) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomRedHatFont(
                            text: "Booking History",
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state.bookModel.length == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/no_results_found.png"))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              " No Bookings Yet",
                              style: TextStyle(
                                  fontSize: 12,
                                  // color: UsedColors.mainColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ListView.builder(
                        itemCount: state.bookModel.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          BookModel bookModel = state.bookModel[index];
                          Accommodation accommodation =
                              bookModel.room!.accommodation!;
                          RoomAccommodation room = bookModel.room!;
                          return Column(
                            children: [
                              // Text(data)
                              SizedBox(
                                height: 10,
                              ),
                              CurrentlyBookedCard(
                                accommodationType: accommodation.type!,
                                date:
                                    "${bookModel.check_in} - ${bookModel.check_out}",
                                location:
                                    "${accommodation.city}, ${accommodation.address}",
                                name: accommodation.name!,
                                price: bookModel.paid_amount!,
                                ratings: "5",
                                roomBookedDetails:
                                    accommodation.type == "rent_room"
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
                ),
              ),
            );
          }
          return Text("");
        },
      ),
    );
  }
}
