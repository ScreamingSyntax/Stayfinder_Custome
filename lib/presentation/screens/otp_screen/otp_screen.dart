import 'package:cherry_toast/cherry_toast.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/theme/colors.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class OtpScreen extends StatelessWidget {
  OtpFieldControllerV2 controller = new OtpFieldControllerV2();
  @override
  Widget build(BuildContext context) {
    var state = context.watch<StoreTempUserDetailsCubit>().state;
    return BlocListener<CustomerRegistrationCubit, CustomerRegistrationState>(
      listener: (context, state) {
        if (state is CustomerRegistrationLoaded) {
          context.read<StoreTempUserDetailsCubit>()..clearData();
          Navigator.pushNamed(context, "/login");
          showPopup(
              context: context,
              description: "Success",
              title: state.message,
              type: ToastificationType.success);
          return;
        }
        if (state is CustomerRegistrationError) {
          showPopup(
              context: context,
              description: "Error",
              title: state.message,
              type: ToastificationType.error);
          return;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 354,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/otp_screen.png")),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hmm... Let's Verify",
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
                      var state =
                          context.read<StoreTempUserDetailsCubit>().state;
                      context.read<CustomerRegistrationCubit>()
                        ..registrationWithOtp(
                            fullName: state.name!,
                            email: state.email!,
                            image: state.image!,
                            otp: pin,
                            password: state.password!);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
