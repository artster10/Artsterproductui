import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/config/colors.dart';
// import 'package:productui/screens/home/home_screen.dart';
import 'package:productui/screens/orders/order_screen.dart';
import 'package:productui/screens/product_videos/Product_videos.dart';
// import 'package:productui/screens/profile/profile_screen.dart';
import 'package:productui/screens/widgets/custom_button.dart';
import 'package:productui/search_artist.dart';
import 'package:productui/user%20view%20artist.dart';
// import 'package:productui/screens/message/message_screen.dart';

import '../../purchase_history.dart';
import '../user_profile/userprofilenew.dart';
import '../view_product/product.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final _pages = [
    ProductPage(),
    OrderScreen(),
    PurchaseHistory(),
    UserProfile()
  ];

  void _changePageto(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _selectedIndex == 1
          ? null
          : CustomButton(
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.greenAccent,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchArtist()));
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : Container(
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
                children: [
                  GestureDetector(
                    onTap: () => _changePageto(0),
                    child: SvgPicture.asset(
                      'assets/icons/home.svg',
                      color: _selectedIndex == 0 ? kSelectedTabColor : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changePageto(1),
                    child: SvgPicture.asset(
                      'assets/icons/cart (1).svg',
                      height: 28,
                      width: 28,
                      color: _selectedIndex == 1 ? kSelectedTabColor : null,
                    ),
                  ),
                  const SizedBox(),
                  GestureDetector(
                    onTap: () => _changePageto(2),
                    child: SvgPicture.asset(
                      'assets/icons/cart-svgrepo-com (1).svg',
                      height: 24,
                      width: 24,
                      color: _selectedIndex == 2 ? kSelectedTabColor : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changePageto(3),
                    child: SvgPicture.asset(
                      'assets/icons/profile.svg',
                      color: _selectedIndex == 3 ? kSelectedTabColor : null,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
