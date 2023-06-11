// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pet_paradise/trainer_landing/trainerConfirmation.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/utils/responsive_controller.dart';

class TrainerDetail extends StatefulWidget {
  const TrainerDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<TrainerDetail> createState() => _TrainerDetailState();
}

class _TrainerDetailState extends State<TrainerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  ///Mobile UI
  Widget mobile(context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: MyColors.GREEN_LIGHT_SHADE),
          pinned: true,
          expandedHeight: 200,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/vet1.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.MATERIAL_LIGHT_GREEN,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("10 Years of experience",
                            style: TextStyle(
                                fontFamily: ' Itim-Regular', fontSize: 17)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("PETS Ayesha",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: ' Itim-Regular',
                                        fontSize: 17)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.messenger,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(Icons.camera)
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          children: [
                            Text("Farm Animals",
                                style: TextStyle(
                                    color: Color(0xFFF756D27),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: ' Itim-Regular',
                                    fontSize: 17)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("3",
                                          style: TextStyle(
                                              color: Color(0xFFF756D27),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: ' Itim-Regular',
                                              fontSize: 24)),
                                      Icon(Icons.star,
                                          color: Color(0xFFF756D27))
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  "“ He is friendly and dilligent in getting right diagnosis and prescription”",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: ' Itim-Regular',
                                      fontSize: 19)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 125,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("8th",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                  Text("Mon",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            Container(
                              height: 125,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("9th",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                  Text("Tue",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFE2EFE0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            Container(
                              height: 125,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("10th",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                  Text("Wed",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFE2EFE0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 120,
                              child: Column(
                                children: [
                                  Text("Morning",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFE2EFE0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            Container(
                              height: 50,
                              width: 120,
                              child: Column(
                                children: [
                                  Text("Evening",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFE2EFE0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                            Container(
                              height: 50,
                              width: 120,
                              child: Column(
                                children: [
                                  Text("Afternoon",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 24)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("9:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("10:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("11:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("12:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("1:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("2:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("3:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 187, 223, 114),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              child: Column(
                                children: [
                                  Text("4:00 AM",
                                      style: TextStyle(
                                          color: Color(0xFFF756D27),
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 18)),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFCCE990),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12),
                        child: InkWell(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrainerConfirmation()),
                            );
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                      )
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
