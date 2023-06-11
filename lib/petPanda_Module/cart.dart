import 'package:flutter/material.dart';
import 'package:pet_paradise/Providers/cart_provider.dart';
import 'package:pet_paradise/petPanda_Module/cartConfirmation.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    print(cartList);
    int calculateSubTotal() {
      int total = 0;
      if (cartList != null) {
        for (var item in cartList) {
          total += (item.price * item.quantity).toInt();
        }
      }
      return total;
    }

    int calculateTotal() {
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
            Text(
              "Cart",
              style: TextStyle(
                fontFamily: 'Itim-Regular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Divider(
              color: Colors.black,
              thickness: 3,
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final cartProduct = cartList[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.remove),
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
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "PKR ${calculateSubTotal()}",
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
                  Text(
                    "Total",
                    style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "PKR ${calculateTotal()}",
                    style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartConfirmation(),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.GREEN,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
