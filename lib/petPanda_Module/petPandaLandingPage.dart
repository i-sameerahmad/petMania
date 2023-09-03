// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_mania/Backend/product.dart';
import 'package:pet_mania/petPanda_Module/addPost.dart';
import 'package:pet_mania/petPanda_Module/pdpPage.dart';
import 'package:pet_mania/utils/appConstants.dart';

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
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: (() {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
        //   }),
        // ),
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> medicineItems = widget.products.where((product) => product['category'] == 'medicine').toList();
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> accessoriesItems = widget.products.where((products) => products['category'] == 'accessory').toList();
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
              var response = _productNotifier.fetchProduct(accessoriesItem['id']);
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> animalFoodItems = widget.products.where((products) => products['category'] == 'food').toList();
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
