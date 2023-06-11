import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/tabs.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import '../components/styles.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int selectID = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Your profile',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
          actions: [TextButton(onPressed: () {}, child: appcolorText('Skip'))],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/pet.jpg"),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
          // textField('Full name', Icons.check),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              greyTextSmall('Gender'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSelect('Male', 1),
                  _buildSelect('Female', 2),
                ],
              ),
            ],
          ),
          // textField('Email', Icons.check),
          // textField('Phone', Icons.check),
          const SizedBox(height: 30),
          MyElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TabsExample()));
              },
              colors: appColor,
              text: 'Save'),
        ],
      ),
    );
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title,
            style: TextStyle(
                fontFamily: 'medium',
                fontSize: 14,
                color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }
}
