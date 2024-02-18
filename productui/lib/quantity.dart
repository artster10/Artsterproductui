import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'loading.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const MYQuantity(title: 'Flutter Demo Home Page'),
    );
  }
}

class MYQuantity extends StatefulWidget {
  const MYQuantity({super.key, required this.title});

  final String title;

  @override
  State<MYQuantity> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<MYQuantity> {

  TextEditingController QuantityController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: QuantityController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the Quantity"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {

                _send_data();
              }, child: Text('OK')),
            ),
          ],
        ),
      ),
    );
  }
  void _send_data() async{


    String Quantity=QuantityController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String pid = sh.getString('pid').toString();

    final urls = Uri.parse('$url/add_to_cart/');
    try {
      final response = await http.post(urls, body: {
        'quantity':Quantity,
        'lid':lid,
        'pid':pid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sent');

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Loading(),));
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
