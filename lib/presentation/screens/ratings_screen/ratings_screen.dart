import 'package:stayfinder_customer/data/models/review_model.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class RatingsScreen extends StatelessWidget {
  final List<ReviewModel> reviews;

  double viewAverageRatings({required List<ReviewModel> reviews}) {
    int count = reviews.length;
    double totalRatings = 0;
    reviews.forEach((element) {
      totalRatings += double.parse(element.title!);
    });
    double averageRatings = totalRatings / count;
    String stringValue = averageRatings.toStringAsFixed(1);
    averageRatings = double.parse(stringValue);
    return averageRatings;
  }

  RatingsScreen({super.key, required this.reviews});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Ratings & Reviews  (${reviews.length})",
          style: TextStyle(fontSize: 14),
        ),
      ),
      backgroundColor: UsedColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // if (state.reviewModel.length != 0)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              // color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // color: Colors.black,
                        child: Text(
                          viewAverageRatings(reviews: reviews).toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RatingBar.builder(
                        initialRating: viewAverageRatings(reviews: reviews),
                        minRating: 1,
                        updateOnDrag: false,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        unratedColor: UsedColors.fadeOutColor.withOpacity(0.1),
                        itemSize: 25,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: reviews.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ReviewsCard(
                            description: reviews[index].description!,
                            image: reviews[index].image,
                            ratings: double.parse(reviews[index].title!),
                            userName: reviews[index].customer!.full_name!,
                            date: reviews[index].added_time.toString(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
