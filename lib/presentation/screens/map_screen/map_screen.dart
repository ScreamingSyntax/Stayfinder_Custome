import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import '../../../constants/constant_exports.dart';
import '../../../logic/logic_exports.dart';
import '../screens_export.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  // boo.

  IconData iconReturn(Accommodation accommodation) {
    switch (accommodation.type) {
      case "rent_room":
        return FontAwesomeIcons.house;
      case "hostel":
        return IconlyBold.home;
      case "hotel":
        return FontAwesomeIcons.building;
      default:
        return FontAwesomeIcons.buildingShield;
    }
  }

  late final _animatedMapController = AnimatedMapController(vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchAccommodationsBloc, FetchAccommodationsState>(
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
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FlutterMap(
                      mapController: _animatedMapController.mapController,
                      options: MapOptions(maxZoom: 20),
                      children: [
                        TileLayer(
                          tileProvider: FMTC
                              .instance('mapStore')
                              .getTileProvider(
                                settings: FMTCTileProviderSettings(
                                  behavior: CacheBehavior.cacheFirst,
                                  errorHandler: (exception) async {
                                    if (exception.type ==
                                        FMTCBrowsingErrorType
                                            .noConnectionDuringFetch) {
                                      await Future.delayed(Duration(seconds: 5),
                                          () {
                                        print("Retrying to fetch tiles...");
                                      });
                                    }
                                  },
                                ),
                              ),
                          errorImage: AssetImage("assets/images/error.png"),
                          evictErrorTileStrategy:
                              EvictErrorTileStrategy.notVisible,
                          urlTemplate:
                              "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png",
                          // https://{s}.basemaps.cartocdn.com/{style}/{z}/{x}/{y}{scale}.png,
                          userAgentPackageName: 'com.stayfinder_customer.app',
                        ),
                        // BlocBuilder(builder: §)
                        BlocBuilder<CategorizeMapViewCubit,
                            CategorizeMapViewState>(
                          builder: (context, categorizeState) {
                            return BlocBuilder<FetchAccommodationsBloc,
                                    FetchAccommodationsState>(
                                builder: (context, state) {
                              if (state is FetchAccommodationSuccess) {
                                List<Accommodation> accommodations =
                                    state.accommodation;
                                // List<Accommodation> rentalRooms =
                                //     List<Accommodation>.from(accommodations)
                                //         .where(
                                //           (element) =>
                                //               element.type == 'rent_room',
                                //         )
                                //         .toList();
                                // List<Accommodation> hostels =
                                //     List<Accommodation>.from(accommodations)
                                //         .where(
                                //           (element) => element.type == 'hostel',
                                //         )
                                //         .toList();
                                // List<Accommodation> hotels =

                                List<Accommodation> toView = [];
                                if (categorizeState.type == "all") {
                                  toView = accommodations;
                                }
                                if (categorizeState.type == "rent_room") {
                                  toView =
                                      List<Accommodation>.from(accommodations)
                                          .where(
                                            (element) =>
                                                element.type == 'rent_room',
                                          )
                                          .toList();
                                }
                                if (categorizeState.type == "hotel") {
                                  toView =
                                      List<Accommodation>.from(accommodations)
                                          .where(
                                            (element) =>
                                                element.type == 'hotel',
                                          )
                                          .toList();
                                }
                                if (categorizeState.type == "hostel") {
                                  toView =
                                      List<Accommodation>.from(accommodations)
                                          .where(
                                            (element) =>
                                                element.type == 'hostel',
                                          )
                                          .toList();
                                }

                                return MarkerLayer(
                                  markers: [
                                    for (Accommodation accommodation in toView)
                                      Marker(
                                          point: LatLng(
                                              double.tryParse(
                                                  accommodation.latitude!)!,
                                              double.tryParse(
                                                  accommodation.longitude!)!),
                                          child: InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) {
                                                    return InkWell(
                                                      onTap: () {
                                                        context.read<
                                                            ParticularAccommodationCubit>()
                                                          ..fetchAccommodation(
                                                              accommodation
                                                                  .id!);
                                                        context.read<
                                                            FetchAccommodationReviewsCubit>()
                                                          ..fetchAccommodationReviews(
                                                              id: accommodation
                                                                  .id!);
                                                        NavigateToAccommodation(
                                                            accommodation,
                                                            context);
                                                      },
                                                      child:
                                                          CustomAccommodationCard(
                                                              image:
                                                                  accommodation
                                                                      .image!,
                                                              name:
                                                                  accommodation
                                                                      .name!,
                                                              ratings: "2",
                                                              city:
                                                                  accommodation
                                                                      .city!,
                                                              address:
                                                                  accommodation
                                                                      .address!,
                                                              type:
                                                                  accommodation
                                                                      .type!),
                                                    );
                                                  });
                                            },
                                            child: Icon(
                                              accommodation.has_tier == true
                                                  ? FontAwesomeIcons
                                                      .buildingShield
                                                  : iconReturn(accommodation),
                                              color: Colors.red,
                                            ),
                                          )),
                                    // if(accommodation.type == "rent_room")
                                  ],
                                );
                                // SizedBox();
                              }
                              return SizedBox();
                            });
                          },
                        ),
                        BlocBuilder<StoreUserLocationCubit,
                            StoreUserLocationState>(
                          builder: (context, state) {
                            if (state.latitude != null) {
                              return MarkerLayer(
                                markers: [
                                  Marker(
                                      point: LatLng(
                                          state.latitude!, state.longitude!),
                                      child: Icon(
                                        FontAwesomeIcons.person,
                                        color: Colors.red,
                                      ))
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ]),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<CategorizeMapViewCubit>()
                                .changeCategory(newCategory: "all");
                            showPopup(
                                context: context,
                                description: "Viewing all accommodations",
                                title: "All Accommodations",
                                type: ToastificationType.info);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.restore_page,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<CategorizeMapViewCubit>()
                                .changeCategory(newCategory: "rent_room");
                            showPopup(
                                context: context,
                                description: "Viewing only rental rooms",
                                title: "Rental Rooms",
                                type: ToastificationType.info);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            width: 50,
                            height: 50,
                            child: Icon(
                              IconlyBold.home,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<CategorizeMapViewCubit>()
                                .changeCategory(newCategory: "hostel");
                            showPopup(
                                context: context,
                                description: "Viewing only hostels",
                                title: "Hostels",
                                type: ToastificationType.info);
                          },
                          child: Container(
                            // decoration: ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            width: 50,
                            height: 50,
                            child: Icon(
                              FontAwesomeIcons.house,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<CategorizeMapViewCubit>()
                                .changeCategory(newCategory: "hotel");
                            showPopup(
                                context: context,
                                description: "Viewing only hotels",
                                title: "Hostels",
                                type: ToastificationType.info);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            width: 50,
                            height: 50,
                            child: Icon(
                              FontAwesomeIcons.building,
                              size: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //                     case "rent_room":
                        //   return FontAwesomeIcons.house;
                        // case "hostel":
                        //   return IconlyBold.home;
                        // case "hotel":
                        //   return FontAwesomeIcons.building;
                        // default:
                        //   return FontAwesomeIcons.buildingShield;
                        InkWell(
                          splashColor: Colors.green,
                          onTap: () async {
                            bool locationPermission =
                                await LocationHandler.handleLocationPermission(
                                    context);
                            if (locationPermission) {
                              showPopup(
                                  context: context,
                                  description:
                                      "We are getting your current location",
                                  title: "Please Wait",
                                  type: ToastificationType.info);
                              Position position =
                                  await Geolocator.getCurrentPosition(
                                      desiredAccuracy: LocationAccuracy.high);
                              _animatedMapController.animateTo(
                                  rotation: 0,
                                  dest: LatLng(
                                      position.latitude, position.longitude),
                                  zoom: 15);
                              context.read<StoreUserLocationCubit>()
                                ..addLocation(
                                    longitude: position.longitude,
                                    latitude: position.latitude);
                            }
                          },
                          child: Container(
                            // decoration: ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            width: 50,
                            height: 50,
                            child: Icon(Icons.gps_fixed),
                          ),
                        ),
                      ],
                    ))
              ],
            );
          }
          return Column(
            children: [],
          );
        },
      ),
    );
  }
}
