
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productui/screens/orders/widgets/order_screen_background.dart';
import 'package:productui/screens/view_product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/colors.dart';
import '../screens/nav/nav.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  _ProductInfoState(){
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
    Size size = MediaQuery.of(context).size;

    return OrderBackground(child:
    Scaffold(
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
              builder: (context) => ProductPage(),
            ),
          ),
          icon: SvgPicture.asset('assets/icons/button_back.svg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: id_.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  padding: const EdgeInsets.all(14.0),
                  height: size.height * 0.40,
                  width: size.width,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(images_[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          ,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '\$500',
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
                  'Product Name In this example, the Spacer() widget will take up all the available space between the red and blue containers, ensuring that the blue and green containers are pushed to the right, and the space is distributed accordingly. ',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
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
            color: Colors.greenAccent,
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
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    ),);
  }
}
