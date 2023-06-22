// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:pet_paradise/Commons/map.dart';
import 'package:pet_paradise/components/styles.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetDetails extends StatefulWidget {
  final List<dynamic> petData; // Updated type

  const PetDetails({Key? key, required this.petData}) : super(key: key);

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
            ),
            onPressed: () {
              if (userID != pet[0]['user_id']) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(
                    participantIds: [userID.toString(), pet[0]['user_id'].toString()],
                  ),
                ));
              }
            },
          )
        ],
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
                    pet[0]['title'],
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
                    imageUrl: DB_URL_IMAGES + pet[0]['image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 250,
                    width: 250,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'PKR, ${pet[0]['price']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: ' Itim-Regular',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 80)),
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
              // const SizedBox(
              //   height: 10,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      child: Column(
                        children: [
                          Text(
                            pet[0]['gender'],
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
                            pet[0]['category'],
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
                            pet[0]['age'].toString() + " M",
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pet[0]['description'],
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User details',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ' Itim-Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Name'),
                        subtitle: Text(pet[0]['user_name']),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Email'),
                        subtitle: Text(pet[0]['user_email']),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone'),
                        subtitle: Text(pet[0]['user_phone']),
                      ),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Address'),
                        subtitle: Text(pet[0]['user_address']),
                      ),
                    ],
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
