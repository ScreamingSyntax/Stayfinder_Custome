import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/config/app_router.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';
import 'package:stayfinder_customer/utils/image_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});
  // return MaterialApp()
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingBloc(),
        ),
        BlocProvider(
          create: (context) => NavBarIndexCubit(),
        ),
        BlocProvider(create: (context) => FetchAccommodationsBloc()),
        BlocProvider(create: (context) => UserDetailsStorageBloc()),
        BlocProvider(create: (context) => OnBoardingBloc()),
        BlocProvider(create: (context) => CustomerRegistrationCubit()),
        BlocProvider(create: (context) => BooleanChangeCubit()),
        BlocProvider(create: (context) => StoreBookDetailsCubit()),
        BlocProvider(
            create: (context) => ImageHelperCubit()
              ..imageHelperAccess(imageHelper: ImageHelper())),
        BlocProvider(create: (context) => ImageStorageCubit()),
        BlocProvider(create: (context) => StoreTempUserDetailsCubit()),
        BlocProvider(create: (context) => CustomerLoginCubit()),
        BlocProvider(create: (context) => ParticularAccommodationCubit()),
        BlocProvider(create: (context) => FetchSearchResultsCubit()),
        BlocProvider(create: (context) => StoreSearchCubit()),
        BlocProvider(create: (context) => FetchBookingRequestCubit()),
        BlocProvider(create: (context) => DirectBookingCubit()),
        BlocProvider(create: (context) => RequestBookingCubit()),
        BlocProvider(create: (context) => FetchBookingHistoryCubit()),
        BlocProvider(create: (context) => FetchBookingRequestHistoryCubit()),
        BlocProvider(create: (context) => AddToWishlistCubit()),
        BlocProvider(create: (context) => FetchWishlistCubit()),
        BlocProvider(create: (context) => DeleteReviewCubit()),
        BlocProvider(create: (context) => FetchAddedReviewsCubit()),
        BlocProvider(create: (context) => FetchAccommodationReviewsCubit()),
        BlocProvider(create: (context) => UpdateReviewCubit()),
        BlocProvider(create: (context) => AddReviewCubit()),
      ],
      child: KhaltiScope(
          publicKey: "test_public_key_0238ecd9cab54ca29a0c6d523ddb0d3c",
          enabledDebugging: true,
          builder: (context, navKey) {
            return MaterialApp(
              navigatorKey: navKey,
              theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
              debugShowCheckedModeBanner: false,
              title: 'StayFinder-Customer',
              onGenerateRoute: appRouter.routeSettings,
              localizationsDelegates: const [KhaltiLocalizations.delegate],
            );
          }),
    );
  }
}
