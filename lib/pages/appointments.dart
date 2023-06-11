import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/doctor_profille.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import '../components/styles.dart';

class Appointments extends StatefulWidget {
  static const String id = 'Appointments';

  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
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
        centerTitle: true,
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.black, fontFamily: 'bold'),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size(0.0, 60.0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
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
                _buildUpcoming('assets/images/pet.jpg', 'Vladimir Putin'),
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
                _buildPast('assets/images/pet.jpg', 'White House'),
              ],
            )),
      ],
    );
  }

  Widget buildSegment1() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Text('Upcoming',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'semibold',
                color: selectedValue == 0 ? Colors.white : Colors.black)),
      );

  Widget buildSegment2() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Text('Past',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'semibold',
                color: selectedValue == 1 ? Colors.white : Colors.black)),
      );

  Widget _buildUpcoming(img, name) {
    return Container(
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
            _buildAppointments(img, name),
            const SizedBox(height: 10),
            Container(
              child: Row(children: [
                Expanded(
                  child: MyElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorProfile()));
                      },
                      text: 'Edit',
                      colors: appColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54, padding: const EdgeInsets.all(14),
                        side: const BorderSide(
                          color: appColor,
                        ),
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Cancel", style: TextStyle(color: appColor)),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }

  Widget _buildPast(img, name) {
    return Container(
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
        child: _buildAppointments(img, name));
  }

  Widget _buildAppointments(img, name) {
    return Column(
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
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: backgroundColor,
                          child: Icon(Icons.location_on_outlined,
                              color: appColor, size: 20),
                        ),
                        const SizedBox(width: 4),
                        greyTextSmall('1.5 km')
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundColor: backgroundColor,
                          child: Icon(Icons.credit_card,
                              color: appColor, size: 20),
                        ),
                        const SizedBox(width: 4),
                        greyTextSmall('\$20')
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.location_on_outlined,
                        color: appColor, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      colorText('Veterinary clinic "Alden-Vet"'),
                      blackText('21 N Union Ave, San France, UK'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.location_on_outlined,
                        color: appColor, size: 20),
                  ),
                  const SizedBox(width: 10),
                  greyText('Wed 9 Sep - 10.30 am'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Item {
  const Item(this.img, this.txt);
  final img;
  final txt;
}
