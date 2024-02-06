import 'package:iconly/iconly.dart';
import 'package:stayfinder_customer/presentation/theme/colors.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class ChatScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TopChatArea(),
            SizedBox(
              height: 61,
            ),
            MessagesBody()
          ],
        ),
      ),
    );
  }
}

class MessagesBody extends StatelessWidget {
  const MessagesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              MessageCustom(
                seen: true,
                date: "19 November",
                name: "Aaryan Jha",
                message:
                    "Lorem psdahd adad hadadhad a dhadada da da dad ad a da d",
              ),
              SizedBox(
                height: 12,
              ),
            ],
          );
        });
  }
}

class MessageCustom extends StatelessWidget {
  final String name;
  final String message;
  final String date;
  final bool seen;
  const MessageCustom({
    super.key,
    required this.name,
    required this.message,
    required this.date,
    required this.seen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/user.png")),
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 10,
                          color: UsedColors.fadeOutColor,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 11,
                        color: seen ? Colors.black : UsedColors.fadeOutColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class TopChatArea extends StatelessWidget {
  const TopChatArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomRedHatFont(
              text: "Messages", fontWeight: FontWeight.w600, fontSize: 24),
        ),
        SizedBox(
          height: 12,
        ),
        CustomTextFormField(
          filled: true,
          onTapOutside: (p0) => FocusScope.of(context).unfocus(),
          borderColor: Color(0xff555555).withOpacity(0.5),
          filledColor: Color(0xffE5e5e5),
          // filledColor: U,
          hintText: "Search Messages",
          suffixIcon: IconlyLight.search,
        ),
      ],
    );
  }
}
