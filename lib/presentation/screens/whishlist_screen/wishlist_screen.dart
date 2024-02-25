import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../data/data_exports.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddToWishlistCubit, AddToWishlistState>(
        listener: (context, state) {
          if (state is AddToWishlistError) {
            showPopup(
                context: context,
                description: state.message,
                title: "Oops..",
                type: ToastificationType.error);
          }
          if (state is AddToWishlistSuccess) {
            context.read<FetchWishlistCubit>()
              ..fetchWishlist(
                  token: context
                      .read<UserDetailsStorageBloc>()
                      .state
                      .user!
                      .token!);
            showPopup(
                context: context,
                description: state.message,
                title: "Success",
                type: ToastificationType.success);
          }
        },
        child: BlocBuilder<FetchWishlistCubit, FetchWishlistState>(
          builder: (context, state) {
            if (state is FetchWishlistLoading) {
              return Center(
                child: CustomLoadingWidget(
                  text: "Fetching Accommodation",
                ),
              );
            }
            if (state is FetchWishlistInitial) {
              fetchWishlists(context);
              // loadAccommodation(context, data['id']);
            }
            if (state is FetchWishlistError) {
              return CustomErrorScreen(
                  message: state.message,
                  onPressed: () => fetchWishlists(context));
            }
            if (state is FetchWishlistSuccess) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomRedHatFont(
                                    text: "Your wishlist",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (state.wishListModels.length == 0)
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ListView.builder(
                          itemCount: state.wishListModels.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Accommodation accommodation =
                                state.wishListModels[index].accommodation!;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Slidable(
                                  closeOnScroll: true,
                                  endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      extentRatio: 1,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            context.read<AddToWishlistCubit>()
                                              ..removeFromWishList(
                                                  token: context
                                                      .read<
                                                          UserDetailsStorageBloc>()
                                                      .state
                                                      .user!
                                                      .token!,
                                                  itemId: accommodation.id!);
                                          },
                                          foregroundColor: UsedColors.mainColor,
                                          icon: Icons.cancel,
                                          label: 'Remove',
                                        )
                                      ]),
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<ParticularAccommodationCubit>()
                                        ..fetchAccommodation(accommodation.id!);
                                      NavigateToAccommodation(
                                          accommodation, context);
                                    },
                                    child: CustomAccommodationCard(
                                      image: accommodation.image.toString(),
                                      city: accommodation.city.toString(),
                                      address: accommodation.address.toString(),
                                      name: accommodation.name.toString(),
                                      ratings: "3",
                                      type: accommodation.type.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: [],
            );
          },
        ),
      ),
    );
  }

  void fetchWishlists(BuildContext context) {
    context.read<FetchWishlistCubit>()
      ..fetchWishlist(
          token: context.read<UserDetailsStorageBloc>().state.user!.token!);
  }
}
