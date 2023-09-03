import 'package:flutter/material.dart';
import 'package:pet_mania/pages/appointments.dart';

import '../components/styles.dart';

class BookingConfirmModal extends StatefulWidget {
  static const String id = 'BookingConfirmModal';

  const BookingConfirmModal({Key? key}) : super(key: key);

  @override
  _BookingConfirmModalState createState() => _BookingConfirmModalState();
}

class _BookingConfirmModalState extends State<BookingConfirmModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Container(
            color: appColor,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 52),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, size: 140, color: Colors.white),
                Column(
                  children: [
                    const Text('Your appointment \n has been booked', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'bold')),
                    const SizedBox(height: 16),
                    const Text('Reamae Velasko will be waiting \n for you and your pet', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 40),
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.access_time, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('Wed 9 Sep at 10:00', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ]),
                    ),
                    const SizedBox(height: 8),
                    const Text('+ Add appointment to calender', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      padding: const EdgeInsets.all(14),
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Appointments()));
                    },
                    child: const Text("Go to my appointments", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
