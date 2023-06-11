import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/doctor_profille.dart';
import '../components/styles.dart';

class SelectDoctor extends StatefulWidget {
  static const String id = 'SelectDoctor';

  const SelectDoctor({Key? key}) : super(key: key);

  @override
  _SelectDoctorState createState() => _SelectDoctorState();
}

class _SelectDoctorState extends State<SelectDoctor> {
  int selectedValue = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: appColor),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3,
        shadowColor: backgroundColor,
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: CupertinoSlidingSegmentedControl(
            groupValue: selectedValue,
            backgroundColor: Colors.white,
            thumbColor: appColor,
            children: {
              0: buildSegment1(),
              1: buildSegment2(),
            },
            onValueChanged: (i) {
              selectedValue = i.hashCode;
              setState(() {});
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 4),
                  appcolorText('Map')
                ],
              ))
        ],
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 60.0),
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: InputBorder.none,
                hintText: "Veterinary near you",
                hintStyle: TextStyle(fontSize: 16, color: Colors.black26),
                suffixIcon: SizedBox(
                    width: 50,
                    child: Icon(Icons.search, color: Colors.black26)),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          if (selectedValue == 0)
            _builSpecialist()
          else if (selectedValue == 1)
            _builClinic()
        ]),
      ),
    );
  }

  Widget _builSpecialist() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            color: backgroundColor,
            child: Column(
              children: [
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
                _buildDoctorList('assets/images/pet.jpg', 'Vladimir Putin'),
              ],
            )),
      ],
    );
  }

  Widget _builClinic() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            color: backgroundColor,
            child: Column(
              children: [
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
                _buildDoctorList('assets/images/pet.jpg', 'White House'),
              ],
            )),
      ],
    );
  }

  Widget buildSegment1() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Text('Specialists',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'semibold',
                color: selectedValue == 0 ? Colors.white : Colors.black)),
      );

  Widget buildSegment2() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Text('Clinics',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'semibold',
                color: selectedValue == 1 ? Colors.white : Colors.black)),
      );

  Widget _buildDoctorList(img, name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorProfile()));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackBoldText(name),
                    const SizedBox(height: 4),
                    colorText('Veterinary Dentist'),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: appColor3, size: 14),
                        const Icon(Icons.star, color: appColor3, size: 14),
                        const Icon(Icons.star, color: appColor3, size: 14),
                        const Icon(Icons.star, color: appColor3, size: 14),
                        const Icon(Icons.star, color: appColor3, size: 14),
                        const SizedBox(width: 20),
                        greyTextSmall('28 Reviews'),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                greyText('7 years of experience'),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.location_on_outlined,
                          color: appColor, size: 20),
                    ),
                    const SizedBox(width: 4),
                    greyTextSmall('1.5 km')
                  ],
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.credit_card, color: appColor, size: 20),
                    ),
                    const SizedBox(width: 4),
                    greyTextSmall('\$20')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Item {
  const Item(this.img, this.txt);
  final img;
  final txt;
}
