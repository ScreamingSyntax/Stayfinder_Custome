import 'package:flutter/cupertino.dart';
import 'package:stayfinder_customer/presentation/theme/colors.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:stayfinder_customer/utils/extensions.dart';

import '../../../logic/logic_exports.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerLoginCubit, CustomerLoginState>(
      listener: (context, state) {
        if (state is CustomerLoginLoaded) {
          // print(state.userModel);
          context.read<UserDetailsStorageBloc>()
            ..add(UserDetailsStore(userModel: state.userModel));
          Navigator.pushNamed(context, "/main");
          showPopup(
              context: context,
              description: "Successfully Logged In",
              title: "Success",
              type: ToastificationType.success);
          return;
        }
        if (state is CustomerLoginError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
          return;
        }
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomMaterialButton(
                    height: 53,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<CustomerLoginCubit>()
                          ..login(email: email.text, password: password.text);
                      }
                    },
                    text: "Login",
                    width: MediaQuery.of(context).size.width),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Donot Have and Account?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ImageStorageCubit>()..clearImage();
                        context.read<StoreTempUserDetailsCubit>()..clearData();
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: UsedColors.fadeTextColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: UsedColors.fadeTextColor),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Login with your password",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: UsedColors.fadeTextColor),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  CustomTextFormField(
                    controller: email,
                    borderColor: UsedColors.fadeOutColor,
                    hintText: "Email",
                    borderRadius: 10,
                    contentCenter: false,
                    validator: (p0) {
                      if (!(p0!.isValidEmail())) {
                        return "Invalid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: password,
                        borderColor: UsedColors.fadeOutColor,
                        hintText: "Password",
                        borderRadius: 10,
                        contentCenter: false,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Password cannot be null";
                          }

                          if (p0.length < 6) {
                            return "Password length cannot be lesser than six";
                          }

                          return null;
                        },
                        suffixIconOnPressed: () {
                          context.read<BooleanChangeCubit>().change();
                        },
                        obscureText:
                            !context.watch<BooleanChangeCubit>().state.value,
                        suffixIcon:
                            context.watch<BooleanChangeCubit>().state.value
                                ? Icons.remove_red_eye
                                : CupertinoIcons.eye_slash_fill,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
