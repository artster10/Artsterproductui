import 'dart:convert';

// import 'package:clinicpharma/viewschedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewWork(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewWork extends StatefulWidget {
  const ViewWork({super.key, required this.title});

  final String title;

  @override
  State<ViewWork> createState() => _ViewWorkState();
}

class _ViewWorkState extends State<ViewWork> {
  _ViewWorkState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> pname_ = <String>[];
  List<String> pinfo_ = <String>[];
  List<String> price_ = <String>[];
  List<String> images_ = <String>[];
  List<String> video_ = <String>[];


  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> pname = <String>[];
    List<String> pinfo = <String>[];
    List<String> price = <String>[];
    List<String> images = <String>[];
    List<String> video = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/and_view_product/';

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        pname.add(arr[i]['pname']);
        pinfo.add(arr[i]['pinfo']);
        price.add(arr[i]['price']);
        images.add(urls + arr[i]['photo']);
        video.add(urls + arr[i]['video']);
      }

      setState(() {
        id_ = id;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.primary,

          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child: Row(children: [
                          CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(images_[index])),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Product name'),
                                    Text(pname_[index]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Product info'),
                                    Text(pinfo_[index]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price'),
                                    Text(price_[index]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                  ],
                                ),
                              ),
                            ],
                          ),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //
                          //     final pref =await SharedPreferences.getInstance();
                          //     pref.setString("did", id_[index]);
                          //
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => ViewSchedule()),
                          //     );
                          //
                          //
                          //
                          //
                          //   },
                          //   child: Text("Schedule"),
                          // ),
                        ]),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
