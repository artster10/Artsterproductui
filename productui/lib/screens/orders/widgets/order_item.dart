import 'package:flutter/material.dart';
import 'package:productui/config/colors.dart';
// import 'package:productui/screens/widgets/profile_image.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {super.key,
      required this.name,
      required this.orderStatus,
      required this.price});
  final String name;
  final String orderStatus;
  final String price;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 130,
          margin: EdgeInsets.only(bottom: 16.0),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kWhite.withOpacity(0.70),
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(14.0),
                width: size.width / 4,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage('assets/images/building-1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: kBlack),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: kBlack),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        orderStatus,
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
        )
      ],
    );
  }
}
