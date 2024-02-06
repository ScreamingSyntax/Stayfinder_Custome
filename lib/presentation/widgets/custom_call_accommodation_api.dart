import 'package:stayfinder_customer/logic/logic_exports.dart';

import 'widgets_export.dart';

void loadAccommodation(BuildContext context, int id) {
  context.read<ParticularAccommodationCubit>()..fetchAccommodation(id);
}
