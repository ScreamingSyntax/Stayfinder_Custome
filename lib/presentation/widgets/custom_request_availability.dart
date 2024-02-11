import 'package:stayfinder_customer/logic/logic_exports.dart';

import 'widgets_export.dart';

class BottomRequestAvailability extends StatelessWidget {
  final void Function()? onPressed;
  final int itemId;
  const BottomRequestAvailability(
      {super.key, required this.onPressed, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var loginState = context.read<UserDetailsStorageBloc>().state;
        if (loginState.isLoggedIn == false) {
          showPopup(
              context: context,
              description: "You need to login to perform this action",
              title: "Login Required",
              type: ToastificationType.warning);
        }
        context.read<AddToWishlistCubit>()
          ..addToWishList(token: loginState.user!.token!, itemId: itemId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width / 1.5,
              height: 48,
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              textColor: UsedColors.backgroundColor,
              color: UsedColors.mainColor,
              child: Text("Request Availability"),
            )
          ],
        ),
      ),
    );
  }
}
