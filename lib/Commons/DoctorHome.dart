import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/Backend/Auth/auth.dart';
import 'package:pet_paradise/Commons/chat.dart';
import 'package:pet_paradise/Commons/inbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen();

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _currentIndex = 0;

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
                    builder: (context) => const MyHomePage(
                        // userId: userID,
                        )),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
    // print(user_id);
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/getappointments'));
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
        return Card(
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
                Text(appointment['status']),
              ],
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
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
    // print(user_id);
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/getappointments'));
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
        return Card(
          child: ListTile(
            title: Text(appointment['description']),
            subtitle: Text(appointment['date']),
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
                Text(appointment['status']),
              ],
            ),
          ),
        );
      },
    );
  }
}
