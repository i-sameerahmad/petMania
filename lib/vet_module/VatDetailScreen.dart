// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_paradise/Backend/Review/doctorReview.dart';
import 'package:pet_paradise/Backend/doctor.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:pet_paradise/Commons/map.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/vet_module/vatConsultScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VatDetailScreen extends StatefulWidget {
  final Future<List<dynamic>> doctorData; // Updated type

  const VatDetailScreen({Key? key, required this.doctorData}) : super(key: key);
  @override
  State<VatDetailScreen> createState() => _VatDetailScreenState();
}

class _VatDetailScreenState extends State<VatDetailScreen> {
  List<dynamic> doctor = [];
  late int id;
  // Added variable
  final DoctorReviewNotifier _notifier = DoctorReviewNotifier();
  final DoctorNotifier _doctorNotifier = DoctorNotifier();
  final TextEditingController reviewController = TextEditingController();
  List<dynamic> reviewList = [];
  double rating = 0.0;
  String userName = "";
  late int userID;
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
      userName = prefs.getString('userName')!;
    });
    // print(user_id);
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    _fetchDoctorData(); // Fetch doctor data when the screen initializes
  }

  Future<void> _fetchDoctorData() async {
    try {
      final List<dynamic> data = await widget.doctorData;
      setState(() {
        doctor = data;
        print(doctor);
      });
      _fetchDoctorReviews(doctor.isNotEmpty ? doctor[0]['id'] : null);
      id = await _doctorNotifier.fetchDocId(doctor[0]['doc_email']);
      print(id);
    } catch (error) {
      // Handle error
      print('Failed to fetch doctor data: $error');
    }
  }

  Future<void> _fetchDoctorReviews(int productId) async {
    try {
      print(productId);
      List<dynamic> reviews = await _notifier.fetchDoctorReviews(productId);
      setState(() {
        reviewList = reviews;
        print(reviewList);
      });
    } catch (error) {
      print('Failed to fetch product reviews: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(
                        participantIds: [userID.toString(), id.toString()],
                      )));
            },
          )
        ],
        title: Text(
          'Vat Details',
          style: TextStyle(fontFamily: 'Itim-Regular', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xfffdee9bf),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10, bottom: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: DB_URL_IMAGES + doctor[0]['doc_image'],
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 120,
                        width: 120,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          doctor.isNotEmpty ? doctor[0]['doc_name'] : '',
                          style: TextStyle(
                              // decoration: TextDecoration,
                              fontFamily: ' Itim-Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 35),
                        child: Text(
                          doctor.isNotEmpty ? doctor[0]['doc_slot'] : '',
                          style: TextStyle(
                            fontFamily: 'Itim-Regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(
                thickness: 4,
                color: MyColors.MATERIAL_LIGHT_GREEN,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
              child: Row(
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      fontFamily: ' Itim-Regular',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_history),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        doctor.isNotEmpty ? doctor[0]['doc_address'] : '',
                        style: TextStyle(
                          fontFamily: ' Itim-Regular',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapScreen()),
                        );
                      },
                      child: Icon(Icons.location_history)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 25),
              child: Row(
                children: [
                  Icon(Icons.location_city),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'BVSc Distinction',
                    style: TextStyle(
                      fontFamily: ' Itim-Regular',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
              child: Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                      fontFamily: ' Itim-Regular',
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      doctor.isNotEmpty ? doctor[0]['doc_description'] : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 15,
                      softWrap: false,
                      style: TextStyle(
                        fontFamily: ' Itim-Regular',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      doctor.isNotEmpty ? doctor[0]['doc_description'] : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 15,
                      softWrap: false,
                      style: TextStyle(
                        fontFamily: ' Itim-Regular',
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: InkWell(
                onTap: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VatConsultScreen(userId: userID, doctorId: doctor[0]['id'])),
                  );
                }),
                child: Container(
                  decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        "Proceed",
                        style: TextStyle(
                          fontFamily: ' Itim-Regular',
                          fontSize: 17,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Rate this Doctor',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.0,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Write a review',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String review = reviewController.text;
                _notifier.addReview(userID, userName, review, rating, doctor[0]['id'], context);
                reviewController.clear(); // Clear the review text field
                setState(() {
                  rating = 0.0; // Reset the rating
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30.0),
              ),
              child: Text(
                'Submit Review',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),

            // Review list
            Text(
              'Product Reviews',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),

            // ListView.builder to display the reviews
            ListView.separated(
              shrinkWrap: true,
              itemCount: reviewList.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: 1.0,
                thickness: 1.0,
              ),
              itemBuilder: (context, index) {
                final review = reviewList[index];
                final double reviewRating = double.parse(review['rating'].toString());
                final String reviewText = review['review'];
                final String username = review['userName'];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 90.0),
                          RatingBar.builder(
                            initialRating: reviewRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (_) {},
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Text(reviewText),
                      SizedBox(height: 10.0),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
