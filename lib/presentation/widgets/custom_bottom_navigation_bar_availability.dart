import '../../logic/logic_exports.dart';
import 'widgets_export.dart';

BottomRequestAvailability? BottomNavBarCheck(
    BuildContext context, void Function()? onPressed) {
  // final
  // if()
  if (context.watch<ParticularAccommodationCubit>().state
      is ParticularAccommodationLoaded) {
    return BottomRequestAvailability(
      onPressed: onPressed,
    );
  }
  return null;
}
