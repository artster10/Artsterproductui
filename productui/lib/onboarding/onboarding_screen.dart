import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/config/colors.dart';
import 'package:productui/onboarding/widgets/background.dart';
import 'dart:math' as math;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _pageIndex = 0;

  _onPageChanged(index) => setState(() {
        _pageIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Artster $index',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 57.0),
                        Image.asset('assets/images/hero.png'),
                      ],
                    );
                  },
                  onPageChanged: _onPageChanged,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => Container(
                        height: 12.0,
                        width: 12.0,
                        margin: const EdgeInsets.symmetric(horizontal: 3.5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _pageIndex == index ? kBlack : null,
                            border: Border.all(width: 1.0, color: kBlack)),
                      )),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Positioned(
                    bottom: -50,
                    right: -50,
                    child: Transform.rotate(
                      angle: math.pi / 4,
                      child: Container(
                        height: size.width * 0.7,
                        width: size.width * 0.68,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: kBlack),
                          borderRadius: BorderRadius.circular(87.0),
                        ),
                        child: Container(
                          height: size.width * 0.65,
                          width: size.width * 0.62,
                          decoration: BoxDecoration(
                            color:
                                _pageIndex.isEven ? kBlack : k2MainThemeColor,
                            borderRadius: BorderRadius.circular(79.0),
                          ),
                          child: Transform.rotate(
                            angle: -math.pi / 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Next',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color:
                                              _pageIndex.isEven ? kWhite : null,
                                          fontWeight: _pageIndex.isEven
                                              ? null
                                              : FontWeight.w700),
                                ),
                                const SizedBox(width: 16.0),
                                SvgPicture.asset(
                                  'assets/icons/arrow_forward.svg',
                                  color: _pageIndex.isEven ? kWhite : kBlack,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
