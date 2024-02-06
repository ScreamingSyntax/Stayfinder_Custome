import 'package:stayfinder_customer/logic/cubits/image_helper/image_helper_cubit.dart';
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
        BlocProvider(
            create: (context) => ImageHelperCubit()
              ..imageHelperAccess(imageHelper: ImageHelper())),
        BlocProvider(create: (context) => ImageStorageCubit()),
        BlocProvider(create: (context) => StoreTempUserDetailsCubit()),
        BlocProvider(create: (context) => CustomerLoginCubit()),
        BlocProvider(create: (context) => ParticularAccommodationCubit()),
        BlocProvider(create: (context) => FetchSearchResultsCubit()),
        BlocProvider(create: (context) => StoreSearchCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        title: 'StayFinder-Customer',
        onGenerateRoute: appRouter.routeSettings,
      ),
    );
  }
}
