import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class AccountLoggedOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_page.png"))),
            ),
            CustomMaterialButton(
              height: 39,
              width: 120,
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              text: "Login/ Signup",
            ),
          ],
        ),
      ),
    );
  }
}
