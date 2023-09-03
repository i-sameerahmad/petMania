// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_mania/AdoptAPet/landingAdoptpet.dart';
import 'package:pet_mania/Backend/doctor.dart';
import 'package:pet_mania/trainer_landing/trainerLangingPage.dart';
import 'package:pet_mania/utils/appConstants.dart';
import 'package:pet_mania/vet_module/VatDetailScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VatLanding extends StatefulWidget {
  final List<dynamic> doctors;

  const VatLanding({Key? key, required this.doctors}) : super(key: key);

  @override
  State<VatLanding> createState() => _VatLandingState();
}

class _VatLandingState extends State<VatLanding> {
  List<dynamic> doctors = [];
  String userName = "";
  String searchQuery = '';

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName')!;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchDoctors();
  }

  final DoctorNotifier _doctorNotifier = DoctorNotifier();

  Future<void> fetchDoctors() async {
    try {
      List<dynamic> fetchedDoctors = await DoctorNotifier().fetchDoctors();
      setState(() {
        doctors = fetchedDoctors;
      });
    } catch (error) {
      print('Failed to fetch doctors: $error');
    }
  }

  List<dynamic> filterDoctors(String query) {
    return doctors.where((doctor) => doctor['doc_name'].toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = filterDoctors(searchQuery);

    return Scaffold(
      appBar: AppBar(
        actions: [],
        centerTitle: true,
        title: Text(
          'Veterinarian',
          style: TextStyle(fontFamily: 'Itim-Regular', fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Hey, $userName...",
                  style: TextStyle(fontFamily: 'Itim-Regular', fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  "How May I Help You Today?",
                  style: TextStyle(fontFamily: 'Itim-Regular', fontSize: 27),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredDoctors.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic doctor = filteredDoctors[index];
                  final image = DB_URL_IMAGES + doctor['doc_image'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () async {
                        try {
                          var response = _doctorNotifier.fetchDoctor(doctor['id']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VatDetailScreen(doctorData: response),
                            ),
                          );
                        } catch (error) {
                          print('Failed to fetch doctor data: $error');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 171, 207, 172),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: DB_URL_IMAGES + doctor['doc_image'],
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                height: 120,
                                width: 120,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor['doc_name'],
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Itim-Regular',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      doctor['doc_qualification'],
                                      style: TextStyle(
                                        fontFamily: 'Itim-Regular',
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Fee: ${doctor['doc_fee']}',
                                          style: TextStyle(
                                            fontFamily: 'Itim-Regular',
                                            fontSize: 18,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Icon(Icons.star, color: Colors.yellow),
                                        //     SizedBox(width: 5),
                                        //     Text(
                                        //       '4',
                                        //       style: TextStyle(
                                        //         fontFamily: 'Itim-Regular',
                                        //         fontSize: 18,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.timer),
                                        SizedBox(width: 5),
                                        Text(
                                          "Active: ${doctor['doc_slot']}",
                                          style: TextStyle(
                                            fontFamily: 'Itim-Regular',
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
