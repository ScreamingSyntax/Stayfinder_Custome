import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/screens/screens_export.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CategoryViewScreen extends StatelessWidget {
  final List<Accommodation> accommodation;

  const CategoryViewScreen({super.key, required this.accommodation});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: UsedColors.mainColor,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.read<StoreSearchCubit>()..reset();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SearchScreen(onBackPressed: () {
                                        Navigator.pop(context);
                                      })));
                        },
                        child: CustomTextFormField(
                          isEnabled: false,
                          hintText: "Search Accommodations",
                          suffixIcon: IconlyLight.search,
                          onTapOutside: (p0) =>
                              FocusScope.of(context).unfocus(),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    itemCount: accommodation.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Accommodation accommodations = accommodation[index];
                          context
                              .read<ParticularAccommodationCubit>()
                              .fetchAccommodation(accommodations.id!);
                          NavigateToAccommodation(accommodations, context);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CustomAccommodationCard(
                              image: accommodation[index].image.toString(),
                              city: accommodation[index].city.toString(),
                              address: accommodation[index].address.toString(),
                              name: accommodation[index].name.toString(),
                              ratings: "3",
                              type: accommodation[index].type.toString(),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
