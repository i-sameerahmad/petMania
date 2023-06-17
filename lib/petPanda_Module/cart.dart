import 'package:flutter/material.dart';
import 'package:pet_paradise/Backend/order.dart';
import 'package:pet_paradise/Providers/cart_provider.dart';
import 'package:pet_paradise/petPanda_Module/cartConfirmation.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatelessWidget {
  final OrderNotifier _orderNotifier = OrderNotifier();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    List<int> productIds = [];
    List<int> quantities = [];
    late int userId;
    int calculateSubTotal() {
      int total = 0;
      if (cartList != null) {
        for (var item in cartList) {
          total += (item.price * item.quantity).toInt();
        }
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
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
            Expanded(
              child: ListView.builder(
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
                    title: Text(cartProduct.name),
                    subtitle: Text(cartProduct.price.toString()),
                  );
                },
              ),
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
            InkWell(
              onTap: () {
                _orderNotifier.handleCheckout(
                    productIds, quantities, userId, calculateTotal());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CartConfirmation(),
                ));
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: MyColors.GREEN,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 50,
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "CheckOut",
                        textAlign: TextAlign.center,
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
          ],
        ),
      ),
    );
  }
}
