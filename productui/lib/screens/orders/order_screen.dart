import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/screens/orders/widgets/order_item.dart';
import 'package:productui/screens/orders/widgets/order_screen_background.dart';
// import 'package:productui/screens/nav/nav.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () => Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => Nav(),
        //       ),
        //     ),
        //     icon: SvgPicture.asset('assets/icons/button_back.svg'),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Orders',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30.0),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    OrderItem(
                      name: 'Product name',
                      orderStatus: 'On The Way',
                      price: '\$244',
                    ),
                    OrderItem(
                      name: 'Product name',
                      orderStatus: 'On The Way',
                      price: '\$244',
                    ),
                    OrderItem(
                      name: 'Product name',
                      orderStatus: 'Deliverd',
                      price: '\$244',
                    ),
                    OrderItem(
                      name: 'Productersddsdxssdadfdfdfsefes name11111',
                      orderStatus: 'Canceled',
                      price: '\$244',
                    ),
                    OrderItem(
                      name: 'Product name',
                      orderStatus: 'Deliverd',
                      price: '\$244',
                    ),
                    OrderItem(
                      name: 'Product name',
                      orderStatus: 'Deliverd',
                      price: '\$244',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
