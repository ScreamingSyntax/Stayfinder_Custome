import 'package:stayfinder_customer/logic/cubits/drop_down/drop_down_cubit.dart';
import 'package:stayfinder_customer/logic/cubits/drop_down/drop_down_state.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../data/data_exports.dart';
import '../../../logic/logic_exports.dart';
import '../screens_export.dart';

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        return false;
      },
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false),
                            child: Icon(IconlyLight.arrow_left)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SearchScreen(onBackPressed: () {
                                            Navigator.pop(context);
                                          })));
                            },
                            child: CustomTextFormField(
                              isEnabled: false,
                              hintText: "Search Accommodations",
                              suffixIcon: IconlyLight.search,
                              onTapOutside: (p0) =>
                                  FocusScope.of(context).unfocus(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<FetchSearchResultsCubit,
                        FetchSearchResultsState>(
                      builder: (context, state) {
                        if (state is FetchSearchResultsLoadingState) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Center(
                                child: CustomLoadingWidget(
                                  text: "Getting Accommodations",
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is FetchSearchResultsErrorState) {
                          return CustomErrorScreen(
                            message: state.error,
                          );
                        }
                        if (state is FetchSearchResultsLoadedState) {
                          if (state.accommodations.length == 0) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/no_results_found.png"))),
                                ),
                                Text(
                                  "No search results found",
                                  style: TextStyle(
                                      color: UsedColors.mainColor,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            );
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Found ${state.accommodations.length} accommodations for : ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: UsedColors.textColor),
                                      ),
                                      // SizedBox()
                                      Text(
                                        context
                                            .read<StoreSearchCubit>()
                                            .state
                                            .searchValue,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: UsedColors.mainColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        IconlyLight.filter,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            // isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return BlocProvider(
                                                create: (context) =>
                                                    DropDownValueCubit()
                                                      ..instantiateDropDownValue(
                                                          items: [
                                                            "rent_room",
                                                            "hostel",
                                                            "hotel"
                                                          ]),
                                                child:
                                                    Builder(builder: (context) {
                                                  context.read<
                                                      DropDownValueCubit>()
                                                    ..changeDropDownValue(
                                                        "rent_room");
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Search Filter",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: UsedColors
                                                                  .textColor),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Sort by Accommodation Type: ",
                                                              style: TextStyle(
                                                                  color: UsedColors
                                                                      .textColor,
                                                                  fontSize: 12),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            BlocBuilder<
                                                                DropDownValueCubit,
                                                                DropDownValueState>(
                                                              builder: (context,
                                                                  state) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          1.0),
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                            color: UsedColors.mainColor.withOpacity(
                                                                                0.4),
                                                                            width:
                                                                                1.3),
                                                                        color: UsedColors
                                                                            .backgroundColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child:
                                                                        DropdownButtonHideUnderline(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                13.0),
                                                                        child:
                                                                            CustomDropDownButton(
                                                                          state:
                                                                              state,
                                                                          items: state
                                                                              .items!
                                                                              .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                                                                                    child: Text(value!),
                                                                                    value: value,
                                                                                  ))
                                                                              .toList(),
                                                                          onChanged:
                                                                              (p0) {
                                                                            context.read<DropDownValueCubit>().changeDropDownValue(p0!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Divider(),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "Budget Preference",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: UsedColors
                                                                  .textColor),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          "Budget Preference up-to : 50,000",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: UsedColors
                                                                  .textColor),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        BlocBuilder<
                                                            StoreSearchCubit,
                                                            StoreSearchStorage>(
                                                          builder:
                                                              (context, state) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      color: UsedColors
                                                                          .fadeOutColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      RangeSlider(
                                                                    activeColor:
                                                                        UsedColors
                                                                            .mainColor,
                                                                    overlayColor:
                                                                        MaterialStatePropertyAll(
                                                                            UsedColors.fadeOutColor),
                                                                    values: RangeValues(
                                                                        state
                                                                            .startingRate!,
                                                                        state
                                                                            .endingRate!),
                                                                    min: 0,
                                                                    divisions:
                                                                        10,
                                                                    labels: RangeLabels(
                                                                        state
                                                                            .startingRate
                                                                            .toString(),
                                                                        state
                                                                            .endingRate
                                                                            .toString()),
                                                                    max: 50000,
                                                                    onChanged:
                                                                        (value) {
                                                                      context.read<
                                                                          StoreSearchCubit>()
                                                                        ..searchAfter(
                                                                            type:
                                                                                context.read<DropDownValueCubit>().state.value,
                                                                            endingRate: value.end,
                                                                            startingRate: value.start);
                                                                    },
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "50000",
                                                                  style: TextStyle(
                                                                      color: UsedColors
                                                                          .fadeOutColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 25,
                                                        ),
                                                        CustomMaterialButton(
                                                            height: 40,
                                                            onPressed: () {
                                                              var state = context
                                                                  .read<
                                                                      StoreSearchCubit>()
                                                                  .state;
                                                              String
                                                                  startingRate =
                                                                  state
                                                                      .startingRate
                                                                      .toString();
                                                              String
                                                                  endingRate =
                                                                  state
                                                                      .endingRate
                                                                      .toString();
                                                              context.read<FetchSearchResultsCubit>().fetchSearchResults(
                                                                  state
                                                                      .searchValue,
                                                                  startingRate:
                                                                      startingRate,
                                                                  endingRate:
                                                                      endingRate,
                                                                  type: context
                                                                      .read<
                                                                          DropDownValueCubit>()
                                                                      .state
                                                                      .value);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text: "Confirm",
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width)
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Filter",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: UsedColors.textColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              ListView.builder(
                                itemCount: state.accommodations.length,
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
                                              state.accommodations[index];
                                          context.read<
                                              ParticularAccommodationCubit>()
                                            ..fetchAccommodation(
                                                accommodation.id!);
                                          NavigateToAccommodation(
                                              accommodation, context);
                                        },
                                        child: CustomAccommodationCard(
                                          image: state
                                              .accommodations[index].image
                                              .toString(),
                                          city: state.accommodations[index].city
                                              .toString(),
                                          address: state
                                              .accommodations[index].address
                                              .toString(),
                                          name: state.accommodations[index].name
                                              .toString(),
                                          ratings: "3",
                                          type: state.accommodations[index].type
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          );
                        }
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
