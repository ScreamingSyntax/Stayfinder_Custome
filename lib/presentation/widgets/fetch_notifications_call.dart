import '../../logic/logic_exports.dart';
import 'widgets_export.dart';

void fetchNotificationsCall(BuildContext context) {
  context.read<FetchNotificationsCubit>()
    ..fetchNotifications(
        token: context.read<UserDetailsStorageBloc>().state.user!.token!);
}
