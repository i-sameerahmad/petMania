// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/vet_module/vatConsultScreen.dart';

class OrderViewDetail extends StatefulWidget {
  const OrderViewDetail({super.key});

  @override
  State<OrderViewDetail> createState() => _OrderViewDetailState();
}

class _OrderViewDetailState extends State<OrderViewDetail> {
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Chat()),
              // );
            },
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: InkWell(
              onTap: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VatConsultScreen()),
                );
              }),
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.MATERIAL_LIGHT_GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: Image.asset(NOIMAGE,
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                              alignment: Alignment.center)
                          .image,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Javeria Saleem",
                          style: TextStyle(
                            fontFamily: ' Itim-Regular',
                            fontSize: 28,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Female",
                          style: TextStyle(
                            fontFamily: ' Itim-Regular',
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Pet Details',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pet Name',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Sheru',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                Text(
                  '1 Year',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Breed',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Tennessee',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Symptoms',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                Text(
                  'High Fever',
                  style: TextStyle(
                    fontFamily: ' Itim-Regular',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 12),
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
                    'Fever, respiratory distress,  mucous discharge,from nostril Fever, respiratory distress,  mucous discharge,from nostril,Fever, respiratory distress,  mucous discharge,from nostril,Fever, respiratory distress,  mucous discharge,from nostril,Fever, respiratory distress,  mucous discharge,from nostril,Fever, respiratory distress,  mucous discharge,from nostril,Fever, respiratory distress,  mucous discharge,from nostril',
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
        ],
      )),
    );
  }
}
