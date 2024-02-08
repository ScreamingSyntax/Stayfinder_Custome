import 'widgets_export.dart';

void popMultipleScreens(BuildContext context, int popCount) {
  int count = 0;
  Navigator.popUntil(context, (route) {
    return count++ == popCount || !Navigator.of(context).canPop();
  });
}
