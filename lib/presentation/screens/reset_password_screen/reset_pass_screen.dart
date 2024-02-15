import 'package:flutter/cupertino.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../logic/logic_exports.dart';

// ignore: must_be_immutable
class ResetPaswordScreen extends StatelessWidget {
  TextEditingController _oldPassController = new TextEditingController();
  TextEditingController _newPassController = new TextEditingController();
  TextEditingController _newPassConfirmController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPassCubit, ResetPassState>(
      listener: (context, state) {
        if (state is ResetPassError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
        }
        if (state is ResetPassSuccess) {
          Navigator.pop(context);

          showPopup(
              context: context,
              description: state.message,
              title: "Success",
              type: ToastificationType.success);
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Reset Password",
            style: TextStyle(fontSize: 12),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                CustomRedHatFont(
                    text: "Old Pass",
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                SizedBox(
                  height: 5,
                ),
                BlocProvider(
                  create: (context) => BooleanChangeCubit(),
                  child: Builder(builder: (context) {
                    return BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          suffixIconOnPressed: () {
                            context.read<BooleanChangeCubit>().change();
                          },
                          obscureText:
                              !context.watch<BooleanChangeCubit>().state.value,
                          suffixIcon:
                              context.watch<BooleanChangeCubit>().state.value
                                  ? Icons.remove_red_eye
                                  : CupertinoIcons.eye_slash_fill,
                          hintText: "Old Password",
                          controller: _oldPassController,
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
                  height: 15,
                ),
                CustomRedHatFont(
                    text: "New Pass",
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                SizedBox(
                  height: 5,
                ),
                BlocProvider(
                  create: (context) => BooleanChangeCubit(),
                  child: Builder(builder: (context) {
                    return BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          suffixIconOnPressed: () {
                            context.read<BooleanChangeCubit>().change();
                          },
                          obscureText:
                              !context.watch<BooleanChangeCubit>().state.value,
                          suffixIcon:
                              context.watch<BooleanChangeCubit>().state.value
                                  ? Icons.remove_red_eye
                                  : CupertinoIcons.eye_slash_fill,
                          hintText: "New Password",
                          controller: _newPassController,
                          validator: (p0) {
                            if (p0 == null || p0 == "") {
                              return "New pass cannot be null";
                            }

                            return null;
                          },
                        );
                      },
                    );
                  }),
                ),
                // CustomTextFormField(
                //   hintText: 'New Pass',
                //   controller: _newPassController,
                //   validator: (p0) {
                //     if (p0 == null || p0 == "") {
                //       return "New Pass cannot be null";
                //     }

                //     return null;
                //   },
                // ),
                SizedBox(
                  height: 15,
                ),
                CustomRedHatFont(
                    text: "Confirm New Pass",
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
                SizedBox(
                  height: 5,
                ),
                BlocProvider(
                  create: (context) => BooleanChangeCubit(),
                  child: Builder(builder: (context) {
                    return BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          suffixIconOnPressed: () {
                            context.read<BooleanChangeCubit>().change();
                          },
                          obscureText:
                              !context.watch<BooleanChangeCubit>().state.value,
                          suffixIcon:
                              context.watch<BooleanChangeCubit>().state.value
                                  ? Icons.remove_red_eye
                                  : CupertinoIcons.eye_slash_fill,
                          hintText: "Confirm New Password",
                          controller: _newPassConfirmController,
                          validator: (p0) {
                            if (p0 == null || p0 == "") {
                              return "New pass cannot be null";
                            }
                            if (_newPassController.text !=
                                _newPassConfirmController.text) {
                              return "The passwords donot match";
                            }

                            return null;
                          },
                        );
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomMaterialButton(
                    height: 45,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ResetPassCubit>()
                          ..resetPass(
                              token: context
                                  .read<UserDetailsStorageBloc>()
                                  .state
                                  .user!
                                  .token!,
                              newPassword: _newPassController.text,
                              oldPassword: _oldPassController.text);
                      }
                    },
                    text: "Confirm Reset",
                    width: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
