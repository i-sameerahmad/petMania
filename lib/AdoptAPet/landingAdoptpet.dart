// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pet_paradise/AdoptAPet/petDetail.dart';
import 'package:pet_paradise/Commons/chat.dart';

class ADOPTPET extends StatefulWidget {
  const ADOPTPET({
    super.key,
  });

  @override
  State<ADOPTPET> createState() => _ADOPTPETState();
}

class _ADOPTPETState extends State<ADOPTPET> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Adopt a Pet",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ' Itim-Regular',
              fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
            ),
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Chat()));
              // do something
            },
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: Image.asset('assets/images/meena.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      alignment: Alignment.center)
                  .image,
            ),
            title: Text(
              'Ahmad',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ' Itim-Regular',
                  fontSize: 22),
            ),
            subtitle: Text(
              'Lahore ,Pakistan',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ' Itim-Regular',
                  fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 15),
                child: Column(
                  children: [
                    Text(
                      '40% off on all',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ' Itim-Regular',
                          fontSize: 18),
                    ),
                    Text(
                      'Pets Adoption',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: ' Itim-Regular',
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/aaaa.png')
            ],
          ),
          Container(
            color: Color(0xfffa3ba61),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/cat logo 1.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Cats',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ' Itim-Regular',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/Bird Logo 1.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Birds',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ' Itim-Regular',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/Dog Icon 2 1.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Dogs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ' Itim-Regular',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/Rabbit Logo 1.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rabbits',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ' Itim-Regular',
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xfffa3ba61),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15),
                      child: Text(
                        '230 Cats Found',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: ' Itim-Regular',
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => PetDetails()));
                          // },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 117, 133, 69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child:
                                      Image.asset('assets/images/cat 3 1.png'),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'Mona',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'PKR 120',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Breed-Persian',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Male',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '1 Year',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => PetDetails()));
                          // },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 117, 133, 69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child:
                                      Image.asset('assets/images/cat 3 2.png'),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'Samanta',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'PKR 120',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Breed-Persian',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Female',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '5 M',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => PetDetails()));
                          // },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 117, 133, 69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child:
                                      Image.asset('assets/images/cat 3 3.png'),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'Coco',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'PKR 120',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Breed-Persian',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Male',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '4 M',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => PetDetails()));
                          // },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 117, 133, 69),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child:
                                      Image.asset('assets/images/cat 3 4.png'),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'Whito',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 5),
                                      child: Text(
                                        'PKR 120',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Breed-Persian',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Male',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                '4 Years',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: ' Itim-Regular',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 69, 83, 28),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
