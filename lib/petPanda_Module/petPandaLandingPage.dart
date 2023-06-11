// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/Backend/product.dart';
import 'package:pet_paradise/petPanda_Module/addPost.dart';
import 'package:pet_paradise/petPanda_Module/pdpPage.dart';
import 'package:pet_paradise/utils/appConstants.dart';

class PetPandaLanding extends StatefulWidget {
  final List<dynamic> products;

  const PetPandaLanding({super.key, required this.products});

  @override
  State<PetPandaLanding> createState() => _PetPandaLandingState();
}

class _PetPandaLandingState extends State<PetPandaLanding> {
  List<dynamic> products = [];
  // List<dynamic> get doctors => widget.doctors;

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Call the method to fetch doctors when the widget initializes
  }

  ProductNotifier _productNotifier = ProductNotifier();
  Future<void> fetchProducts() async {
    try {
      List<dynamic> fetchProducts = await ProductNotifier().fetchProducts();
      setState(() {
        products = widget.products;
      });
    } catch (error) {
      // Handle the error or display an error message
      print('Failed to fetch doctors: $error');
    }
  }

  TextEditingController searchController = TextEditingController();
  int cartCalue = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPost()));
          }),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Store"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Medicines"),
              ),
              Tab(
                child: Text("Accessories"),
              ),
              Tab(
                child: Text("Food"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Medicines(products: products),
            Accessories(products: products),
            Food(products: products),
          ],
        ),
      ),
    );
  }
}

class Medicines extends StatefulWidget {
  final List<dynamic> products;
  const Medicines({super.key, required this.products});

  @override
  State<Medicines> createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {
  ProductNotifier _productNotifier = ProductNotifier();

  // List<MedicineItem> _medicineItems = [
  //   MedicineItem(
  //     name: 'Paracetamol',
  //     imageUrl:
  //         'https://integratedlaboratories.in/wp-content/uploads/2022/08/Paracetamol-500mg-Tablets-Intemol-500-2.jpeg',
  //     details: 'For fever and pain relief',
  //     price: 2.99,
  //   ),
  //   MedicineItem(
  //     name: 'Ibuprofen',
  //     imageUrl:
  //         'https://images.theconversation.com/files/321639/original/file-20200319-22610-18gca3.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
  //     details: 'For fever and pain relief',
  //     price: 3.49,
  //   ),
  //   MedicineItem(
  //     name: 'Aspirin',
  //     imageUrl:
  //         'https://www.aspirin.ca/sites/g/files/vrxlpx30151/files/2021-06/Aspirin-81mg-tablets-30ct-carton_3.png?imwidth=5000',
  //     details: 'For fever and pain relief',
  //     price: 2.99,
  //   ),
  //   MedicineItem(
  //     name: 'Antacid',
  //     imageUrl: 'https://images.heb.com/is/image/HEBGrocery/000965585',
  //     details: 'For heartburn relief',
  //     price: 4.99,
  //   ),
  //   MedicineItem(
  //     name: 'Antihistamine',
  //     imageUrl:
  //         'https://cdn2.momjunction.com/wp-content/uploads/2021/08/Antihistamine-For-Kids-Uses-Safety-Types-And-Side-Effects-2-910x1024.jpg',
  //     details: 'For allergy relief',
  //     price: 5.99,
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> medicineItems = widget.products
        .where((product) => product['category'] == 'medicine')
        .toList();
    print(medicineItems);
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 0.8,
      children: medicineItems.map((medicineItem) {
        return GestureDetector(
          onTap: () async {
            try {
              // Make the HTTP request to fetch the doctor data using the doc_id
              // dynamic doctor = doctors[index];
              var response = _productNotifier.fetchProduct(medicineItem['id']);

              // Navigate to the VatDetailScreen and pass the doctor data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDPPage(product: response),
                ),
              );
            } catch (error) {
              // Handle the error or display an error message
              print('Failed to fetch doctor data: $error');
            }
          },
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: DB_URL_IMAGES + medicineItem['product_image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    medicineItem['product_name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    medicineItem['product_description'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    medicineItem['product_price'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Accessories extends StatefulWidget {
  final List<dynamic> products;

  const Accessories({super.key, required this.products});

  @override
  State<Accessories> createState() => _AccessoriesState();
}

class _AccessoriesState extends State<Accessories> {
  ProductNotifier _productNotifier = ProductNotifier();

  // final List<AccessoriesItem> accessoriesItems = [
  //   AccessoriesItem(
  //     name: 'Wireless Headphones',
  //     price: 99.99,
  //     image:
  //         'https://i0.wp.com/smartshoppers.pk/wp-content/uploads/2021/10/beats-by-dr-dre-solo-3-wireless-matte-black-headphone-zone-13978312540223-600x-600x600-1.webp',
  //     detail: 'Bluetooth headphones with noise cancellation',
  //   ),
  //   AccessoriesItem(
  //     name: 'Smartwatch',
  //     price: 149.99,
  //     image:
  //         'https://images.priceoye.pk/haylou-gs-smart-watch-pakistan-priceoye-hktih.jpg',
  //     detail: 'Fitness tracker with heart rate monitor and GPS',
  //   ),
  //   AccessoriesItem(
  //     name: 'Wireless Charger',
  //     price: 29.99,
  //     image:
  //         'https://www.tejar.pk/media/catalog/product/cache/3/image/9df78eab33525d08d6e5fb8d27136e95/a/n/anker_wireless_charger_with_usb-c_15w_metal_fast_wireless_charging_pad_-_1tejar.jpg',
  //     detail: 'Fast charging pad for Qi-enabled devices',
  //   ),
  //   AccessoriesItem(
  //     name: 'Power Bank',
  //     price: 49.99,
  //     image:
  //         'https://images.priceoye.pk/aukey-pb-n83s-power-bank-10000mah-pakistan-priceoye-cbgql.jpg',
  //     detail: 'Portable charger with 10000mAh battery',
  //   ),
  //   AccessoriesItem(
  //     name: 'Bluetooth Speaker',
  //     price: 79.99,
  //     image: 'https://m.media-amazon.com/images/I/91HnLmz7bsL._AC_SL1500_.jpg',
  //     detail: 'Waterproof speaker with 360-degree sound',
  //   ),
  //   AccessoriesItem(
  //     name: 'Phone Case',
  //     price: 19.99,
  //     image:
  //         'https://images.squarespace-cdn.com/content/v1/5b56aa1da2772c2408dab0e6/1670814536223-9VXI0HLQH4Z8S381Q0Q2/theo-snap-phone-case-by-talia-designs.jpg',
  //     detail: 'Protective case with shock-absorbing technology',
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> accessoriesItems = widget.products
        .where((products) => products['category'] == 'accessory')
        .toList();
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 0.8,
      children: accessoriesItems.map((accessoriesItem) {
        return GestureDetector(
          onTap: () async {
            try {
              // Make the HTTP request to fetch the doctor data using the doc_id
              // dynamic doctor = doctors[index];
              var response =
                  _productNotifier.fetchProduct(accessoriesItem['id']);
              // Navigate to the VatDetailScreen and pass the doctor data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDPPage(product: response),
                ),
              );
            } catch (error) {
              // Handle the error or display an error message
              print('Failed to fetch doctor data: $error');
            }
          },
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: DB_URL_IMAGES + accessoriesItem['product_image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    accessoriesItem['product_name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    accessoriesItem['product_description'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    accessoriesItem['product_price'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Food extends StatefulWidget {
  final List<dynamic> products;

  const Food({super.key, required this.products});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  ProductNotifier _productNotifier = ProductNotifier();

  // List<FoodItem> animalFoodItems = [
  //   FoodItem(
  //     name: 'Dog Food',
  //     price: 29.99,
  //     imageUrl:
  //         'https://static-01.daraz.pk/p/c59e1958461ceeff37645fed1bb1ff78.jpg_720x720.jpg_.webp',
  //     detail: 'Complete and balanced nutrition for adult dogs.',
  //   ),
  //   FoodItem(
  //     name: 'Cat Food',
  //     price: 24.99,
  //     imageUrl:
  //         'https://static.tossdown.com/images/50231075fccc23b19da342bf3fc55cbd.jpeg',
  //     detail: 'High-quality protein and essential nutrients for cats.',
  //   ),
  //   FoodItem(
  //     name: 'Fish Food',
  //     price: 9.99,
  //     imageUrl:
  //         'https://static.tossdown.com/images/50231075fccc23b19da342bf3fc55cbd.jpeg',
  //     detail:
  //         'Specially formulated for healthy growth and vibrant colors in fish.',
  //   ),
  //   // Add more food items here...
  // ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> animalFoodItems = widget.products
        .where((products) => products['category'] == 'food')
        .toList();
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 0.8,
      children: animalFoodItems.map((foodItems) {
        return GestureDetector(
          onTap: () async {
            try {
              // Make the HTTP request to fetch the doctor data using the doc_id
              // dynamic doctor = doctors[index];
              var response = _productNotifier.fetchProduct(foodItems['id']);
              // Navigate to the VatDetailScreen and pass the doctor data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDPPage(product: response),
                ),
              );
            } catch (error) {
              // Handle the error or display an error message
              print('Failed to fetch doctor data: $error');
            }
          },
          child: Card(
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: DB_URL_IMAGES + foodItems['product_image'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    foodItems['product_name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    foodItems['product_description'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    foodItems['product_price'].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// class MedicineItem {
//   final String name;
//   final String imageUrl;
//   final String details;
//   final double price;

//   MedicineItem({
//     required this.name,
//     required this.imageUrl,
//     required this.details,
//     required this.price,
//   });
// }

// class AccessoriesItem {
//   final String name;
//   final double price;
//   final String image;
//   final String detail;

//   AccessoriesItem({
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.detail,
//   });
// }

// class FoodItem {
//   final String name;
//   final double price;
//   final String imageUrl;
//   final String detail;

//   FoodItem(
//       {required this.name,
//       required this.price,
//       required this.imageUrl,
//       required this.detail});
// }
