import 'dart:convert';

// import 'package:clinicpharma/viewmedicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:productui/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
// import 'package:yogapose_and_zumba/home.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const ViewSession(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewSession extends StatefulWidget {
  const ViewSession({super.key, required this.title});


  final String title;

  @override
  State<ViewSession> createState() => _ViewSessionState();
}

class _ViewSessionState extends State<ViewSession> {

  _ViewSessionState() {
    view_notification();
  }


  List<String> id_ = <String>[];
  List<String> pname_= <String>[];
  List<String> price_= <String>[];
  List<String> video_= <String>[];
  List<String> images_= <String>[];
  List<String> pinfo_= <String>[];




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
      String url = '$urls/and_view_product/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        images.add(sh.getString('img_url').toString()+arr[i]['images']);
        pname.add(arr[i]['pname']);
        pinfo.add(arr[i]['pinfo']);
        video.add(sh.getString("img_url").toString()+arr[i]['video']);
        price.add(arr[i]['price']);


      }

      setState(() {
        id_ = id;
        images_ = images;
        video_ = video;
        pname_ = pname;
        pinfo_ = pinfo;
        price_ = price;



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
          actions: [IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Loading()));
            },
          ),],
          backgroundColor: Color.fromARGB(255, 18, 82, 98),
          foregroundColor: Colors.white,


          title: Text(widget.title),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/'), fit: BoxFit.cover),
          ),
          child: ListView.builder(
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
                        child: FlutterCarousel(
                          options: CarouselOptions(
                            height: 400.0,
                            showIndicator: true,
                            slideIndicator: CircularSlideIndicator(
                              
                            ),
                          ),
                          items: [1,2].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                        
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.amber
                                    ),
                                    child:VideoPlayerWidget(videoUrl: video_[index],),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      Card(

                        elevation: 8,
                        shadowColor: Colors.black,

                        color: Color.fromARGB(255, 18, 82, 98),
                        margin: EdgeInsets.all(10),

                        child:

                        Row(

                            children: [
                              InkWell(
                                  onTap: (){
                                    showDialog(context: context, builder: (context) => Image.network(images_[index]));
                                  },
                                  child: CircleAvatar(radius: 50,backgroundImage: NetworkImage(images_[index]),)),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(pname_[index], textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(pinfo_[index], textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: 100,
                                      child: VideoPlayerWidget(videoUrl: video_[index],),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text('\$ ' + price_[index], textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),),
                                  ),

                                ],
                              ),
                              // ElevatedButton(
                              //   onPressed: () async {
                              //
                              //     final pref =await SharedPreferences.getInstance();
                              //     pref.setString("pid", id_[index]);
                              //
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(builder: (context) => ViewMedicinePage(title: 'Medicines',)),
                              //     // );
                              //
                              //   },
                              //   child: Text("Crops"),
                              // ),
                            ]
                        ),

                        // elevation: 8,
                        // margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isVideoPlaying = false;
      } else {
        _controller.play();
        isVideoPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!isVideoPlaying)
            Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}