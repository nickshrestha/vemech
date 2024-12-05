import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vemech/widgets/prefrences_helper.dart';

// HomePageView displays a carousel, categories, nearby workshops, and an action button.
class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // Main layout is a column inside a padding widget to provide space around.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Text(SharedPreferencesHelper.getToken().toString()),
          // Carousel Slider for displaying images in a slideshow.
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: [
              'https://picsum.photos/500/500',
              'https://picsum.photos/200',
              'https://picsum.photos/300',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(i), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Categories section with horizontal scrolling list.
          buildCategorySection(),
          const SizedBox(height: 20),
          // Nearby workshop section with horizontal scrolling list.
          buildNearbyWorkshopSection(context),
          const SizedBox(height: 20),
          // Button for onsite requests.
          ElevatedButton(
            onPressed: () {},
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(child: Text("Onsite Request")),
            ),
          )
        ],
      ),
    );
  }

  // Helper method to build the Categories section.
  Widget buildCategorySection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.green,
                        child: Icon(
                          index == 0
                              ? Icons.bike_scooter_rounded
                              : index == 1
                                  ? Icons.car_repair
                                  : Icons.alt_route_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        index == 0
                            ? "Bike"
                            : index == 1
                                ? "Car"
                                : 'Other',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Helper method to build the Nearby Workshop section.
  Widget buildNearbyWorkshopSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nearby Workshop",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 250,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 2)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bhaktapur Workshop',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Text("0.0 km away"),
                      Text("Bhakatapur "),
                      Text("Book now."),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
