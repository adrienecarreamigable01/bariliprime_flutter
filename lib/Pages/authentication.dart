import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:barili_prime/mywidgets/rounded_input.dart';
import 'package:barili_prime/mywidgets/raised_button.dart';
import 'package:barili_prime/constant/httphelper.dart';
import 'package:barili_prime/constant/api-links.dart';
import 'package:barili_prime/mywidgets/my_alert_message.dart';
import 'package:barili_prime/network_helper/http_borrower.dart';

import 'dart:convert';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  var http = HttpHelper();
  var alert = PopupDialog();

  dynamic userName = 'adriene.amigable';
  dynamic password = 'Thequick123';

  var httpRequest = HttpBorrower();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Barili Prime Lending Corp."),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10.0,),
              RoundedInput(
                hintText: "Enter username",
                keyboardType: TextInputType.emailAddress,
                initialValue: 'adriene.amigable',
                functionChange: (uName){
                  userName = uName;
                },
              ),
              SizedBox(height: 10.0,),
              RoundedInput(
                isObscureText: true,
                hintText: "Enter password",
                initialValue: 'Thequick123',
                functionChange: (uPassword){
                  password = uPassword;
                },
              ),
              MyRaisedButton(
                buttonText:"Sign in",
                buttonColor: Colors.blueAccent,
                onPress: () async {
                  var payload = {
                    'username':userName,
                    'password':password
                  };
                  print(payload);
                  var response = await http.post(url: kAuth,payload: payload);
                  
                  if(response['isError'] == false){
                    var data = response['data'][0];
                    String lastName = data['lastname'];
                    String firstName = data['firstname'];
                    String middleName = data['middlename'];
                    Navigator.pushNamed(context, "dashboard");
                  }else{
                     alert.onAlertWithStylePressed(context: context,title: "Error",description: response['message'],buttonText: "Ok",isError:response['isError']);
                  }
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}



