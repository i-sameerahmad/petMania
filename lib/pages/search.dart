import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/home.dart';
import 'package:pet_paradise/pages/login.dart';
import 'package:pet_paradise/pages/add_pet_detail.dart';
import 'package:pet_paradise/pages/edit_profile.dart';
import 'package:pet_paradise/pages/select_doctor.dart';
import 'package:pet_paradise/pages/shop.dart';
import 'package:pet_paradise/pages/wishlist.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import '../components/styles.dart';
import 'package:flutter/cupertino.dart';

class SearchService extends StatefulWidget {
  static const String id = 'SearchService';

  const SearchService({Key? key}) : super(key: key);

  @override
  _SearchServiceState createState() => _SearchServiceState();
}

class _SearchServiceState extends State<SearchService> {
  List<Item> Items = [
    const Item('assets/images/50.png', 'Veternity'),
    const Item('assets/images/41.png', 'Crooming'),
    const Item('assets/images/42.png', 'Pvt boarding'),
    const Item('assets/images/43.png', 'Adoption'),
    const Item('assets/images/44.png', 'Dog Walking'),
    const Item('assets/images/45.png', 'Training'),
    const Item('assets/images/47.png', 'Pvt Taxi'),
    const Item('assets/images/46.png', 'Pvt date'),
    const Item('assets/images/48.png', 'Other'),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GridView.custom(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      childrenDelegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddPetDetail(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WishList(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                    height: 70,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Shop(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Home(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
            child: InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Login(),
                    )),
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 35),
                          child: Image.asset(
                            "assets/images/50.png",
                            height: 65,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 95, left: 43),
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          // Container(
          //     padding: EdgeInsets.all(30),
          //     color: backgroundColor,
          //     child: Column(
          //       children: [
          //         RichText(
          //           text: TextSpan(
          //               text: 'What are you \n looking for, ',
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontFamily: 'bold',
          //                   fontSize: 32),
          //               children: [
          //                 TextSpan(
          //                   text: 'Richard?',
          //                   style: TextStyle(
          //                       color: appColor3,
          //                       fontFamily: 'bold',
          //                       fontSize: 32),
          //                 ),
          //               ]),
          //         ),
          //         SizedBox(height: 50),
          //         GridView.count(
          //           crossAxisCount: 3,
          //           crossAxisSpacing: 16.0,
          //           mainAxisSpacing: 16.0,
          //           shrinkWrap: true,
          //           children: Items.map((item) => _buildCards(context, item))
          //               .toList(),
          //         ),
          //       ],
          //     )),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context, Item item) {
    if (item.txt == 'Pvt date') {
      return GestureDetector(
        onTap: () {
          _ModalBottomSheetCart(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(item.img, width: 40, height: 40),
              ),
              const SizedBox(height: 10),
              blackText(item.txt),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectDoctor(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(item.img, width: 40, height: 40),
              ),
              const SizedBox(height: 10),
              blackText(item.txt),
            ],
          ),
        ),
      );
    }
  }

  void _ModalBottomSheetCart(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
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
              title: boldText("Select a date"),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: appColor,
                ),
                onPressed: () {},
              ),
            ),
            body: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {},
              initialDateTime: DateTime.now(),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                Expanded(
                  child: MyElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectDoctor()));
                      },
                      text: 'Show 12 results',
                      colors: appColor),
                ),
                const SizedBox(width: 10),
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
                      child: const Text("Skip", style: TextStyle(color: appColor)),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

class Item {
  const Item(this.img, this.txt);
  final img;
  final txt;
}
