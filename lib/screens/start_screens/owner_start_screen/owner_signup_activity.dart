import 'package:car_mechanics/utils/toast_msg.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../../../helpers/colors.dart';
import '../../../helpers/helper_text.dart';
import '../../../helpers/input_fields.dart';
import '../../../helpers/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter/cupertino.dart';

import 'owner_start_provider/owner_start_provider.dart';

class OwnerSignUp extends StatelessWidget {
  OwnerSignUp({super.key});
  var nameC = TextEditingController();
  var passwordC = TextEditingController();
  var confirmPasswordC = TextEditingController();
  var emailC = TextEditingController();
  var phoneC = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<OwnerStartProvider>(builder: (context,value,child){
      return value.isLoading == true ? Center(
          child: SizedBox(height :50,width: 50 ,child: CircularProgressIndicator(color: appColor,)))
          : Container(
        margin: EdgeInsets.only(right: 20,left: 20,top: 30),
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: TextWidget1(text: "Create Account", fontSize: 18.dp, fontWeight: FontWeight.bold, isTextCenter: true, textColor: appColor)),
                SizedBox(height: 20,),
                InputField(inputController: nameC,prefixIcon: Icon(CupertinoIcons.person_crop_circle_fill),hintText: "Name",),
                SizedBox(height: 20,),
                InputField(inputController: phoneC,prefixIcon: Icon(CupertinoIcons.phone_fill),hintText: "Phone Number",type: TextInputType.number,),
                SizedBox(height: 20,),
                InputField(inputController: emailC,prefixIcon: Icon(CupertinoIcons.mail_solid),hintText: "Email",type: TextInputType.emailAddress,),
                SizedBox(height: 20,),
                InputField(inputController: passwordC,prefixIcon: Icon(Icons.lock),hintText: "Password",obscureText: true,),
                SizedBox(height: 20,),
                InputField(inputController: confirmPasswordC,prefixIcon: Icon(Icons.lock),hintText: "Confirm Password",obscureText: true,),
                SizedBox(height: 30,),
                SubmitButton(title: "Create Account", press: (){
                  FocusScope.of(context).unfocus();
                  if(formKey.currentState!.validate()){
                    if(confirmPasswordC.text.toString() == passwordC.text.toString()){
                      value.signup(emailC.text.toString(), nameC.text.toString(), phoneC.text.toString(),passwordC.text.toString());
                    }else{
                      ToastMsg().toastMsg("Incorrect Confirm Password!");
                    }
                  }
                })
              ],
            ),
          ),
        ),
      );
    });
  }
}
