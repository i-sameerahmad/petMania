import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pet_mania/Backend/doctor.dart';
import 'package:pet_mania/Commons/chat.dart';
import 'package:pet_mania/Commons/docprofile.dart';
import 'package:pet_mania/Commons/doneapps.dart';
import 'package:pet_mania/Commons/edituser.dart';
import 'package:pet_mania/Commons/inbox.dart';
import 'package:pet_mania/Commons/login_page.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorHomeScreen(),
    );
  }
}

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen();

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _currentIndex = 0;
  final DoctorNotifier _doctorNotifier = DoctorNotifier();
  String userName = "";
  late int userID;

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
      userName = prefs.getString('userName')!;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
  }

  final List<String> _bannerImages = [
    'assets/images/vetbanner1.jpg',
    'assets/images/vetbanner2.jpg',
  ];

  final List<Widget> _tabs = [
    TodayAppointmentsTab(),
    AllAppointmentsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      //borderRadius: radius(100),
                    ),
                    child: Image.asset(
                      'assets/images/use1.jpg',
                      height: 58,
                      width: 58,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Ahmar', style: TextStyle(color: Colors.white, fontSize: 18)),
                          Text('03104747899', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorProfilePage()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Done Appointments'),
              leading: const Icon(Icons.check),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DoneAppointments()),
                );
              },
            ),
            ListTile(
              title: const Text('LogOut'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),

            // Add more ListTile widgets for additional drawer items
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            child: Text(
              "Hello $userName!",
              style: TextStyle(
                color: Colors.black,
                fontFamily: ' Itim-Regular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              height: 200,
            ),
            items: _bannerImages.map((image) {
              return Container(
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  child: TabItem(
                    title: 'Today\'s Appointments',
                    isSelected: _currentIndex == 0,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  child: TabItem(
                    title: 'All Appointments',
                    isSelected: _currentIndex == 1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: _tabs[_currentIndex],
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  const TabItem({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? MyColors.MATERIAL_LIGHT_GREEN : Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class TodayAppointmentsTab extends StatefulWidget {
  @override
  _TodayAppointmentsTabState createState() => _TodayAppointmentsTabState();
}

class _TodayAppointmentsTabState extends State<TodayAppointmentsTab> {
  List<dynamic> _appointments = [];
  late int userID;
  final DoctorNotifier _doctorNotifier = DoctorNotifier();

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getappointments'));
      if (response.statusCode == 200) {
        final appointments = jsonDecode(response.body);

        final now = DateTime.now();
        final todayDate = DateFormat('yyyy-MM-dd').format(now);

        final todayAppointments = appointments.where((appointment) => appointment['date'] == todayDate).toList();

        setState(() {
          _appointments = todayAppointments;
        });
      } else {
        throw Exception('Failed to fetch appointments');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(appointment['description']),
              subtitle: Text(appointment['date']),
              leading: Text(appointment['user_name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      if (userID != appointment['user_id']) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatPage(
                            participantIds: [userID.toString(), appointment['user_id'].toString()],
                          ),
                        ));
                      }
                    },
                  ),
                  Text(appointment['status']),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _doctorNotifier.doneapp(context, appointment['id']);
                    },
                    child: Text('Done'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AllAppointmentsTab extends StatefulWidget {
  @override
  _AllAppointmentsTabState createState() => _AllAppointmentsTabState();
}

class _AllAppointmentsTabState extends State<AllAppointmentsTab> {
  List<dynamic> _appointments = [];
  late int userID;
  final DoctorNotifier _doctorNotifier = DoctorNotifier();

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.102:8000/api/getappointments'));
      if (response.statusCode == 200) {
        setState(() {
          _appointments = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch appointments');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _appointments.length,
      itemBuilder: (context, index) {
        final appointment = _appointments[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(appointment['description']),
              subtitle: Text(appointment['date']),
              leading: Text(appointment['user_name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(
                          participantIds: [userID.toString(), appointment['user_id'].toString()],
                        ),
                      ));
                    },
                  ),
                  // Text(appointment['status']),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _doctorNotifier.doneapp(context, appointment['id']);
                    },
                    child: Text('Done'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
