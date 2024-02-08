import 'package:flutter/services.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/book_screen/booking_payment_screen.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:intl/intl.dart';

class BookScreen extends StatelessWidget {
  TextEditingController monthsCount = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UsedColors.backgroundColor,
      bottomNavigationBar:
          BlocBuilder<StoreBookDetailsCubit, StoreBookDetailsState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              BookingOnTapLogic(state, context);
            },
            child: Container(
              height: 90,
              alignment: Alignment.center,
              child: Text(
                "Next -> ",
                style: TextStyle(color: UsedColors.fadeTextColor, fontSize: 20),
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BookScreenTop(),
                SizedBox(
                  height: 20,
                ),
                BookScreenMiddle(),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<StoreBookDetailsCubit, StoreBookDetailsState>(
                  builder: (context, state) {
                    if (state.accommodation!.type! == "hostel" ||
                        state.accommodation!.type == "rent_room") {
                      return BookScreenBottomIfNotHotel(context, state);
                    }
                    return BookScreenBottomIfHotel(context, state);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row BookScreenBottomIfHotel(
      BuildContext context, StoreBookDetailsState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () async {
            String date = await dateTimeFormatter(context);
            if (date == "") {
              showPopup(
                  context: context,
                  description: "You need to select check in date",
                  title: "Date Not Selected",
                  type: ToastificationType.error);
            } else {
              context.read<StoreBookDetailsCubit>()
                ..storeCheckIn(checkIn: date);
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width / 2.5,
            // width: ,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: UsedColors.cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Check In"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: state.checkIn != null
                      ? Text(state.checkIn!)
                      : Text("YYYY - MM - DD"),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            String date = await dateTimeFormatter(context);
            if (date == "") {
              showPopup(
                  context: context,
                  description: "You need to select check out date",
                  title: "Date Not Selected",
                  type: ToastificationType.error);
            } else {
              context.read<StoreBookDetailsCubit>()
                ..storeCheckOut(checkOut: date);
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width / 2.5,
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
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Check Out"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: state.checkOut != null
                      ? Text(state.checkOut!)
                      : Text("YYYY - MM - DD"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column BookScreenBottomIfNotHotel(
      BuildContext context, StoreBookDetailsState state) {
    return Column(children: [
      CustomTextFormField(
        controller: monthsCount,
        hintText: "Enter Stay Duration (Months)",
        autoFocus: true,
        validator: (value) {
          // print(value.runtimeType);
          if (value == null || value.isEmpty) {
            return 'Please enter month count';
          }
          int? newValue = int.tryParse(value);
          if (newValue == null) {
            return "Months can only be in numbers";
          }
          return null;
        },
      ),
      SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: () async {
          String date = await dateTimeFormatter(context);
          if (date == "") {
            showPopup(
                context: context,
                description: "You need to select check in date",
                title: "Date Not Selected",
                type: ToastificationType.error);
          } else {
            context.read<StoreBookDetailsCubit>()..storeCheckIn(checkIn: date);
          }
        },
        child: Container(
            alignment: Alignment.center,
            height: 70,
            width: MediaQuery.of(context).size.width,
            // width: ,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: UsedColors.mainColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: UsedColors.cardColor,
            ),
            child: ListTile(
              leading: Icon(
                Icons.calendar_view_day,
                color: UsedColors.mainColor,
              ),
              title: Text(
                "Choose Start Date of Stay",
                style: TextStyle(
                    color: UsedColors.fadeTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
              subtitle: state.checkIn != null
                  ? Text(state.checkIn!)
                  : Text(
                      "YYYY - MM - DD",
                      style: TextStyle(
                          color: UsedColors.fadeTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 11),
                    ),
            )),
      )
    ]);
  }

  void BookingOnTapLogic(StoreBookDetailsState state, BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateTime today = DateTime(now.year, now.month, now.day);
    if (state.accommodation!.type == "hostel" ||
        state.accommodation!.type == "rent_room") {
      if (_formKey.currentState!.validate()) {
        String? checkIn = state.checkIn;

        if (checkIn == null) {
          showPopup(
              context: context,
              description: "One ore more dates are not selected",
              title: "Empty Error",
              type: ToastificationType.error);
        } else {
          DateTime checkInDate = format.parse(checkIn);
          int stayMonths = int.parse(monthsCount.text);
          String checkOutDate = calculateCheckOutDate(checkIn, stayMonths);
          print("This is Check oout date ${checkOutDate}");
          if (checkInDate.isBefore(today)) {
            showPopup(
                context: context,
                description: "The check-in date cannot be in the past",
                title: "Date Error",
                type: ToastificationType.error);
          } else {
            context.read<StoreBookDetailsCubit>()
              ..storeCheckOut(checkOut: checkOutDate.toString());
            context.read<StoreBookDetailsCubit>()
              ..storeMonthsCount(months: stayMonths);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => BookingPaymentScreen()));
          }
        }
      }
    } else {
      String? checkIn = state.checkIn;
      String? checkOut = state.checkOut;
      DateFormat format = DateFormat("yyyy-MM-dd");

      if (checkIn == null || checkOut == null) {
        showPopup(
            context: context,
            description: "One ore more dates are not selected",
            title: "Empty Error",
            type: ToastificationType.error);
      } else {
        DateTime checkInDate = format.parse(checkIn);
        DateTime checkOutDate = format.parse(checkOut);
        if (checkInDate.isBefore(today)) {
          showPopup(
              context: context,
              description: "The check-in date cannot be in the past",
              title: "Date Error",
              type: ToastificationType.error);
        } else if (checkOutDate.isBefore(checkInDate)) {
          showPopup(
              context: context,
              description: "The check-out date must be after the check-in date",
              title: "Date Error",
              type: ToastificationType.error);
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => BookingPaymentScreen()));
        }
      }
    }
  }
}

class BookScreenMiddle extends StatelessWidget {
  const BookScreenMiddle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Let's pick your book date",
      style: TextStyle(
          color: UsedColors.fadeTextColor,
          fontSize: 24,
          fontWeight: FontWeight.w500),
    );
  }
}

class BookScreenTop extends StatelessWidget {
  const BookScreenTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 354,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage("assets/images/book_on.png"))),
    );
  }
}
