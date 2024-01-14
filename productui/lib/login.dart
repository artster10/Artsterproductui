
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:productui/loading.dart';
import 'package:productui/screens/home/home_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'DeliveryBoy/delivery_home.dart';
import 'signup.dart';




// import 'home_drawer.dart';

void main() {
  runApp(const MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginPage(title: 'Login'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {


  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),


        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: unameController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Username")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _send_data();


                

                },
                child: Text("Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyMySignup(),));
                },
                child: Text("signup"),
              ),

              // TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => SignUpPage()),
              //     );
              //   },
              //   child: Text("Signup"),
              // ),
            ],
          ),
        ),
      ),
    );
  }


  void _send_data() async{


    String uname=unameController.text;
    String password=passController.text;
  


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/and_login_post/');
    try {
      final response = await http.post(urls, body: {
        'textfield':uname,
        'textfield2':password,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String id=jsonDecode(response.body)['lid'].toString();
          String type=jsonDecode(response.body)['type'];
          sh.setString("lid", id);
          if (type=='user'){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Loading(),));

        }
          else if (type=='deliveryboy'){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => deliveryboyHomePage(title: 'Delivery Home',),));

          }



        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

}
