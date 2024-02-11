import 'dart:math';

import '../../logic/logic_exports.dart';
import 'widgets_export.dart';

BottomRequestAvailability? BottomNavBarCheck(
    BuildContext context, void Function()? onPressed) {
  // final
  // if()

  var state = context.watch<ParticularAccommodationCubit>().state;
  if (state is ParticularAccommodationLoaded) {
    return BottomRequestAvailability(
      onPressed: onPressed,
      itemId: state.accommodation!.id!,
    );
  }
  return null;
}
