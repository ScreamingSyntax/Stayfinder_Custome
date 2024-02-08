import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:stayfinder_customer/logic/cubits/image_storage/image_storage_cubit.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:stayfinder_customer/utils/extensions.dart';

import '../../../logic/cubits/image_helper/image_helper_cubit.dart';
import '../../../logic/logic_exports.dart';
import '../../theme/colors.dart';

class RegistrationScreen extends StatelessWidget {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordTwo = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerRegistrationCubit, CustomerRegistrationState>(
      listener: (context, state) {
        if (state is CustomerRegistrationLoaded) {
          context.read<StoreTempUserDetailsCubit>()
            ..storeTempData(
                image: context.read<ImageStorageCubit>().state.image!,
                name: name.text,
                email: email.text,
                password: password.text);
          Navigator.pushNamed(context, "/otp");
          showPopup(
              context: context,
              description: "Successfully Registration",
              title: "Success",
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
        // resizeToAvoidBottomInset: false,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RegistrationBottom(
            name: name,
            formKey: formKey,
            email: email,
            password: password,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegistrationTop(),
                    RegistrationForms(
                        name: name,
                        email: email,
                        password: password,
                        passwordTwo: passwordTwo)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegistrationBottom extends StatelessWidget {
  const RegistrationBottom({
    super.key,
    required this.name,
    required this.formKey,
    required this.email,
    required this.password,
  });

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CustomerRegistrationCubit, CustomerRegistrationState>(
            builder: (context, state) {
              if (state is CustomerRegistrationLoading) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              }
              return CustomMaterialButton(
                  height: 53,
                  onPressed: () {
                    print(name.text);
                    if (formKey.currentState!.validate()) {
                      if (context.read<ImageStorageCubit>().state.image ==
                          null) {
                        return CherryToast.error(
                          toastDuration: Duration(seconds: 3),
                          title: Text("Selection Failed",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          action: Text("Select atleast one image",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                        ).show(context);
                      }
                      context.read<CustomerRegistrationCubit>()
                        ..registration(
                            fullName: name.text,
                            email: email.text,
                            image:
                                context.read<ImageStorageCubit>().state.image!,
                            password: password.text);
                    }
                  },
                  text: "Register",
                  width: MediaQuery.of(context).size.width);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Donot Have and Account?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/login"),
                child: Text(
                  'Login',
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
    );
  }
}

class RegistrationForms extends StatelessWidget {
  const RegistrationForms({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.passwordTwo,
  });

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: name,
          obscureText: false,
          borderColor: UsedColors.fadeOutColor,
          hintText: "Name",
          borderRadius: 10,
          contentCenter: false,
          validator: (p0) {
            if (p0!.isEmpty) {
              return "Name cannnot be null";
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
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
          height: 15,
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
                if (p0 != passwordTwo.text) {
                  return "Passwords donot match";
                }
                return null;
              },
              suffixIconOnPressed: () {
                context.read<BooleanChangeCubit>().change();
              },
              obscureText: !context.watch<BooleanChangeCubit>().state.value,
              suffixIcon: context.watch<BooleanChangeCubit>().state.value
                  ? Icons.remove_red_eye
                  : CupertinoIcons.eye_slash_fill,
            );
          },
        ),
        SizedBox(
          height: 15,
        ),
        BlocBuilder<BooleanChangeCubit, BooleanChangeState>(
          builder: (context, state) {
            return CustomTextFormField(
              controller: passwordTwo,
              borderColor: UsedColors.fadeOutColor,
              hintText: "Confirm Password",
              borderRadius: 10,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return "Password cannot be null";
                }
                if (p0.length < 6) {
                  return "Password length cannot be lesser than six";
                }
                if (p0 != password.text) {
                  return "Passwords donot match !";
                }
                return null;
              },
              contentCenter: false,
              suffixIconOnPressed: () {
                context.read<BooleanChangeCubit>().change();
              },
              obscureText: !context.watch<BooleanChangeCubit>().state.value,
              suffixIcon: context.watch<BooleanChangeCubit>().state.value
                  ? Icons.remove_red_eye
                  : CupertinoIcons.eye_slash_fill,
            );
          },
        ),
        SizedBox(
          height: 15,
        ),
        Builder(builder: (context) {
          if (context.watch<ImageStorageCubit>().state.image != null) {
            return Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(context
                              .watch<ImageStorageCubit>()
                              .state
                              .image!))),
                ),
                SizedBox(
                  width: 20,
                ),
                CustomMaterialButton(
                  height: 40,
                  onPressed: () async {
                    var imageHelper =
                        context.read<ImageHelperCubit>().state.imageHelper!;
                    final xFiles = await imageHelper.pickImage();
                    if (xFiles.isNotEmpty) {
                      final croppedFile = await imageHelper.crop(
                          file: xFiles.first, cropStyle: CropStyle.rectangle);
                      print("This is cropped file ${croppedFile}");
                      if (croppedFile != null) {
                        context.read<ImageStorageCubit>()
                          ..storeImage(File(croppedFile.path));
                      }
                    } else {
                      CherryToast.error(
                        toastDuration: Duration(seconds: 3),
                        title: Text("Selection Failed",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        action: Text("Select atleast one image",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ).show(context);
                    }
                  },
                  text: "Add your image",
                  width: 100,
                  buttonColor: UsedColors.mainColor.withOpacity(0.5),
                )
              ],
            );
          }
          return Align(
            alignment: Alignment.centerLeft,
            child: CustomMaterialButton(
              height: 40,
              onPressed: () async {
                var imageHelper =
                    context.read<ImageHelperCubit>().state.imageHelper!;
                final xFiles = await imageHelper.pickImage();
                if (xFiles.isNotEmpty) {
                  final croppedFile = await imageHelper.crop(
                      file: xFiles.first, cropStyle: CropStyle.rectangle);
                  print("This is cropped file ${croppedFile}");
                  if (croppedFile != null) {
                    context.read<ImageStorageCubit>()
                      ..storeImage(File(croppedFile.path));
                  }
                } else {
                  CherryToast.error(
                    toastDuration: Duration(seconds: 3),
                    // disableToastAnimation: true,
                    title: Text("Selection Failed",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    action: Text("Select atleast one image",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12)),
                  ).show(context);
                }
              },
              text: "Add your image",
              width: 100,
              buttonColor: UsedColors.mainColor.withOpacity(0.5),
            ),
          );
        }),
      ],
    );
  }
}

class RegistrationTop extends StatelessWidget {
  const RegistrationTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Add Your Credentials",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: UsedColors.fadeTextColor),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Register your account",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: UsedColors.fadeTextColor),
        ),
        SizedBox(
          height: 34,
        ),
      ],
    );
  }
}
