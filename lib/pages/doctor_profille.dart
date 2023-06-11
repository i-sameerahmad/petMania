import 'package:flutter/material.dart';
// import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:pet_paradise/pages/booked_confirm_modal.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import '../components/styles.dart';

class DoctorProfile extends StatefulWidget {
  static const String id = 'DoctorProfile';

  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  int tabID = 1;
  List<Item> timeList = <Item>[
    const Item('10:00'),
    const Item('11:00'),
    const Item('12:00'),
    const Item('01:00'),
    const Item('02:00'),
    const Item('03:00'),
    const Item('04:00'),
    const Item('05:00'),
    const Item('06:00'),
  ];
  // final DatePickerController _controller = DatePickerController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildProfile(),
                      const SizedBox(height: 60),
                      _buildProfileDtl()
                    ],
                  ),
                  Positioned(
                      top: 340,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _buildDoctorDetail()),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/dr.jpg"), fit: BoxFit.cover),
        ));
  }

  Widget _buildDoctorDetail() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText('Viv Richardsan'),
                colorText('Veterinary Dentist'),
                greyTextSmall('10 years of experience'),
                const SizedBox(height: 4),
                Row(
                  children: [
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
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
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
          ),
          Column(
            children: [
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20.0,
                        )
                      ]),
                  child: const Center(
                    child: Text('4.9',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'semibold')),
                  )),
              greyTextSmall('120 reviews')
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfileDtl() {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Column(
            children: [
              MediumText(
                  '"He was friendly and diligent in getting to the right diagnosis and prescription."'),
              const SizedBox(height: 8),
              Row(
                children: [
                  smallText('a verified review'),
                  const SizedBox(width: 4),
                  const Icon(Icons.check_circle, color: Colors.green, size: 14)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(children: [
                    Icon(Icons.star, color: appColor3, size: 14),
                    Icon(Icons.star, color: appColor3, size: 14),
                    Icon(Icons.star, color: appColor3, size: 14),
                    Icon(Icons.star, color: appColor3, size: 14),
                    Icon(Icons.star, color: appColor3, size: 14)
                  ]),
                  const SizedBox(height: 8),
                  Container(
                      child: Row(
                    children: [
                      appcolorText('View all 120 Reviews'),
                      const Icon(Icons.chevron_right)
                    ],
                  ))
                ],
              ),
              _buildCalender()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalender() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // DatePicker(
          //   DateTime.now(),
          //   width: 55,
          //   height: 100,
          //   controller: _controller,
          //   dateTextStyle: TextStyle(color: Colors.black54, fontSize: 16),
          //   initialSelectedDate: DateTime.now(),
          //   selectionColor: appColor,
          //   selectedTextColor: Colors.white,
          //   inactiveDates: [DateTime.now().add(Duration(days: 4))],
          //   onDateChange: (date) {
          //     setState(() {});
          //   },
          // ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                children: timeList.map((e) {
                  return _buildCategory(context, e);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(context, e) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabID = e.hashCode;
        });
      },
      child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          decoration: BoxDecoration(
            color: tabID == e.hashCode ? appColor : backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Text(
            e.name,
            style: TextStyle(
                color: tabID == e.hashCode ? Colors.white : appColor,
                fontSize: 12),
          )),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  '\$20 ',
                  style: TextStyle(
                      color: appColor, fontSize: 20, fontFamily: 'semibold'),
                ),
                MediumText('/ first visit')
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: appColor3, size: 14),
                const Icon(Icons.star, color: appColor3, size: 14),
                const Icon(Icons.star, color: appColor3, size: 14),
                const Icon(Icons.star, color: appColor3, size: 14),
                const Icon(Icons.star, color: appColor3, size: 14),
                const SizedBox(width: 10),
                smallText('28 Reviews'),
              ],
            )
          ],
        ),
        const SizedBox(width: 30),
        Expanded(
          child: MyElevatedButton(
              onPressed: () {
                _ModalBottomSheetCart(context);
              },
              text: 'Book',
              colors: appColor),
        ),
      ]),
    );
  }

  void _ModalBottomSheetCart(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext bc) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: boldText("Booking confirmation"),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: appColor,
                ),
                onPressed: () {},
              ),
            ),
            body: Container(
              // padding: EdgeInsets.all(24),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/images/dr.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackBoldText('Vivial Richard'),
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
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      // DatePicker(
                      //   DateTime.now(),
                      //   width: 55,
                      //   height: 100,
                      //   controller: _controller,
                      //   dateTextStyle:
                      //       TextStyle(color: Colors.black54, fontSize: 16),
                      //   initialSelectedDate: DateTime.now(),
                      //   selectionColor: appColor,
                      //   selectedTextColor: Colors.white,
                      //   inactiveDates: [DateTime.now().add(Duration(days: 4))],
                      //   onDateChange: (date) {
                      //     setState(() {});
                      //   },
                      // ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            children: timeList.map((e) {
                              return _buildCategory(context, e);
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                Row(
                  children: [
                    const Text(
                      '\$20 ',
                      style: TextStyle(
                          color: appColor,
                          fontSize: 20,
                          fontFamily: 'semibold'),
                    ),
                    MediumText('/ first visit')
                  ],
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: MyElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BookingConfirmModal()));
                      },
                      text: 'Book',
                      colors: appColor),
                ),
              ]),
            ),
          );
        });
  }
}

class Item {
  const Item(this.name);
  final String name;
}
