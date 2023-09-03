// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pet_mania/Backend/Review/productReview.dart';
import 'package:pet_mania/Providers/cart_provider.dart';
import 'package:pet_mania/models/cart.dart';
import 'package:pet_mania/petPanda_Module/cart.dart';
import 'package:pet_mania/utils/appConstants.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/utils/responsive_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDPPage extends StatefulWidget {
  final Future<List<dynamic>> product; // Updated type

  const PDPPage({Key? key, required this.product}) : super(key: key);

  @override
  State<PDPPage> createState() => _PDPPageState();
}

class _PDPPageState extends State<PDPPage> {
  final ProductReviewNotifier _notifier = ProductReviewNotifier();
  final TextEditingController reviewController = TextEditingController();
  List<dynamic> product = []; // Added variable
  List<dynamic> cartList = [];
  List<dynamic> reviewList = [];
  String userName = "";
  late int userID;

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
      userName = prefs.getString('userName')!;
    });
    // print(user_id);
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    _fetchProductData(); // Fetch doctor data when the screen initializes
    // _fetchProductReviews(product[0]['id']);
  }

  Future<void> _fetchProductData() async {
    try {
      final List<dynamic> data = await widget.product;
      setState(() {
        product = data;
        print(product);
      });
      if (product.isNotEmpty) {
        // Call _fetchProductReviews after setting product list
        _fetchProductReviews(product.isNotEmpty ? product[0]['id'] : null);
      }
    } catch (error) {
      // Handle error
      print('Failed to fetch doctor data: $error');
    }
  }

  Future<void> _fetchProductReviews(int productId) async {
    try {
      List<dynamic> reviews = await _notifier.fetchProductReviews(productId);
      setState(() {
        reviewList = reviews;
        print(reviewList);
      });
    } catch (error) {
      print('Failed to fetch product reviews: $error');
    }
  }

  double rating = 0.0;
  int cartCalue = 0;
  void addToCart() {
    if (cartCalue > 0 && product.isNotEmpty) {
      for (var item in product) {
        final int productId = item['id'];
        final String productName = item['product_name'];
        final double productPrice = item['product_price'];
        final cartProduct = CartProduct(
          productId: productId,
          name: productName,
          price: productPrice,
          quantity: cartCalue,
        );
        Provider.of<CartProvider>(context, listen: false).addToCart(cartProduct);
      }
      cartCalue = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  List messages = [
    'Superfood: Kelp and Turmeric enriched',
    'Omega 3 and Omega 6 for healthy skin.',
    ' 100% Grain-Free (no fillers): corn and soy',
    'Preservatives Free!',
    'No artificial and/or natural coloring',
    'Formulated with DHA',
    'Savory broth adds flavor.'
  ];

  Widget mobile(context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: MyColors.GREEN_LIGHT_SHADE),
          pinned: true,
          expandedHeight: 200,
          backgroundColor: Color(0xfffd9e3be),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Expanded(
                  child: product.isEmpty // Check if the doctor list is empty
                      ? Center(
                          child: CircularProgressIndicator(), // Show a loading indicator
                        )
                      : Center(
                          child: CachedNetworkImage(
                            imageUrl: DB_URL_IMAGES + product[0]['product_image'],
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Padding(
                //     padding: const EdgeInsets.all(20.0),
                //     child: Icon(
                //       Icons.favorite,
                //       size: 30,
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    // child: Icon(
                    //   size: 29,
                    //   Icons.trolley,
                    //   color: Colors.black,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: product.isEmpty // Check if the doctor list is empty
                  ? Center(
                      child: CircularProgressIndicator(), // Show a loading indicator
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                              child: Text(
                                product.isNotEmpty ? product[0]['product_name'] : '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                              child: Text(
                                product.isNotEmpty ? product[0]['product_price'].toString() : '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (cartCalue > 0) {
                                        setState(() {
                                          cartCalue--;
                                        });
                                      }
                                    },
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    cartCalue.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        cartCalue++;
                                      });
                                    },
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.isNotEmpty ? product[0]['product_description'] : '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 15,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontFamily: ' Itim-Regular',
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: (() {}),
                                      child: Container(
                                        decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            Text(
                                              "Product Feature",
                                              style: TextStyle(
                                                fontFamily: 'Itim-Regular',
                                                fontSize: 17,
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: (() {}),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                                    //     height: 50,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(15.0),
                                    //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    //         Text(
                                    //           "Reviews",
                                    //           style: TextStyle(
                                    //             fontFamily: 'Itim-Regular',
                                    //             fontSize: 17,
                                    //           ),
                                    //         ),
                                    //       ]),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              SizedBox(
                                height: 280,
                                child: ListView.builder(
                                    itemCount: messages.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                        child: ListTile(
                                            leading: Icon(
                                              Icons.circle,
                                              color: MyColors.MATERIAL_LIGHT_GREEN,
                                            ),
                                            title: Text(messages[index])),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfffd9e3be),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image.asset('assets/images/image 8.png'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                                  for (var item in product) {
                                    final int productId = item['id'];
                                    final String productName = item['product_name'];
                                    final double productPrice = item['product_price'].toDouble();
                                    final int productQuantity = cartCalue;
                                    // Provide default value
                                    final cartProduct = CartProduct(
                                      productId: productId,
                                      name: productName,
                                      price: productPrice,
                                      quantity: productQuantity,
                                    );

                                    cartProvider.addToCart(cartProduct);
                                  }
                                  if (cartCalue != 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Cart(), // Replace CartPage with your actual cart page
                                      ),
                                    );
                                  }
                                  if (cartCalue == 0) {
                                    final snackBar = SnackBar(
                                      content: Text("Select quantity"),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.MATERIAL_LIGHT_GREEN,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Add to Cart",
                                          style: TextStyle(
                                            fontFamily: 'Itim-Regular',
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Rate this product',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRating) {
                            setState(() {
                              rating = newRating;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: reviewController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Write a review',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            String review = reviewController.text;
                            _notifier.addReview(userID, userName, review, rating, product[0]['id'], context);
                            reviewController.clear(); // Clear the review text field
                            setState(() {
                              rating = 0.0; // Reset the rating
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                          ),
                          child: Text(
                            'Submit Review',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 20.0),

                        // Review list
                        Text(
                          'Product Reviews',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),

                        // ListView.builder to display the reviews
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: reviewList.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                            height: 1.0,
                            thickness: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            final review = reviewList[index];
                            final double reviewRating = double.parse(review['rating'].toString());
                            final String reviewText = review['review'];
                            final String username = review['userName'];
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        username,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 90.0),
                                      RatingBar.builder(
                                        initialRating: reviewRating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (_) {},
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(reviewText),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
