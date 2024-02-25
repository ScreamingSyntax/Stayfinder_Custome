import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class NotificationScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
      body: BlocBuilder<FetchNotificationsCubit, FetchNotificationsState>(
        builder: (context, state) {
          if (state is FetchNotificationLoading) {
            return Center(
                child: CustomLoadingWidget(text: "Fetching Notifications"));
          }
          if (state is FetchNotificationError) {
            return CustomErrorScreen(
              message: state.message,
              onPressed: () async {
                fetchNotificationsCall(context);
              },
            );
          }
          if (state is FetchNotificationSuccess) {
            return RefreshIndicator(
              onRefresh: () async => fetchNotificationsCall(context),
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  NotificationModel _notification = state.notifications[index];

                  // Determine color and icon based on notification type
                  Color bgColor;
                  IconData icon;
                  switch (_notification.notification_type) {
                    case 'warning':
                      bgColor = Colors.orange;
                      icon = Icons.warning_amber_rounded;
                      break;
                    case 'failure':
                      bgColor = Colors.red;
                      icon = Icons.cancel;
                      break;
                    case 'success':
                      bgColor = Colors.green;
                      icon = Icons.check_circle_outline;
                      break;
                    case 'info':
                    default:
                      bgColor = Colors.blue;
                      icon = Icons.info_outline;
                      break;
                  }
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: 8), // Add some spacing between list items
                    decoration: BoxDecoration(
                      color: bgColor
                          .withOpacity(0.1), // Slightly transparent background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: ListTile(
                      leading: Icon(icon, color: bgColor),
                      title: Text(
                        _notification.description!,
                        style: TextStyle(fontSize: 12), // Smaller font size
                      ),
                      trailing: Text(
                        formatDateTimeinMMMMDDYYY(_notification.added_date!),
                        style: TextStyle(
                            fontSize: 8), // Even smaller font size for the date
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Column(
            children: [Text("This is notification screen")],
          );
        },
      ),
    );
  }
}
