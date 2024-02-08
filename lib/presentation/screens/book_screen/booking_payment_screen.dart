import 'dart:async';

import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/khalti_methods.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../constants/constant_exports.dart';
import '../screens_export.dart';

class BookingPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<StoreBookDetailsCubit, StoreBookDetailsState>(
            builder: (context, state) {
              return Container(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      BookingPaymentScreenTop(
                        state: state,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (state.accommodation!.type != "rent_room" &&
                          state.accommodation!.type != "hostel")
                        NotRentalAndHostelRoomBookingCard(
                          state: state,
                        )
                      else
                        RentalAndHostelRoomBookingCard(
                          state: state,
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BookingPaymentScreenTop extends StatelessWidget {
  final StoreBookDetailsState state;
  const BookingPaymentScreenTop({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        key: UniqueKey(),
        imageUrl: "${getIpNoBackSlash()}${state.accommodation!.image!}",
        maxHeightDiskCache: 200,
        imageBuilder: (context, imageProvider) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 204,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(fit: BoxFit.cover, image: imageProvider)),
          );
        },
        placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              height: 204,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ),
        errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: 204,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ));
  }
}

class RentalAndHostelRoomBookingCard extends StatelessWidget {
  final StoreBookDetailsState state;
  const RentalAndHostelRoomBookingCard({
    super.key,
    required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.hotel,
                    color: UsedColors.mainColor), // Accommodation icon
                title: Text(
                  "${state.accommodation!.name}",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: state.accommodation!.type == "hostel"
                    ? Text("Seater Beds: ${state.room!.seater_beds}")
                    : null,
              ),
              ListTile(
                leading: Icon(Icons.calendar_today,
                    color: UsedColors.mainColor), // Calendar icon
                title: Text(
                  "Stay Duration",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("From: ${state.checkIn} to ${state.checkOut}"),
              ),
              ListTile(
                leading: Icon(Icons.nights_stay,
                    color: UsedColors.mainColor), // Nights icon
                title: Text(
                  "Days to Stay",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle:
                    Text("${calculateDays(state.checkIn!, state.checkOut!)}"),
              ),
              ListTile(
                leading: Icon(IconlyBold.calendar,
                    color: UsedColors.mainColor), // Nights icon
                title: Text(
                  "Months to Stay",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("${state.monthCount}"),
              ),
              ListTile(
                leading: Icon(Icons.attach_money,
                    color: UsedColors.mainColor), // Money icon
                title: Text(
                    state.accommodation!.type == "hostel"
                        ? "Total Amount: ${state.monthCount! * state.room!.monthly_rate!}"
                        : "Total Amount: ${state.monthCount! * state.accommodation!.monthly_rate!}",
                    style: TextStyle(
                        color: UsedColors.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: CustomMaterialButton(
              height: 45,
              onPressed: () {
                var loginState = context.read<UserDetailsStorageBloc>().state;

                if (state.accommodation!.type == "hostel") {
                  payWithKhaltiInApp(
                      context: context,
                      roomId: state.room!.id!,
                      checkIn: state.checkIn!,
                      checkOut: state.checkOut!,
                      paidAmount: state.room!.monthly_rate! * state.monthCount!,
                      accommodationName: state.accommodation!.name!,
                      token: loginState.user!.token!);
                } else {
                  if (state.accommodation!.type == "hostel") {
                    payWithKhaltiInApp(
                        context: context,
                        roomId: state.room!.id!,
                        checkIn: state.checkIn!,
                        checkOut: state.checkOut!,
                        paidAmount: state.accommodation!.monthly_rate! *
                            state.monthCount!,
                        accommodationName: state.accommodation!.name!,
                        token: loginState.user!.token!);
                  }
                }
              },
              text: "Confirm",
              width: MediaQuery.of(context).size.width),
        )
      ],
    );
  }
}

class NotRentalAndHostelRoomBookingCard extends StatelessWidget {
  final StoreBookDetailsState state;
  const NotRentalAndHostelRoomBookingCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(15), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.hotel,
                    color: UsedColors.mainColor), // Accommodation icon
                title: Text(
                  "${state.accommodation!.name}",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("Seater Beds: ${state.room!.seater_beds}"),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today,
                    color: UsedColors.mainColor), // Calendar icon
                title: Text(
                  "Stay Duration",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text("From: ${state.checkIn} to ${state.checkOut}"),
              ),
              ListTile(
                leading: Icon(Icons.nights_stay,
                    color: UsedColors.mainColor), // Nights icon
                title: Text(
                  "Days to Stay",
                  style: TextStyle(
                      color: UsedColors.fadeTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                subtitle:
                    Text("${calculateDays(state.checkIn!, state.checkOut!)}"),
              ),
              ListTile(
                leading: Icon(Icons.attach_money,
                    color: UsedColors.mainColor), // Money icon
                title: Text(
                    "Total Amount: ${state.room!.per_day_rent! * calculateDays(state.checkIn!, state.checkOut!)}",
                    style: TextStyle(
                        color: UsedColors.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
          child: CustomMaterialButton(
              height: 45,
              onPressed: () {
                var loginState = context.read<UserDetailsStorageBloc>().state;
                payWithKhaltiInApp(
                    context: context,
                    roomId: state.room!.id!,
                    checkIn: state.checkIn!,
                    checkOut: state.checkOut!,
                    paidAmount: state.accommodation!.type! == "rent_room"
                        ? state.accommodation!.monthly_rate! *
                            calculateDays(state.checkIn!, state.checkOut!)
                        : state.room!.per_day_rent! *
                            calculateDays(state.checkIn!, state.checkOut!),
                    accommodationName: state.accommodation!.name!,
                    token: loginState.user!.token!);
              },
              text: "Confirm",
              width: MediaQuery.of(context).size.width),
        )
      ],
    );
  }
}
