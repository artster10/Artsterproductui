//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:productui/screens/orders/widgets/order_screen_background.dart';
// import 'package:productui/screens/view_product/product.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import '../config/colors.dart';
// // import '../screens/nav/nav.dart';
//
// class ProductInfo extends StatefulWidget {
//   const ProductInfo({super.key});
//
//
//
//
//   @override
//   State<ProductInfo> createState() => _ProductInfoState();
//
// }
//
// class _ProductInfoState extends State<ProductInfo> {
//
//   _ProductInfoState(){
//     _send_data();
//
// }
//   String pname_ = "";
//   String pinfo_ = "";
//   String price_ = "";
//   String pimage_ = "";
//   String pvideo_ = "";
//   // String password_ = "";
//   // String confirmpassword_ = "";
//
//   void _send_data() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     // String lid = sh.getString('lid').toString();
//     String pid = sh.getString('pid').toString();
//     String img_url = sh.getString('img_url').toString();
//
//     final urls = Uri.parse('$url/view_product_info/');
//     try {
//       final response = await http.post(urls, body: {
//         // 'lid': lid,
//         'pid': pid,
//
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String pname = jsonDecode(response.body)['pname'];
//           String pinfo = jsonDecode(response.body)['pinfo'];
//           String price = jsonDecode(response.body)['price'];
//           String pimage = img_url+jsonDecode(response.body)['pimage'];
//           String pvideo = jsonDecode(response.body)['pvideo'];
//
//
//           setState(() {
//             pname_ = pname;
//             pinfo_ = pinfo;
//             price_ = price;
//             pimage_ = pimage;
//             pvideo_ = pvideo;
//
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//
//
//   // Future<void> view_notification() async {
//   //     SharedPreferences sh = await SharedPreferences.getInstance();
//   //     String urls = sh.getString('url').toString();
//   //     String img_url = sh.getString('img_url').toString();
//   //     String imgs = img_url+sh.getString('img').toString();
//   //     String name = sh.getString('name').toString();
//   //     String description = sh.getString('description').toString();
//   //     String price = sh.getString('price').toString();
//   //     String video = img_url+sh.getString('video').toString();
//   //
//   //
//   //
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return OrderBackground(child:
//     Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 2.0),
//           child: Text(
//             'Product Details',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge!
//                 .copyWith(fontWeight: FontWeight.w700),
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProductPage(),
//             ),
//           ),
//           icon: SvgPicture.asset(pimage_),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ListView.builder(
//               // itemCount: id_.length,
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 24.0,
//                     vertical: 32.0,
//                   ),
//                   padding: const EdgeInsets.all(14.0),
//                   height: size.height * 0.40,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     // color: Colors.red,
//                     borderRadius: BorderRadius.circular(20.0),
//                     image: DecorationImage(
//                       image: NetworkImage(pimage_[index]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           pname_,
//                           style: Theme.of(context)
//                               .textTheme
//                               .displaySmall!
//                               .copyWith(fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                       child: Align(
//                         alignment: Alignment.topRight,
//                         child: Text(
//                           '\$'+price_,
//                           style: Theme.of(context)
//                               .textTheme
//                               .displaySmall!
//                               .copyWith(fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   pinfo_,
//                   style: Theme.of(context)
//                       .textTheme
//                       .labelLarge!
//                       .copyWith(fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         width: double.infinity,
//         alignment: Alignment.topCenter,
//         padding: EdgeInsets.only(top: 19.0),
//         decoration: BoxDecoration(
//             color: Colors.greenAccent,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0),
//               topRight: Radius.circular(20.0),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 15.0,
//                 offset: const Offset(0, 4),
//                 color: kBlack.withOpacity(0.15),
//               )
//             ]),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//         ),
//       ),
//     ),);
//   }
// }
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/loading.dart';
import 'package:productui/quantity.dart';
import 'package:productui/screens/nav/nav.dart';
import 'package:productui/screens/orders/widgets/order_screen_background.dart';
import 'package:productui/screens/view_product/product.dart';
import 'package:productui/singlequantity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import '../config/colors.dart';
import '../payment.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  String id_ = "";
  String pname_ = "";
  String pinfo_ = "";
  String price_ = "";
  String pimage_ = "";
  String pvideo_ = "";

  @override
  void initState() {
    super.initState();
    _send_data();
  }

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String pid = sh.getString('pid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/view_product_info/');
    try {
      final response = await http.post(urls, body: {
        'pid': pid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String id = jsonDecode(response.body)['id'].toString();
          String pname = jsonDecode(response.body)['pname'];
          String pinfo = jsonDecode(response.body)['pinfo'];
          String price = jsonDecode(response.body)['price'];
          String pimage = img_url + jsonDecode(response.body)['pimage'];
          // video.add(sh.getString("img_url").toString()+arr[i]['video']);
          String pvideo = img_url + jsonDecode(response.body)['pvideo'];

          setState(() {
            id_ = id;
            pname_ = pname;
            pinfo_ = pinfo;
            price_ = price;
            pimage_ = pimage;
            pvideo_ = pvideo;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OrderBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              'Product Details',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Nav(),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/button_back.svg'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32.0,
                    ),
                    padding: const EdgeInsets.all(14.0),
                    height: size.height * 0.40,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage(pimage_),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: VideoPlayerWidget(videoUrl: pvideo_),
                  ),
                ],
                options: CarouselOptions(
                  height: size.height * 0.40,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              pname_,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '\$' + price_,
                            maxLines: 3,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    pinfo_,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          width: double.infinity,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 19.0),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 15.0,
                offset: const Offset(0, 4),
                color: kBlack.withOpacity(0.15),
              )
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MYQuantity(title: '')));
                      },
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sh =
                            await SharedPreferences.getInstance();
                        sh.setString("pid", id_).toString();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MYsingleQuantity(
                                      title: '',
                                    )));
                      },
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        color: Colors.teal[300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
          ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller)))),
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
