import 'package:flutter/material.dart';
import 'package:pet_mania/Backend/booking.dart';
import 'package:pet_mania/vet_module/bookingconf.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> petData;
  final int userId;

  const BookingPage({Key? key, required this.petData, required this.userId}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final BookingNotifier _bookingNotifier = BookingNotifier();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _paymentMethod = 'Cash on Delivery';
  int _totalPrice = 0;
  int shipping = 100;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with booking
      // Access the form field values
      final String name = _nameController.text;
      final String email = _emailController.text;
      final String phone = _phoneController.text;
      final String address = _addressController.text;

      // Construct the booking data
      final Map<String, dynamic> bookingData = {
        'petData': widget.petData,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'paymentMethod': _paymentMethod,
        'totalPrice': _totalPrice,
      };
      _bookingNotifier.booking(context, widget.petData['id'], widget.userId, widget.petData['vpet_price'] + shipping, name, address, phone, email, _paymentMethod);
      // You can now use the bookingData as needed, for example, send it to an API or perform further actions

      // Print the booking details for demonstration
      print('Booking Details:');
      print('Pet Data: ${bookingData['petData']}');
      print('Name: ${bookingData['name']}');
      print('Email: ${bookingData['email']}');
      print('Phone: ${bookingData['phone']}');
      print('Address: ${bookingData['address']}');
      print('Payment Method: ${bookingData['paymentMethod']}');
      print('Total Price: ${bookingData['totalPrice']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pet Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Name: ${widget.petData['vpet_name']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Price: PKR ${widget.petData['vpet_price']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Shipping Charges: PKR ${shipping}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Total Price: PKR ${widget.petData['vpet_price'] + shipping}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Invalid email format';
                    }
                    // You can add more specific email validation if needed
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
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
                SizedBox(height: 8),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Cash on Delivery',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                    ),
                    Text('Cash on Delivery'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'EasyPaisa',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                    ),
                    Text('EasyPaisa'),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitBooking,
                  child: Text('Submit Booking'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
