// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pet_paradise/AdoptAPet/adoptPetDetail.dart';
import 'package:pet_paradise/Backend/Pet/pet.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/pages/adopt_pet_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ADOPTPETSHOP extends StatefulWidget {
  final List<dynamic> pets;
  const ADOPTPETSHOP({Key? key, required this.pets}) : super(key: key);

  @override
  State<ADOPTPETSHOP> createState() => _ADOPTPETSHOPState();
}

class _ADOPTPETSHOPState extends State<ADOPTPETSHOP> {
  final PetNotifier _petNotifier = PetNotifier();
  List<dynamic> filteredPets = [];
  List<dynamic> pets = [];

  String userName = "";

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName')!;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    fetchAdoptPets(); // Call the method to fetch pets when the widget initializes
  }

  Future<void> fetchAdoptPets() async {
    try {
      List<dynamic> fetchedPets = await PetNotifier().fetchAdoptPets();
      setState(() {
        pets = fetchedPets;
        filteredPets = fetchedPets;
        print(pets);
      });
    } catch (error) {
      // Handle the error or display an error message
      print('Failed to fetch doctors: $error');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Adopt a Pet",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Itim-Regular',
            fontSize: 22,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.chat,
          //   ),
          //   onPressed: () {
          //     // Navigator.of(context).push(
          //     //   MaterialPageRoute(builder: (context) => Chat()),
          //     // );
          //   },
          // )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddAdoptPetDetail()));
          },
          backgroundColor: MyColors.MATERIAL_LIGHT_GREEN,
          tooltip: "Add new Blog.",
          child: Icon(
            Icons.add,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/meena.png',
                ),
                radius: 50,
              ),
              title: Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim-Regular',
                  fontSize: 22,
                ),
              ),
              subtitle: const Text(
                'Lahore, Pakistan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Itim-Regular',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '40% off on all',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Itim-Regular',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Pets Adoption',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Itim-Regular',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/aaaa.png',
                    width: 150,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (value) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            filteredPets = pets.where((pet) {
                              final String title = pet['title'].toString().toLowerCase();
                              final String category = pet['category'].toString().toLowerCase();
                              final String gender = pet['gender'].toString().toLowerCase();
                              final String age = pet['age'].toString().toLowerCase();

                              return title.contains(value.toLowerCase()) || category.contains(value.toLowerCase()) || gender.contains(value.toLowerCase()) || age.contains(value.toLowerCase());
                            }).toList();
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Perform your filter logic here
                  //     setState(() {
                  //       // Update filteredPets based on your filter criteria
                  //       // For example, filtering by category "Cats":
                  //       filteredPets = pets.where((pet) {
                  //         final String category = pet['category'].toString().toLowerCase();
                  //         return category == 'cat';
                  //       }).toList();
                  //     });
                  //   },
                  //   child: const Text('Filter'),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // color: Color(0xFFFA3BA61),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pets.length} Pets Found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Itim-Regular',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredPets.length,
                    itemBuilder: (context, index) {
                      final pet = filteredPets[index];
                      return GestureDetector(
                        onTap: () async {
                          try {
                            var response = await _petNotifier.fetchAdoptPet(pet['id']);
                            var navigatorContext = context; // Store the BuildContext in a local variable
                            Navigator.push(
                              navigatorContext,
                              MaterialPageRoute(
                                builder: (BuildContext context) => AdoptPetDetails(petData: response),
                              ),
                            );
                          } catch (error) {
                            print('Failed to fetch pet data: $error');
                          }
                        },
                        child: PetCard(
                          imageUrl: pet['image'],
                          name: pet['title'],
                          category: pet['category'],
                          gender: pet['gender'],
                          age: pet['age'].toString() + " M",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String iconPath;
  final String label;

  const CategoryIcon({
    Key? key,
    required this.iconPath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 80,
          height: 80,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Itim-Regular',
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class PetCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String category;
  final String gender;
  final String age;

  const PetCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.gender,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 217, 221, 225),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: CachedNetworkImage(
              imageUrl: DB_URL_IMAGES + imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 140,
              width: 140,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                Text(
                  age,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim-Regular',
                    fontSize: 18,
                  ),
                ),
                // Text(
                //   price,
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontFamily: 'Itim-Regular',
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim-Regular',
                    fontSize: 16,
                  ),
                ),
                Text(
                  gender,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Itim-Regular',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // Text(
          //   age,
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontFamily: 'Itim-Regular',
          //     fontSize: 14,
          //   ),
          // ),
        ],
      ),
    );
  }
}
