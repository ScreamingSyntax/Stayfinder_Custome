import 'package:stayfinder_customer/logic/logic_exports.dart';

import '../../widgets/widgets_export.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    searchController.text = context.read<StoreSearchCubit>().state.searchValue;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, "/", (route) => false),
                        child: Icon(IconlyLight.arrow_left)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FocusScope(
                        onFocusChange: (value) {
                          if (searchController.text != "" &&
                              searchController.text !=
                                  context
                                      .read<StoreSearchCubit>()
                                      .state
                                      .searchValue) {
                            context
                                .read<FetchSearchResultsCubit>()
                                .fetchSearchResults(searchController.text);
                            context
                                .read<StoreSearchCubit>()
                                .searchFirst(searchController.text);
                            Navigator.pushNamed(context, "/searchResults");
                          }
                        },
                        child: CustomTextFormField(
                          controller: searchController,
                          autoFocus: true,
                          obscureText: false,
                          hintText: "Search Accommodations",
                          suffixIcon: IconlyLight.search,
                          onTapOutside: (p0) =>
                              FocusScope.of(context).unfocus(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       // Add your listener here
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TextFormField Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//           controller: _controller,
//           onFieldSubmitted: (value) {
//             // This is called when the enter key is pressed
//             print(value);
//           },
//           decoration: InputDecoration(
//             labelText: 'Enter something',
//             border: OutlineInputBorder(),
//           ),
//         ),
//       ),
//     );
//   }
// }
