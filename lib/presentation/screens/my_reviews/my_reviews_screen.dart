import 'package:cherry_toast/cherry_toast.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../constants/constant_exports.dart';
import '../../../data/data_exports.dart';
import '../screens_export.dart';

class MyReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateReviewCubit, UpdateReviewState>(
      listener: (context, state) {
        if (state is UpdateReviewsSuccess) {
          showPopup(
              context: context,
              description: state.message,
              title: "Success",
              type: ToastificationType.success);
          context.read<FetchAddedReviewsCubit>()
            ..fetchAddedReviews(
                token:
                    context.read<UserDetailsStorageBloc>().state.user!.token!);
          Navigator.pop(context);
        }
        if (state is UpdateReviewsError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "My Reviews",
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<FetchAddedReviewsCubit, FetchAddedReviewsState>(
            builder: (context, state) {
              if (state is FetchAdddedReviewsError) {
                return CustomErrorScreen(
                    message: state.message,
                    onPressed: () {
                      //  var state = context.read<UserDetails()
                      context.read<FetchAddedReviewsCubit>()
                        ..fetchAddedReviews(
                            token: context
                                .read<UserDetailsStorageBloc>()
                                .state
                                .user!
                                .token!);
                    });
              }
              if (state is FetchAddedReviewsLoading) {
                return Center(
                  child: CustomLoadingWidget(
                    text: "Fetching Your Reviews",
                  ),
                );
              }
              if (state is FetchAddedReviewsSuccess) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    if (state.reviews.length == 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/no_results_found.png"))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "No Reviews Yet",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ListView.builder(
                        itemCount: state.reviews.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ReviewModel reviewModel = state.reviews[index];
                          Accommodation accommodation =
                              reviewModel.accommodation!;
                          return MyReviewsCard(
                              accommodation: accommodation,
                              reviewModel: reviewModel);

                          // return Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: ListTile(
                          //     subtitle: Text(
                          //       reviewModel.description!,
                          //       style: TextStyle(
                          //           color: UsedColors.fadeOutColor, fontSize: 10),
                          //     ),
                          //     title: Text(
                          //       accommodation.name!,
                          //       style: TextStyle(
                          //           color: UsedColors.textColor, fontSize: 12),
                          //     ),
                          //     tileColor: UsedColors.cardColor,
                          //     leading: CachedNetworkImage(
                          //         width: 70,
                          //         height: 100,
                          //         key: UniqueKey(),
                          //         imageUrl:
                          //             "${getIpNoBackSlash()}${accommodation.image}",
                          //         maxHeightDiskCache: 200,
                          //         imageBuilder: (context, imageProvider) {
                          //           return Container(
                          //             decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(100),
                          //                 image: DecorationImage(
                          //                     fit: BoxFit.cover,
                          //                     alignment: Alignment.center,
                          //                     image: imageProvider)),
                          //           );
                          //         },
                          //         placeholder: (context, url) => Container(
                          //               width: 70,
                          //               height: 100,
                          //               decoration: BoxDecoration(

                          //                   // borderRadius: BorderRadius.circular(100),
                          //                   image: DecorationImage(
                          //                       fit: BoxFit.cover,
                          //                       image: AssetImage(
                          //                           "assets/logos/logo.png"))),
                          //             ),
                          //         errorWidget: (context, url, error) => Container(
                          //               width: 70,
                          //               height: 100,
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(100),
                          //                   image: DecorationImage(
                          //                       fit: BoxFit.cover,
                          //                       image: AssetImage(
                          //                           "assets/logos/logo.png"))),
                          //             )),
                          //   ),
                          // );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
              return Column(
                children: [],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyReviewsCard extends StatelessWidget {
  const MyReviewsCard({
    super.key,
    required this.accommodation,
    required this.reviewModel,
  });

  final Accommodation accommodation;
  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CachedNetworkImage(
                      width: 100,
                      height: 100,
                      key: UniqueKey(),
                      imageUrl: "${getIpNoBackSlash()}${accommodation.image}",
                      maxHeightDiskCache: 200,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  image: imageProvider)),
                        );
                      },
                      placeholder: (context, url) => Container(
                            width: 70,
                            height: 100,
                            decoration: BoxDecoration(

                                // borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/logos/logo.png"))),
                          ),
                      errorWidget: (context, url, error) => Container(
                            width: 70,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/logos/logo.png"))),
                          )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accommodation.name!,
                        style: TextStyle(
                            fontSize: 14, color: UsedColors.textColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Stayed at ${accommodation.city} , ${accommodation.address}",
                        style: TextStyle(
                            fontSize: 12, color: UsedColors.fadeOutColor),
                      ),
                      Text(
                          formatDateTimeinMMMMDDYYY(
                            reviewModel.added_time,
                          ),
                          style: TextStyle(
                              fontSize: 12, color: UsedColors.fadeOutColor)),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMyReviewsRating(reviewModel: reviewModel),
                        EditButton(reviewModel: reviewModel),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (reviewModel.image != null)
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ReviewImage(reviewModel: reviewModel),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Text(
                      reviewModel.description!,
                      style: TextStyle(
                          fontSize: 12, color: UsedColors.fadeTextColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class EditButton extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  double? ratings;

  EditButton({
    super.key,
    required this.reviewModel,
  }) {
    ratings = double.tryParse(reviewModel.title ?? '0') ??
        0.0; // Safely parse the rating
  }

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    Future<dynamic> UpdateReviewDetails(
        BuildContext context, ReviewModel reviewModel) {
      _controller.text = reviewModel.description ?? '';

      return showModalBottomSheet(
          context: context,
          builder: (context) {
            final _formKey = GlobalKey<FormState>();
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Adjust the column size to fit content
                  children: [
                    RatingBar.builder(
                      initialRating: ratings!,
                      minRating: 1,
                      updateOnDrag: true,
                      ignoreGestures: false,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Colors.grey.withOpacity(
                          0.1), // Use a more generic color reference
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Correctly update the ratings variable
                        ratings = rating;
                        print("The ratings are changed to $ratings");
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      // Use TextFormField for consistency with Flutter's form validation
                      decoration: InputDecoration(hintText: "Description"),
                      controller: _controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Add space before the button
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(UsedColors.mainColor)),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<UpdateReviewCubit>()
                            ..updateReview(
                                token: context
                                    .read<UserDetailsStorageBloc>()
                                    .state
                                    .user!
                                    .token!,
                                id: reviewModel.id!,
                                title: ratings.toString(),
                                description: _controller.text);
                          popMultipleScreens(context, 1);
                        }
                      },
                      child: Text(
                        "Update Review Details",
                        style: TextStyle(color: UsedColors.backgroundColor),
                      ),
                      // Use Flutter's ElevatedButton for a more consistent and themed approach
                    )
                  ],
                ),
              ),
            );
          });
    }

    return CustomMaterialButton(
        height: 40,
        onPressed: () {
          showModalBottomSheet(
            enableDrag: true,
            context: context,
            builder: (context) {
              return Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomMaterialButton(
                          text: "Update Details",
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 50,
                          onPressed: () {
                            UpdateReviewDetails(context, reviewModel);
                          },
                        ),
                        UpdateReviewImage(reviewModel: reviewModel),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        text: "Edit",
        width: 70);
    // Adjust styling as needed to match your UI desig
  }
}

class CustomMyReviewsRating extends StatelessWidget {
  const CustomMyReviewsRating({
    super.key,
    required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: double.parse(reviewModel.title!),
      minRating: 1,
      updateOnDrag: false,
      ignoreGestures: true,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      unratedColor: UsedColors.fadeOutColor.withOpacity(0.1),
      itemSize: 20,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class ReviewImage extends StatelessWidget {
  const ReviewImage({
    super.key,
    required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: 50,
        height: 50,
        key: UniqueKey(),
        imageUrl: "${getIpNoBackSlash()}${reviewModel.image}",
        maxHeightDiskCache: 200,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    image: imageProvider)),
          );
        },
        placeholder: (context, url) => Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(

                  // borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ),
        errorWidget: (context, url, error) => Container(
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logos/logo.png"))),
            ));
  }
}

class UpdateReviewImage extends StatelessWidget {
  const UpdateReviewImage({
    super.key,
    required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialButton(
        height: 50,
        onPressed: () async {
          var imageHelper = context.read<ImageHelperCubit>().state.imageHelper!;
          final xFiles = await imageHelper.pickImage();
          if (xFiles.isNotEmpty) {
            final croppedFile = await imageHelper.crop(
                file: xFiles.first, cropStyle: CropStyle.rectangle);
            print("This is cropped file ${croppedFile}");
            if (croppedFile != null) {
              context.read<UpdateReviewCubit>()
                ..updateReview(
                    token: context
                        .read<UserDetailsStorageBloc>()
                        .state
                        .user!
                        .token!,
                    image: File(croppedFile.path),
                    id: reviewModel.id!);
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
        text: "Update Image",
        width: MediaQuery.of(context).size.width / 2.5);
  }
}
