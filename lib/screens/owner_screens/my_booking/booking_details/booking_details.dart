import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../../../../helpers/colors.dart';
import '../../../../helpers/helper_text.dart';
import 'custom_container.dart';

class BookingDetails extends StatelessWidget {
  BookingDetails({super.key,required this.name,required this.bookingId,required this.phone,
  required this.msg,required this.date,required this.time
  });

  String bookingId;
  String name;
  String phone;
  String msg;
  String date;
  String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appColor,
        title: TextWidget(text: "Booking Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(child: TextWidget(text: "Order Response", fontSize: 24.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 30),
              color: appBarTextColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer().statusContainer("Pending"),
                  CustomContainer().statusContainer("Cancel"),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: appBarTextColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  TextWidget(text: "Booking Details", fontSize: 16.dp, fontWeight: FontWeight.bold, isTextCenter: false, textColor: appColor),
                  CustomContainer().bookingContainer(bookingId),
                  CustomContainer().bookingContainer(name),
                  CustomContainer().bookingContainer(phone),
                  CustomContainer().bookingContainer(msg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer().bookingContainer(date,width: 42.w),
                      CustomContainer().bookingContainer(time,width: 42.w),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
