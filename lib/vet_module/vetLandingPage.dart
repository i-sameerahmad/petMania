// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/AdoptAPet/landingAdoptpet.dart';
import 'package:pet_paradise/Backend/doctor.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:pet_paradise/trainer_landing/trainerLangingPage.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:pet_paradise/vet_module/VatDetailScreen.dart';

class VatLanding extends StatefulWidget {
  final List<dynamic> doctors;

  const VatLanding({Key? key, required this.doctors}) : super(key: key);

  @override
  State<VatLanding> createState() => _VatLandingState();
}

class _VatLandingState extends State<VatLanding> {
  List<dynamic> doctors = [];

  @override
  void initState() {
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
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          )
        ],
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
                  "Hey, Ahmad...",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrainerLanding()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/training.png",
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            "Training",
                            style: TextStyle(
                                fontFamily: 'Itim-Regular', fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VatLanding(doctors: doctors),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/veterinary.png",
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            "Veterinary",
                            style: TextStyle(
                                fontFamily: 'Itim-Regular', fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ADOPTPET()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/grooming.png",
                            height: 100,
                            width: 100,
                          ),
                          Text(
                            "Adopt",
                            style: TextStyle(
                                fontFamily: 'Itim-Regular', fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  dynamic doctor = doctors[index];
                  final image = DB_URL_IMAGES + doctor['doc_image'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () async {
                        try {
                          var response =
                              _doctorNotifier.fetchDoctor(doctor['id']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VatDetailScreen(doctorData: response),
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
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Fee: ${doctor['doc_fee']}',
                                          style: TextStyle(
                                            fontFamily: 'Itim-Regular',
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.yellow),
                                            SizedBox(width: 5),
                                            Text(
                                              '4',
                                              style: TextStyle(
                                                fontFamily: 'Itim-Regular',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
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
