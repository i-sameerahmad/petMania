// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_mania/Commons/chat.dart';
import 'package:pet_mania/components/styles.dart';
import 'package:pet_mania/pages/booking.dart';
import 'package:pet_mania/utils/appConstants.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VarifiedPetDetails extends StatefulWidget {
  final List<dynamic> petData; // Updated type

  const VarifiedPetDetails({Key? key, required this.petData}) : super(key: key);

  @override
  State<VarifiedPetDetails> createState() => _VarifiedPetDetailsState();
}

class _VarifiedPetDetailsState extends State<VarifiedPetDetails> {
  List<dynamic> pet = [];
  late int userID;
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('userID'));
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
    // print(user_id);
  } // Added variable

  @override
  void initState() {
    myPrefs();
    super.initState();
    _fetchPet(); // Fetch doctor data when the screen initializes
  }

  Future<void> _fetchPet() async {
    try {
      final List<dynamic> data = widget.petData;
      setState(() {
        pet = data;
        print(pet);
      });
    } catch (error) {
      // Handle error
      print('Failed to fetch doctor data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Pet Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ' Itim-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pet[0]['vpet_name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ' Itim-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: DB_URL_IMAGES + pet[0]['vpet_image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 250,
                    width: 250,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'PKR, ${pet[0]['vpet_price']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ' Itim-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      child: Column(
                        children: [
                          Text(
                            pet[0]['vpet_gender'],
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: ' Itim-Regular',
                              fontSize: 24,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfff89aa28),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      child: Column(
                        children: [
                          Text(
                            pet[0]['vpet_category'],
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: ' Itim-Regular',
                              fontSize: 24,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfff89aa28),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      child: Column(
                        children: [
                          Text(
                            pet[0]['vpet_age'].toString() + " M",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: ' Itim-Regular',
                              fontSize: 24,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfff89aa28),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ' Itim-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pet[0]['vpet_description'],
                        maxLines: 10,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ' Itim-Regular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingPage(userId: userID, petData: pet[0])),
                    );
                  }),
                  child: Container(
                    decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(
                          "Book me",
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
            ],
          ),
        ),
      ),
    );
  }
}
