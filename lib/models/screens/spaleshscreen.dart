import 'dart:io';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:crypto4you/models/screens/listpage.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/crypto.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

bool ActiveConnection = false;
String T = "";
String text = 'در حال دریافت داده ها لطفا منتظر بمانید ';

Color DioCheckcolor = Colors.transparent;
Color internetCheckcolor = Colors.transparent;
var errorText;

class _SpalshScreenState extends State<SpalshScreen> {
  String title = 'loading....';

  @override
  void initState() {
    super.initState();
    checkcontection();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomLeft,
          secondaryEnd: Alignment.topRight,
          primaryColors: const [
            Colors.greenAccent,
            Colors.blueGrey,
            Colors.black26,
          ],
          secondaryColors: const [
            Colors.black12,
            Colors.black87,
            Colors.black54,
          ],
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('images/icons/NFT_4.png'),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                  child: SizedBox(
                height: 50,
              )),
              Expanded(
                  child: Text(
                text,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'mr'),
              )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      T,
                      style: TextStyle(
                          fontSize: 20,
                          color: internetCheckcolor,
                          fontFamily: 'mr'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '$errorText ',
                        style: TextStyle(
                          fontSize: 15,
                          color: DioCheckcolor,
                          fontFamily: 'mr',
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('دانلود شکن'),
                              content: Text(
                                  ' سامانه «شکن» یک تحریم‌شکن ایرانی و قانونی است که امکان دسترسی به برنامه های  تحریم‌شده را به آسانی فراهم می‌کند.'),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF3C80F7),
                                        ),
                                        child: Text('برگشت ')),
                                    ElevatedButton(
                                        onPressed: () {
                                          var url = Uri(
                                            scheme: 'https',
                                            path:
                                                'cafebazaar.ir/app/co.bonyan.shecan',
                                            queryParameters: null,
                                          );

                                          launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF3C80F7),
                                        ),
                                        child: Text('   دانلود شکن   ')),
                                  ],
                                )
                              ],
                            ));
                  },
                ),
              ),
              Expanded(
                child: SpinKitFadingCube(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<void> checkcontection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          internetCheckcolor = Colors.greenAccent;
          ActiveConnection = true;

          T = "اتصال به اینترنت برقرار شد  ";

          print(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        internetCheckcolor = Colors.red;
        ActiveConnection = false;
        text = '';
        T = "لطفا اتصال به اینترنت را بررسی و مجدد برنامه را باز کنید ";

        print(T);
      });
    }
  }

  Future<void> getdollor() async {
    //dollor price
    var responsedollor =
        await Dio().get('https://dapi.p3p.repl.co/api/?currency=usd');

    var dollorPrice = responsedollor.data['Price'];
    print(dollorPrice);
  }

  Future<void> getdata() async {
    //crypto price

    try {
      var response = await Dio().get('https://api.coincap.io/v2/assets');
      List<Crypto> cryptolist = response.data['data']
          .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
          .toList();
      print(cryptolist);

      // date

      var responseDate = await Dio().get('https://api.keybit.ir/time/');
      var Date = responseDate.data['date']['full']['official']['iso']['en'];
      var DateDay = responseDate.data['date']['weekday']['name'];
      var DateMonth = responseDate.data['date']['month']['name'];
      var DateDaytype = responseDate.data['date']['day']['name'];
      print(Date);
      print(DateDay);
      print(DateMonth);
      print(DateDaytype);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListPage(
            cryptoList: cryptolist,
            Date: Date,
            DateDay: DateDay,
            DateMonth: DateMonth,
            DateDaytype: DateDaytype,
          ),
        ),
      );
    } catch (ex) {
      setState(() {
        DioCheckcolor = Colors.grey;
        text = '';
        errorText =
            'عدم امکان دریافت اطلاعات از سرور (لطفا از فعال بودن تحریم شکن(برنامه شکن) یا تغییر دهنده Ip مطمئن بشوید جهت دانلود شکن روی این متن کلبک کنید';
      });
      print(ex);
    }
  }
}
