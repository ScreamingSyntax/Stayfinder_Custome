import 'package:line_icons/line_icons.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../category_view/category_view_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> callApiViewAccommodations(BuildContext context) async {
    context.read<FetchAccommodationsBloc>()..add(HitFetchAccommodationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: BlocBuilder<FetchAccommodationsBloc, FetchAccommodationsState>(
            builder: (context, state) {
          if (state is FetchAccommodationsInitial) {
            context
                .read<FetchAccommodationsBloc>()
                .add(HitFetchAccommodationsEvent());
          }
          if (state is FetchAccommodationLoading) {
            return Center(
              child: CustomLoadingWidget(
                text: "Getting Accommodations",
              ),
            );
          }
          if (state is FetchAccommodationError) {
            return CustomErrorScreen(
              message: state.message,
              onPressed: () => context.read<FetchAccommodationsBloc>()
                ..add(HitFetchAccommodationsEvent()),
            );
          }
          if (state is FetchAccommodationSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                callApiViewAccommodations(context);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopHomeBody(),
                    SizedBox(
                      height: 45,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<StoreSearchCubit>()..reset();
                        Navigator.pushNamed(context, "/search");
                      },
                      child: CustomTextFormField(
                        isEnabled: false,
                        hintText: "Search Accommodations",
                        suffixIcon: IconlyLight.search,
                        onTapOutside: (p0) => FocusScope.of(context).unfocus(),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomRedHatFont(
                        text:
                            "Popular Products ${context.read<UserDetailsStorageBloc>().state.isLoggedIn}",
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    ListView.builder(
                      itemCount: state.accommodation.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Accommodation accommodation =
                                    state.accommodation[index];
                                context.read<ParticularAccommodationCubit>()
                                  ..fetchAccommodation(accommodation.id!);
                                context.read<FetchAccommodationReviewsCubit>()
                                  ..fetchAccommodationReviews(
                                      id: accommodation.id!);
                                NavigateToAccommodation(accommodation, context);
                              },
                              child: CustomAccommodationCard(
                                image:
                                    state.accommodation[index].image.toString(),
                                city:
                                    state.accommodation[index].city.toString(),
                                address: state.accommodation[index].address
                                    .toString(),
                                name:
                                    state.accommodation[index].name.toString(),
                                ratings: "3",
                                type:
                                    state.accommodation[index].type.toString(),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
          return Text("");
        }),
      ),
    );
  }
}

class CustomErrorScreen extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const CustomErrorScreen({
    super.key,
    required this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/error.png"),
        SizedBox(
          height: 10,
        ),
        Text(
          message,
          style: TextStyle(
              color: UsedColors.mainColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        if (onPressed != null)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
            child: CustomMaterialButton(
                height: 45,
                onPressed: onPressed,
                text: "Retry",
                width: MediaQuery.of(context).size.width),
          )
      ],
    );
  }
}

class TopHomeBody extends StatelessWidget {
  const TopHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [StayFinderLogo(), Icon(IconlyLight.notification)],
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: CustomRedHatFont(
            text: "Where do you want to stay ?",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Row(
          children: [
            Icon(
              IconlyLight.location,
              size: 14,
              color: UsedColors.fadeOutColor,
            ),
            SizedBox(
              width: 6,
            ),
            CustomRedHatFont(
              text: "Dharan, Nepal",
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: UsedColors.fadeOutColor,
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomRedHatFont(
              text: "Main Categories",
              fontWeight: FontWeight.w500,
              fontSize: 14),
        ),
        SizedBox(
          height: 22,
        ),
        BlocBuilder<FetchAccommodationsBloc, FetchAccommodationsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      List<Accommodation> accommodations = [];
                      List<Accommodation> sortedAccommodations =
                          FetchSortedAccommodations(
                              context, accommodations, "rent_room");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoryViewScreen(
                                    accommodation: sortedAccommodations,
                                  )));
                    },
                    child: CustomCategoriesBubble(
                      iconMain: Icons.door_sliding_outlined,
                      text: "Rental",
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  InkWell(
                    onTap: () {
                      List<Accommodation> accommodations = [];
                      List<Accommodation> sortedAccommodations =
                          FetchSortedAccommodations(
                              context, accommodations, "hostel");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoryViewScreen(
                                    accommodation: sortedAccommodations,
                                  )));
                    },
                    child: CustomCategoriesBubble(
                      iconMain: Icons.house_siding_outlined,
                      text: "Hostel",
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  InkWell(
                    onTap: () {
                      List<Accommodation> accommodations = [];
                      List<Accommodation> sortedAccommodations =
                          FetchSortedAccommodations(
                              context, accommodations, "hotel",
                              hasTier: false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoryViewScreen(
                                    accommodation: sortedAccommodations,
                                  )));
                    },
                    child: CustomCategoriesBubble(
                      iconMain: FontAwesomeIcons.hotel,
                      text: "Hotel",
                    ),
                  ),
                  SizedBox(
                    width: 33,
                  ),
                  InkWell(
                    onTap: () {
                      List<Accommodation> accommodations = [];
                      List<Accommodation> sortedAccommodations =
                          FetchSortedAccommodations(
                              context, accommodations, "hotel",
                              hasTier: true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoryViewScreen(
                                    accommodation: sortedAccommodations,
                                  )));
                    },
                    child: CustomCategoriesBubble(
                      iconMain: LineIcons.hotel,
                      text: "Tier Hotel",
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
