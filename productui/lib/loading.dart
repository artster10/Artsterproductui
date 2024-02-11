import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:productui/screens/nav/nav.dart';
import 'package:productui/screens/view_product/product.dart';
// import 'package:productui/screens/nav/nav.dart';
import 'package:productui/user_home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    // Create an animation with a custom speed
    Animation<double> animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    // Set the speed of the animation
    animation.addListener(() {
      // Do something if needed during animation
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Use Navigator to navigate to the Nav screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Nav(),
          ),
        );
      }
    });

    // Set the speed property to control animation speed
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Lottie.network(
            'https://lottie.host/374a12b1-93d3-4e61-84fd-bc494dafa193/YH3FgeVNPM.json',
            height: 100,
            width: 100,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
