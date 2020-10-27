import 'package:flutter/material.dart';

import 'FlipCard.dart';
import 'FlipCardContent.dart';
import 'Variables.dart';
import 'WidgetResizing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: HomeScreen()),
    );
  }
}

List<String> image = [
  'images/image.png',
  'images/images.jpg',
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int i = 0;
  List<Map<String, String>> test = [
    {
      'name': 'Mudit',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Pranav',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Naman',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Sushant',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Ketan',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Snehil',
      'like': '88',
      'likes': '88',
    },
    {
      'name': 'Tusshar',
      'like': '88',
      'likes': '88',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    boxSizeH = SizeConfig.safeBlockHorizontal;
    boxSizeV = SizeConfig.safeBlockVertical;
    return Container(
      width: boxSizeH * 100,
      height: boxSizeV * 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xffF8F8F8), Color(0xffF2F3F7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: <double>[0.0, 1.0],
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 7.8 * boxSizeV,
            decoration: BoxDecoration(
              border: Border.all(),
              gradient: LinearGradient(
                colors: <Color>[Color(0xffDBDBDF), Color(0xffF5F6FA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 1.0],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 2.5 * boxSizeH),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print('ok');
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                Text('Nerdy'),
                GestureDetector(
                  onTap: () {
                    print('DONE');
                  },
                  child: Icon(
                    Icons.message,
                    color: Colors.black,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
          FlipCard(
            flipOnTouch: false,
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            front: FlipCardContent(
              flipCallback: (int t) {
                switch (t) {
                  case 0:
                    {
                      cardKey.currentState.leftRotation();
                      break;
                    }
                  case 1:
                    {
                      cardKey.currentState.rightRotation();
                      break;
                    }
                  case 2:
                    {
                      cardKey.currentState.centerSpin();
                      break;
                    }
                }
                Future.delayed(Duration(milliseconds: 250), () {
                  setState(() {
                    if (i < test.length - 1)
                      i++;
                    else
                      i = 0;
                  });
                });
              },
              like: test[i]['like'],
              likes: test[i]['likes'],
              name: test[i]['name'],
            ),
            back: FlipCardContent(
              flipCallback: (int t) {
                switch (t) {
                  case 0:
                    {
                      cardKey.currentState.leftRotation();
                      break;
                    }
                  case 1:
                    {
                      cardKey.currentState.rightRotation();
                      break;
                    }
                  case 2:
                    {
                      cardKey.currentState.centerSpin();
                      break;
                    }
                }
                Future.delayed(Duration(milliseconds: 250), () {
                  setState(() {
                    if (i < test.length - 1)
                      i++;
                    else
                      i = 0;
                  });
                });
              },
              like: test[i]['like'],
              likes: test[i]['likes'],
              name: test[i]['name'],
            ),
          ),
        ],
      ),
    );
  }
}
