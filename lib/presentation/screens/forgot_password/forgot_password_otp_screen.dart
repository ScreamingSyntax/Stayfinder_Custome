// ignore_for_file: must_be_immutable

import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  final String email;
  OtpFieldControllerV2 controller = new OtpFieldControllerV2();

  ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        if (state is ForgotPassSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => ForgotPasswordConfirmationScreen(
                      email: email,
                      otp: context
                          .read<StoreTempUserDetailsCubit>()
                          .state
                          .name!)));
          showPopup(
              context: context,
              description: state.message,
              title: "Success",
              type: ToastificationType.success);
        }
        if (state is ForgotPassError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      showExitPopup(
                          context: context,
                          message:
                              "Do you really want to cancel this operation? ",
                          title: "Confirmation",
                          noBtnFunction: () => Navigator.pop(context),
                          yesBtnFunction: () {
                            popMultipleScreens(context, 3);
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: UsedColors.mainColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset("assets/images/forgot_password.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Enter Otp",
                style: TextStyle(
                    color: UsedColors.fadeTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              OTPTextFieldV2(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  controller: controller,
                  otpFieldStyle: OtpFieldStyle(
                    disabledBorderColor: UsedColors.mainColor,
                    borderColor: UsedColors.mainColor,
                    enabledBorderColor: UsedColors.mainColor,
                    errorBorderColor: UsedColors.mainColor,
                    focusBorderColor: UsedColors.mainColor,
                  ),
                  fieldStyle: FieldStyle.box,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  outlineBorderRadius: 5,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    context.read<StoreTempUserDetailsCubit>().clearData();
                    context.read<StoreTempUserDetailsCubit>()
                      ..storeTempData(
                          image: File(""), name: pin, email: "", password: "");
                    context.read<ForgotPassCubit>()
                      ..forgotPassword(email: email, otp: pin);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
