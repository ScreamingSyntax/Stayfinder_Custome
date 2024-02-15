import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UsedColors.backgroundColor,
      bottomNavigationBar: CrystalNavigationBar(
        paddingR: EdgeInsets.all(1),
        marginR: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        currentIndex: context.watch<NavBarIndexCubit>().state.index,
        borderRadius: 10,
        outlineBorderColor: UsedColors.borderColorFade,
        backgroundColor: UsedColors.cardColor,
        onTap: (index) {
          print("The idnex is ${index}");
          return context.read<NavBarIndexCubit>()..changeIndex(index);
        },
        items: getItems(),
      ),
      body: BlocBuilder<NavBarIndexCubit, NavBarIndexState>(
        builder: (context, state) {
          return bodyScreens(context)[state.index];
        },
      ),
    );
  }
}

List<Widget> bodyScreens(BuildContext context) {
  if (context.watch<UserDetailsStorageBloc>().state.isLoggedIn == false) {
    return [
      HomeScreen(),
      MapScreen(),
      ChatScreen(),
      BookStatusScreen(),
      AccountLoggedOutScreen()
    ];
  }
  return [
    HomeScreen(),
    MapScreen(),
    ChatScreen(),
    BookStatusScreen(),
    AccountScreen()
  ];
}

List<CrystalNavigationBarItem> getItems() {
  return [
    CrystalNavigationBarItem(
      unselectedColor: UsedColors.fadeOutColor,
      icon: IconlyBold.home,
      unselectedIcon: IconlyLight.home,
      selectedColor: UsedColors.mainColor,
    ),

    /// Favourite
    CrystalNavigationBarItem(
      unselectedColor: UsedColors.fadeOutColor,
      icon: IconlyBold.location,
      unselectedIcon: IconlyLight.location,
      selectedColor: UsedColors.mainColor,
    ),

    /// Add
    CrystalNavigationBarItem(
      unselectedColor: UsedColors.fadeOutColor,
      icon: IconlyBold.chat,
      unselectedIcon: IconlyLight.chat,
      selectedColor: UsedColors.mainColor,
    ),

    /// Search
    CrystalNavigationBarItem(
        unselectedColor: UsedColors.fadeOutColor,
        icon: IconlyBold.paper,
        unselectedIcon: IconlyLight.paper,
        selectedColor: UsedColors.mainColor),

    /// Profile
    CrystalNavigationBarItem(
      unselectedColor: UsedColors.fadeOutColor,
      icon: IconlyBold.profile,
      unselectedIcon: IconlyLight.profile,
      selectedColor: UsedColors.mainColor,
    ),
  ];
}
