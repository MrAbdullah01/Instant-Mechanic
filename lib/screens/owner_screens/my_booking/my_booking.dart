import 'package:car_mechanics/screens/owner_screens/my_booking/cancel_screen/cancel_screen.dart';
import 'package:car_mechanics/screens/owner_screens/my_booking/pending_screen/pending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "My Orders", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
     body: const Column(
       children: [
         TabBar(
             indicatorSize: TabBarIndicatorSize.tab,
             tabs: [
           Tab(
             text: "Pending",
           ),
           Tab(
             text: "Cancel",
           ),
         ]),
         Expanded(child: TabBarView(
           children: [
             PendingScreen(),
             CancelScreen()
           ],
         ))
       ],
     ),
    )
    );
  }
}