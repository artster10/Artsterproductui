import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/config/colors.dart';
import 'package:productui/screens/widgets/custom_button.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  final _pages = [
    Center(
      child: Container(
        child: Text('Home'),
      ),
    ),
    Text('Message'),
    Text('Fav list'),
    Text('Profile')
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
      floatingActionButton: CustomButton(
        child: SvgPicture.asset('assets/icons/plus.svg'),
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                'assets/icons/message.svg',
                color: _selectedIndex == 1 ? kSelectedTabColor : null,
              ),
            ),
            const SizedBox(),
            GestureDetector(
              onTap: () => _changePageto(2),
              child: SvgPicture.asset(
                'assets/icons/favorite_border.svg',
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
