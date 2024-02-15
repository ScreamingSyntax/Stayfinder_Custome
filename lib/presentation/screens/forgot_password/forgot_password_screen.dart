// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class ForgotPasswordConfirmationScreen extends StatelessWidget {
  final String email;
  final String otp;
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordConfirmationScreen(
      {super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassCubit, ForgotPassState>(
      listener: (context, state) {
        if (state is ForgotPassSuccess) {
          showPopup(
              context: context,
              description: state.message,
              title: "Success",
              type: ToastificationType.success);
          return popMultipleScreens(context, 1);
        }
        if (state is ForgotPassError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          showExitPopup(
              context: context,
              message: "Are you sure you want to cancel? ",
              noBtnFunction: () => Navigator.pop(context),
              yesBtnFunction: () => popMultipleScreens(context, 3),
              title: "Confirmation");
          return true;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRedHatFont(
                          text: "New Pass",
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      BlocProvider(
                        create: (context) => BooleanChangeCubit(),
                        child: Builder(builder: (context) {
                          return BlocBuilder<BooleanChangeCubit,
                              BooleanChangeState>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                suffixIconOnPressed: () {
                                  context.read<BooleanChangeCubit>().change();
                                },
                                obscureText: !context
                                    .watch<BooleanChangeCubit>()
                                    .state
                                    .value,
                                suffixIcon: context
                                        .watch<BooleanChangeCubit>()
                                        .state
                                        .value
                                    ? Icons.remove_red_eye
                                    : CupertinoIcons.eye_slash_fill,
                                hintText: "New Password",
                                controller: _passwordController,
                                validator: (p0) {
                                  if (p0 == null || p0 == "") {
                                    return "Old pass cannot be null";
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomRedHatFont(
                          text: "Confirm New Pass",
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                      SizedBox(
                        height: 5,
                      ),
                      BlocProvider(
                        create: (context) => BooleanChangeCubit(),
                        child: Builder(builder: (context) {
                          return BlocBuilder<BooleanChangeCubit,
                              BooleanChangeState>(
                            builder: (context, state) {
                              return CustomTextFormField(
                                suffixIconOnPressed: () {
                                  context.read<BooleanChangeCubit>().change();
                                },
                                obscureText: !context
                                    .watch<BooleanChangeCubit>()
                                    .state
                                    .value,
                                suffixIcon: context
                                        .watch<BooleanChangeCubit>()
                                        .state
                                        .value
                                    ? Icons.remove_red_eye
                                    : CupertinoIcons.eye_slash_fill,
                                hintText: "New Password",
                                controller: _confirmPasswordController,
                                validator: (p0) {
                                  if (p0 == null || p0 == "") {
                                    return "Confirm pass cannot be null";
                                  }
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    return "Passwords donot match";
                                  }
                                  return null;
                                },
                              );
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomMaterialButton(
                          height: 45,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ForgotPassCubit>()
                                ..forgotPassword(
                                    email: email,
                                    newPass: _confirmPasswordController.text,
                                    otp: otp);
                            }
                          },
                          text: "Confirm",
                          width: MediaQuery.of(context).size.width)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
