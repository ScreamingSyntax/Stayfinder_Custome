import 'package:cherry_toast/cherry_toast.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../constants/constant_exports.dart';
import '../screens_export.dart';

class ToReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddReviewCubit, AddReviewState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddReviewLoaded) {
          showPopup(
              context: context,
              description: state.message,
              title: "Success",
              type: ToastificationType.success);
          context.read<FetchToReviewCubit>()
            ..fetchToReview(
                token:
                    context.read<UserDetailsStorageBloc>().state.user!.token!);
        }
        if (state is AddReviewError) {
          showPopup(
              context: context,
              description: state.message,
              title: "Error",
              type: ToastificationType.error);
        }
      },
      child: Scaffold(
        backgroundColor: UsedColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: UsedColors.cardColor,
          centerTitle: true,
          title: Text(
            "To Review",
            style: TextStyle(fontSize: 14),
          ),
        ),
        body: BlocBuilder<FetchToReviewCubit, FetchToReviewState>(
          builder: (context, state) {
            if (state is FetchToReviewLoading) {
              return Center(
                child: CustomLoadingWidget(
                  text: "Fetching Bookings To Review",
                ),
              );
            }
            if (state is FetchToReviewError) {
              return CustomErrorScreen(
                  message: state.message,
                  onPressed: () => context.read<FetchToReviewCubit>()
                    ..fetchToReview(
                        token: context
                            .read<UserDetailsStorageBloc>()
                            .state
                            .user!
                            .token!));
            }
            if (state is FetchToReviewSuccess) {
              List<BookModel> bookings = state.bookModels;
              // if
              return Column(
                children: [
                  if (bookings.length == 0)
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
                            "No Requests Yet",
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
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookings.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        BookModel bookModel = state.bookModels[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            // color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                        width: 90,
                                        height: 90,
                                        key: UniqueKey(),
                                        imageUrl:
                                            "${getIpNoBackSlash()}${bookModel.room!.accommodation!.image}",
                                        maxHeightDiskCache: 200,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    alignment: Alignment.center,
                                                    image: imageProvider)),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/logos/logo.png"))),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/logos/logo.png"))),
                                            )),
                                    // Container(
                                    //   width: 80,
                                    //   height: 80,
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.green,
                                    //       borderRadius:
                                    //           BorderRadius.circular(10)),
                                    // ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 120,
                                                  child: Text(
                                                    bookModel.room!
                                                        .accommodation!.name!,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: UsedColors
                                                            .fadeTextColor),
                                                  ),
                                                ),
                                                Text(
                                                  "Rs ${bookModel.paid_amount}",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          UsedColors.mainColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              "${bookModel.check_in} | ${bookModel.check_out}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      UsedColors.fadeOutColor),
                                            ),
                                            CustomMaterialButton(
                                                height: 30,
                                                onPressed: () {
                                                  context
                                                      .read<ImageStorageCubit>()
                                                    ..clearImage();

                                                  AddReviews(
                                                      context, bookModel.id!);
                                                },
                                                text: "Review",
                                                width: 50),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }
            return Column();
          },
        ),
      ),
    );
  }

  Future<dynamic> AddReviews(BuildContext context, int id) {
    TextEditingController _controller = TextEditingController();

    double ratings = 2.5;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 450,
            alignment: Alignment.center,
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<ImageStorageCubit, ImageStorageState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () async {
                            var imageHelper = context
                                .read<ImageHelperCubit>()
                                .state
                                .imageHelper!;
                            final xFiles = await imageHelper.pickImage();
                            if (xFiles.isNotEmpty) {
                              final croppedFile = await imageHelper.crop(
                                  file: xFiles.first,
                                  cropStyle: CropStyle.rectangle);
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
                          child: Container(
                            width: 80,
                            height: 80,
                            child: Icon(Icons.camera),
                            decoration: BoxDecoration(
                                color: UsedColors.fadeOutColor.withOpacity(0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: state.image != null
                                    ? DecorationImage(
                                        image: FileImage(state.image!),
                                        fit: BoxFit.cover)
                                    : null),
                          ),
                        );
                      },
                    ),
                    RatingBar.builder(
                      initialRating: ratings,
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _controller,
                  maxLines: 5,
                  minLines: 5,
                  borderRadius: 1,
                  hintText: "Add Description",
                  contentCenter: false,
                  autoFocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty";
                    }
                    if (value.length > 150) {
                      return "Review must only contain 150 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomMaterialButton(
                    height: 40,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AddReviewCubit>()
                          ..addReview(
                            token: context
                                .read<UserDetailsStorageBloc>()
                                .state
                                .user!
                                .token!,
                            bookId: id,
                            title: ratings.toString(),
                            description: _controller.text,
                            image:
                                context.read<ImageStorageCubit>().state.image,
                          );
                        popMultipleScreens(context, 1);
                      }
                    },
                    text: "Add Review",
                    width: MediaQuery.of(context).size.width)
                // CustomTextFormField(hintText: hintTex)
              ],
            ),
          ),
        );
      },
    );
  }
}
