import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/add_pet_detail.dart';
import 'package:pet_paradise/pages/edit_profile.dart';
// import 'package:pet_paradise/pages/dummy.dart';
import 'package:pet_paradise/pages/wishlist.dart';

import '../components/styles.dart';

class MyProfile extends StatefulWidget {
  static const String id = 'MyProfile';

  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
          toolbarHeight: 170,
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: const Color.fromARGB(255, 106, 31, 31),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          shadowColor: backgroundColor,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                },
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined),
                    const SizedBox(width: 4),
                    appcolorText('Edit')
                  ],
                ))
          ],
          bottom: PreferredSize(
            preferredSize: const Size(0.0, 60.0),
            child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 46,
                      backgroundImage: AssetImage('assets/images/pet.jpg'),
                    ),
                    const SizedBox(height: 10),
                    blackHeading('Vivian Richard'),
                    greyText('Florida')
                  ],
                )),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.pets)),
                  title: const Text('My pets'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPetDetail()));
                  },
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.favorite_border)),
                  title: const Text('My favourites'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WishList()));
                  },
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.home_repair_service_outlined)),
                  title: const Text('Add pet service'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddPetDetail()));
                  },
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.share)),
                  title: const Text('Invite friends'),
                  onTap: () {},
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.help_outline)),
                  title: const Text('Help'),
                  onTap: () {},
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(Icons.settings_outlined)),
                  title: const Text('Settings'),
                  onTap: () {},
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ));
  }
}
