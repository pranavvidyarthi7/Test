import 'package:flutter/material.dart';

import 'Swiper.dart';
import 'Variables.dart';

class FlipCardContent extends StatelessWidget {
  FlipCardContent({this.name, this.like, this.likes, this.flipCallback});
  final String name, like, likes;
  final Function(int) flipCallback;
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.symmetric(horizontal: BorderSide(width: 1)),
      // ),
      padding: EdgeInsets.only(
          top: 2 * boxSizeV, left: 7.2 * boxSizeH, right: 7.2 * boxSizeH),
      height: 80.5 * boxSizeV,
      // decoration: BoxDecoration(border: Border.all()),

      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5 * boxSizeH),
              width: 75 * boxSizeH,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 7 * boxSizeV,
                    width: 7 * boxSizeV,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(),
                      color: Color(0xffF5F5F8),
                    ),
                  ),
                  SizedBox(
                    width: 2 * boxSizeH,
                  ),
                  Container(
                    height: 10 * boxSizeV,
                    width: 10 * boxSizeV,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF3D1EB),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x59EE0282),
                          blurRadius: 21,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2 * boxSizeH,
                  ),
                  Container(
                    height: 10 * boxSizeV,
                    width: 10 * boxSizeV,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF3D1EB),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x59EE0282),
                          blurRadius: 21,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all()),
            height: 79 * boxSizeV,
            child: Stack(
              children: [
                Positioned(
                  bottom: 5 * boxSizeV,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15 * boxSizeH,
                      top: 3 * boxSizeV,
                      right: 15 * boxSizeH,
                      bottom: 7 * boxSizeV,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5 * boxSizeH),
                    width: 75 * boxSizeH,
                    height: 21 * boxSizeV,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff8F8F8F),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ],
                      // border: Border.all(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4 * boxSizeV),
                        bottomRight: Radius.circular(4 * boxSizeV),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$name, 19'),
                        Container(
                          width: 40 * boxSizeH,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 13 * boxSizeH,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 5 * boxSizeH,
                                      width: 5 * boxSizeH,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/Icon material-person-outline.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Text('$like'),
                                  ],
                                ),
                              ),
                              Container(
                                width: 13 * boxSizeH,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 5 * boxSizeH,
                                      width: 5 * boxSizeH,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/Icon material-person-outline.png'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Text('$likes'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Swiper(),
              ],
            ),
          ),
          Positioned(
            bottom: .5 * boxSizeV,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5 * boxSizeH),
              width: 75 * boxSizeH,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      flipCallback(0);
                    },
                    child: Container(
                      height: 6 * boxSizeV,
                      width: 6 * boxSizeV,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(),
                        color: Color(0xffFBA8CE),
                      ),
                      padding: EdgeInsets.all(1 * boxSizeV),
                      child: Container(
                        height: 5 * boxSizeV,
                        width: 5 * boxSizeV,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(),
                          color: Color(0xffFA71B0),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4 * boxSizeH,
                  ),
                  GestureDetector(
                    onTap: () {
                      flipCallback(2);
                    },
                    child: Container(
                      height: 9 * boxSizeV,
                      width: 9 * boxSizeV,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(),
                        gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Color(0xffFD67AB),
                            ],
                            stops: [
                              0.0,
                              1.0
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      padding: EdgeInsets.all(1 * boxSizeV),
                      child: Container(
                        height: 5 * boxSizeV,
                        width: 5 * boxSizeV,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xffA200D3),
                                Color(0xffF4037D),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Icon(
                          Icons.grain,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4 * boxSizeH,
                  ),
                  GestureDetector(
                    onTap: () {
                      flipCallback(1);
                    },
                    child: Container(
                      height: 9 * boxSizeV,
                      width: 9 * boxSizeV,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xffB067FD),
                              Color(0xffFD67AB),
                            ],
                            stops: [
                              0.0,
                              1.0
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      padding: EdgeInsets.all(1 * boxSizeV),
                      child: Container(
                        height: 5 * boxSizeV,
                        width: 5 * boxSizeV,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xffA200D3),
                                Color(0xffF4037D),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Icon(
                          Icons.grain,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
