import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productui/DeliveryBoy/view_assigned_work.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/screens/orders/widgets/order_item.dart';
import 'package:productui/screens/orders/widgets/order_screen_background.dart';
import 'package:productui/screens/view_product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config/colors.dart';
// import 'package:productui/screens/nav/nav.dart';

class MoreDetails extends StatefulWidget {
  const MoreDetails({super.key});

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_complaints();
  }
  List<String> id_=[];
  List<String> pname_=[];
  List<String> orderid_=[];

  List<String> date_=[];
  List<String> quantity_=[];
  List<String> img_=[];
  List<String> price_=[];




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
                builder: (context) => AssignedWork(),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/button_back.svg'),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              // padding: EdgeInsets.all(5.0),
              shrinkWrap: true,
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
                          // Container(
                          //
                          //   height: 100,
                          //   padding: const EdgeInsets.all(14.0),
                          //   width: size.width / 4,
                          //   margin: EdgeInsets.only(right: 15),
                          //   decoration: BoxDecoration(
                          //     // color: Colors.red,
                          //     borderRadius: BorderRadius.circular(20.0),
                          //     image: DecorationImage(
                          //       image: NetworkImage(img_[index]),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 140,

                            margin: EdgeInsets.only(bottom: 16.0),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: kWhite.withOpacity(0.70),
                            ),
                            child:

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                  date_[index],
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: kBlack, fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [




                                    Text(
                                      pname_[index],
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: kBlack, fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),




                                  


                                  ],
                                ),





                                Row(

                                  children: [
                                    Text(
                                      quantity_[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: kBlack),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              price_[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(color: kBlack),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),


                                    ],
                                  ))])));
              },
            ),





          ),

        ),
      ),
    );


  }

  void view_complaints() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> pname = <String>[];
    List<String> price = <String>[];
    List<String> orderid = <String>[];

    // List<String> img = <String>[];
    List<String> quantity = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/more_assigned/';
      String pid = sh.getString("pid").toString();
      String img_url = sh.getString("img_url").toString();
      var data = await http.post(Uri.parse(url), body: {
        "pid": pid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        orderid.add(arr[i]['orderid'].toString());

        date.add(arr[i]['date'].toString());
        pname.add(arr[i]['fname'].toString());
        price.add(arr[i]['sname'].toString());
        quantity.add(arr[i]['quantity'].toString());
        // img.add(img_url+arr[i]['img'].toString());


      }

      setState(() {
        id_ = id;
        date_ = date;
        pname_ = pname;
        quantity_ = quantity;
        price_ = price;
        orderid_ = orderid;



      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
}
