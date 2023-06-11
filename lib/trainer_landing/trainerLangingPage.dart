// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_paradise/AdoptAPet/landingAdoptpet.dart';
import 'package:pet_paradise/trainer_landing/trainerDetail.dart';
import 'package:pet_paradise/utils/appConstants.dart';

class TrainerLanding extends StatefulWidget {
  const TrainerLanding({
    super.key,
  });

  @override
  State<TrainerLanding> createState() => _TrainerLandingState();
}

class _TrainerLandingState extends State<TrainerLanding> {
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
              // do something
            },
          )
        ],
        centerTitle: true,
        title: Text(
          'Trainer',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text("Hey, Ahmad... :)",
                        style: TextStyle(
                            fontFamily: ' Itim-Regular', fontSize: 25)),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  children: [
                    Text("How May I  Help You Today?",
                        style: TextStyle(
                            fontFamily: ' Itim-Regular', fontSize: 27)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                        Text("Training",
                            style: TextStyle(
                                fontFamily: ' Itim-Regular', fontSize: 20)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     // context,
                      //     // MaterialPageRoute(builder: (context) => VatLanding()),
                      //     );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/veterinary.png",
                          height: 100,
                          width: 100,
                        ),
                        Text("Veterinary",
                            style: TextStyle(
                                fontFamily: ' Itim-Regular', fontSize: 20)),
                      ],
                    ),
                  ),
                  InkWell(
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
                        Text("Adopt",
                            style: TextStyle(
                                fontFamily: ' Itim-Regular', fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 600,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrainerDetail()),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 171, 207, 172),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: Text(
                                                'Umer',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontFamily: ' Itim-Regular',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: Text(
                                                'MS in Computer',
                                                style: TextStyle(
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Price: 99\$}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          ' Itim-Regular',
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.star),
                                                      Text(
                                                        '1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              ' Itim-Regular',
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              NOIMAGE,
                                              height: 120,
                                              width: 120,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.timer),
                                          Expanded(
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 15,
                                              softWrap: false,
                                              "Active Days: Monday Tuesday ",
                                              style: TextStyle(
                                                fontFamily: ' Itim-Regular',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
