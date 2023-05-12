import 'dart:async';

import 'package:crypto4you/models/screens/spaleshscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:slide_to_act/slide_to_act.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconly/iconly.dart';
import 'package:animate_gradient/animate_gradient.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    //goNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.black12,
          Colors.greenAccent,
          Colors.black26,
        ],
        secondaryColors: const [
          Colors.black12,
          Colors.black87,
          Colors.black54,
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Container(
              padding: const EdgeInsets.only(top: 90, right: 16, left: 16),
              child: Column(children: [
                Expanded(
                  flex: 6,
                  child: FadeInDown(
                    child: Stack(children: [
                      SpinKitSpinningLines(
                        size: 240,
                        color: Colors.white,
                        itemCount: 11,
                        duration: Duration(milliseconds: 5000),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('images/firstimage.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Expanded(
                  child: FadeInLeft(
                      child: Text(
                    'Crypto 4 You',
                    style: TextStyle(
                        color: Colors.yellow[700],
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: ''),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FadeInLeft(
                      child: const Text(
                    'قیمت لحظه‌ ای ارز‌های دیجیتال',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Expanded(
                //   child: SpinKitSpinningLines(
                //     color: Colors.white30,
                //   ),
                // ),

                //slider button
                //****************
                Expanded(
                  flex: 3,
                  child: Builder(
                    builder: (context) {
                      final GlobalKey<SlideActionState> _key = GlobalKey();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SlideAction(
                          sliderRotate: false,
                          outerColor: Colors.grey[900],
                          innerColor: Colors.yellow[700],
                          child: FadeInRight(
                              child: const Text(
                            'انگشت خود را بکشید',
                            style:
                                TextStyle(color: Colors.white30, fontSize: 19),
                          )),
                          key: _key,
                          onSubmit: () {
                            Future.delayed(
                              const Duration(seconds: 2),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpalshScreen()),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

//   goNextPage() async {
//     Timer(Duration(seconds: 8), () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => SpalshScreen()),
//       );
//     });
//   }
}
