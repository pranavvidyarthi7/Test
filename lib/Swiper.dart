import 'package:flutter/cupertino.dart';
import 'package:swipedetector/swipedetector.dart';

import 'Variables.dart';
import 'Video.dart';
import 'main.dart';

class Swiper extends StatefulWidget {
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54 * boxSizeV,
      width: 85 * boxSizeH,
      child: AnimatedSwitcher(
        duration: Duration(seconds: 2),
        child: Container(
          key: ValueKey<int>(index),
          child: SwipeDetector(
            onSwipeLeft: () {
              if (index == 0) {
                setState(() {
                  index = 1;
                });
              }
            },
            onSwipeRight: () {
              if (index == 1) {
                setState(() {
                  index = 0;
                });
              }
            },
            child: index == 0
                ? Container(
                    height: 54 * boxSizeV,
                    width: 85 * boxSizeH,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image[index % 2]),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(3 * boxSizeV),
                    ),
                  )
                : Video(
                    boxSizeH: boxSizeH,
                    boxSizeV: boxSizeV,
                  ),
          ),
        ),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}
