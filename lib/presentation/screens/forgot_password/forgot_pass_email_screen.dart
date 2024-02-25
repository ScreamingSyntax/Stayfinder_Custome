// ignore_for_file: must_be_immutable

import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:stayfinder_customer/utils/extensions.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  TextEditingController _emailController = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ForgotPassSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      ForgotPasswordOtpScreen(email: _emailController.text)));
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
        appBar: AppBar(
          title: Text(
            "Forgot Password ",
            style: TextStyle(
                color: UsedColors.fadeTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/no_results_found.png"),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    borderColor: UsedColors.fadeOutColor,
                    hintText: "Email",
                    borderRadius: 10,
                    contentCenter: false,
                    onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                    validator: (p0) {
                      if (!(p0!.isValidEmail())) {
                        return "Invalid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ForgotPassCubit, ForgotPassState>(
                    builder: (context, state) {
                      if (state is ForgotPassLoading) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()],
                            ));
                      }
                      return CustomMaterialButton(
                          height: 50,
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              context.read<ForgotPassCubit>()
                                ..forgotPassword(email: _emailController.text);
                            }
                          },
                          text: "Confirm",
                          width: MediaQuery.of(context).size.width);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
