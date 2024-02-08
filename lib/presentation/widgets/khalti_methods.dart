import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'widgets_export.dart';

void showPaymentResult(BuildContext context, String title,
    {PaymentSuccessModel? successModel,
    PaymentFailureModel? failureModel,
    required int roomId,
    required String checkIn,
    required String checkOut,
    required int paidAmount,
    required String accommodationName,
    required String token,
    String? requestId}) {
  showDialog(
    context: context,
    builder: (_) {
      if (successModel != null) {
        context.read<DirectBookingCubit>()
          ..goBook(
              requestId: requestId,
              token: token,
              roomId: roomId,
              checkIn: checkIn,
              checkOut: checkOut,
              paidAmount: paidAmount);
      }
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff32454D),
          ),
        ),
        actions: [
          SimpleDialogOption(
              padding: EdgeInsets.all(8),
              child: Text(
                "Ok",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff32454D),
                ),
              ),
              onPressed: () {
                popMultipleScreens(context, 4);
              })
        ],
      );
    },
  );
}

void onCancel(BuildContext context) {
  Navigator.popAndPushNamed(context, "/");
  showPopup(
      context: context,
      description: "Your payment has been successfully cancelled",
      title: "Successfully Cancelled",
      type: ToastificationType.success);
  // customScaffold(
  //     context: context,
  //     title: "Sucessfully Cancelled",
  //     message: "Your payment has been sucessfully cancelled :) ",
  //     contentType: ContentType.success);
}

void payWithKhaltiInApp(
    {required BuildContext context,
    required int roomId,
    required String checkIn,
    required String checkOut,
    required int paidAmount,
    required String accommodationName,
    required String token,
    String? requestId}) {
  final config = PaymentConfig(
    amount: 101,
    productIdentity: roomId.toString(),
    productName: accommodationName,
  );

  KhaltiScope.of(context).pay(
    config: config,
    preferences: [PaymentPreference.khalti],
    onSuccess: (successModel) => showPaymentResult(
        context, "Successfully Paid for ${accommodationName} :)",
        token: token,
        successModel: successModel,
        accommodationName: accommodationName,
        requestId: requestId,
        checkIn: checkIn,
        checkOut: checkOut,
        paidAmount: paidAmount,
        roomId: roomId),
    onCancel: () => onCancel(context),
    onFailure: (paymentFailure) => showPaymentResult(context, "Failed Bro",
        accommodationName: accommodationName,
        requestId: requestId,
        checkIn: checkIn,
        token: token,
        checkOut: checkOut,
        paidAmount: paidAmount,
        roomId: roomId),
  );
}
