import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../data/data_exports.dart';
import '../../../logic/logic_exports.dart';

class BookingRequestHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchBookingRequestHistoryCubit,
          FetchBookingRequestHistoryState>(
        builder: (context, state) {
          if (state is FetchBookingRequestHistoryLoading) {
            return Center(
              child: CustomLoadingWidget(
                text: "Fetching Accommodation",
              ),
            );
          }
          if (state is FetchBookingRequestHistoryError) {
            return BlocBuilder<UserDetailsStorageBloc, UserDetailsStorageState>(
              builder: (context, state2) {
                return CustomErrorScreen(
                  message: state.message,
                  onPressed: () => context
                      .read<FetchBookingRequestHistoryCubit>()
                    ..fetchBookingRequestHistory(token: state2.user!.token!),
                );
              },
            );
          }
          if (state is FetchBookingRequestHistorySuccess) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomRedHatFont(
                                  text: "Booking Request History",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (state.bookRequest.length == 0)
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
                                "No Requests Yet",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ListView.builder(
                          itemCount: state.bookRequest.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            BookingRequest bookModel = state.bookRequest[index];
                            Accommodation accommodation =
                                bookModel.room!.accommodation!;
                            RoomAccommodation room = bookModel.room!;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                CardBookHistoryRequestCard(
                                  image: accommodation.image!,
                                  roomId: bookModel.room!.id!,
                                  requestId: bookModel.id!,
                                  status: bookModel.status!,
                                  accommodationType: accommodation.type!,
                                  location:
                                      "${accommodation.city}, ${accommodation.address}",
                                  name: accommodation.name!,
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
              ),
            );
          }
          return Text("");
        },
      ),
    );
  }
}
