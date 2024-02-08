import 'package:flutter/material.dart';
import 'package:stayfinder_customer/presentation/screens/booking_history/booking_history.dart';
import 'package:stayfinder_customer/presentation/screens/booking_requests_history/booking_request_history.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';

import '../../logic/logic_exports.dart';

class AppRouter {
  Route routeSettings(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return checkOnBoardingStatus();
      case "/main":
        return MaterialPageRoute(builder: (_) => MainScreen());
      case "/search":
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case "/searchResults":
        return MaterialPageRoute(builder: (_) => SearchResults());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case "/register":
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case "/otp":
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case "/book":
        return MaterialPageRoute(builder: (_) => BookScreen());
      case "/bookPayment":
        return MaterialPageRoute(builder: (_) => BookingPaymentScreen());
      case "/bookHistory":
        return MaterialPageRoute(builder: (_) => BookingHistoryScreen());
      case "/bookRequestHistory":
        return MaterialPageRoute(builder: (_) => BookingRequestHistoryScreen());
      case "/wishList":
        return MaterialPageRoute(builder: (_) => WishListScreen());
      case "/rentalScreenView":
        return MaterialPageRoute(
            builder: (_) => RentalRoomViewScreen(
                  data: settings.arguments as Map,
                ));
      case "/hotelNoTierScreenView":
        return MaterialPageRoute(
            builder: (_) => HotelWithoutTierViewScreen(
                  data: settings.arguments as Map,
                ));
      case "/hotelWithTierScreenView":
        return MaterialPageRoute(
            builder: (_) => HotelWithTierViewScreen(
                  data: settings.arguments as Map,
                ));
      case "/hostelWithTierScreenView":
        return MaterialPageRoute(
            builder: (_) => HostelViewScreen(
                  map: settings.arguments as Map,
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("No Route named ${settings.name} found")],
            ),
          ),
        );
    }
  }
}

MaterialPageRoute<dynamic> checkOnBoardingStatus() {
  return MaterialPageRoute(
      builder: (_) => Builder(builder: (context) {
            var status = context.read<OnBoardingBloc>().state.change;
            if (status == false) {
              return OnBoardingScreen();
            } else {
              return MainScreen();
            }
          }));
}
