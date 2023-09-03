import 'package:flutter/material.dart';
import 'package:pet_mania/Backend/order.dart';
import 'package:pet_mania/Providers/cart_provider.dart';
import 'package:pet_mania/petPanda_Module/cartConfirmation.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final OrderNotifier _orderNotifier = OrderNotifier();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _paymentMethod = 'Cash on Delivery';

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    List<int> productIds = [];
    List<int> quantities = [];
    late int userId;

    int calculateSubTotal() {
      int total = 0;
      for (var item in cartList) {
        total += (item.price * item.quantity).toInt();
      }
      return total;
    }

    void handleCheckout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userID')!;
      // Use the userId as needed
      print(userId);

      for (var item in cartList) {
        productIds.add(item.productId);
        quantities.add(item.quantity);
      }
    }

    int calculateTotal() {
      handleCheckout();
      return calculateSubTotal() + 50; // Adding shipping cost of 50 PKR
    }

    void _submitForm() {
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();

        // Perform checkout and send the form values
        _orderNotifier.handleCheckout(
          productIds,
          quantities,
          userId,
          calculateTotal(),
          name: _nameController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          paymentMethod: _paymentMethod,
        );

        // Navigate to confirmation page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CartConfirmation(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cart",
                style: TextStyle(
                  fontFamily: 'Itim-Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.black,
                thickness: 3,
              ),
              const SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final cartProduct = cartList[index];
                  return ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        // Handle remove item from cart
                        cartProvider.removeFromCart(cartProduct);
                      },
                    ),
                    title: Row(
                      children: [
                        Text(cartProduct.name),
                        const Spacer(),
                        Text('x${cartProduct.quantity.toString()}'),
                      ],
                    ),
                    subtitle: Text(cartProduct.price.toString()),
                  );
                },
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sub Total",
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "PKR ${calculateSubTotal()}",
                      style: const TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping",
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "PKR 50",
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "PKR ${calculateTotal()}",
                      style: const TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Address",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Cash on Delivery',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value.toString();
                              });
                            },
                          ),
                          const Text('Cash on Delivery'),
                          const SizedBox(width: 10),
                          Radio(
                            value: 'Easy Paisa',
                            groupValue: _paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                _paymentMethod = value.toString();
                              });
                            },
                          ),
                          const Text('Easy Paisa'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Phone",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          final phoneRegex = r'^\d{11}$';
                          final isValidPhone = RegExp(phoneRegex).hasMatch(value);
                          if (!isValidPhone) {
                            return 'Invalid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Invalid email format';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: _submitForm,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: MyColors.MATERIAL_LIGHT_GREEN,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: 50,
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                "CheckOut",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Itim-Regular',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
