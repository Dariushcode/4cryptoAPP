import 'package:auto_animated/auto_animated.dart';
import 'package:crypto4you/models/screens/aboutme.dart';
import 'package:crypto4you/models/screens/help.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/constanse.dart';
import '../data/crypto.dart';

class ListPage extends StatefulWidget {
  ListPage(
      {Key? key,
      this.cryptoList,
      this.Date,
      this.DateDay,
      this.DateMonth,
      this.DateDaytype})
      : super(key: key);
  List<Crypto>? cryptoList;

  var Date;
  var DateDay;
  var DateMonth;
  var DateDaytype;
  @override
  State<ListPage> createState() => _ListPageState();
}

List<Crypto>? cryptoList;
var dollorPrice;
var Date;
var DateDay;
var DateMonth;
var DateDaytype;
bool isSearchLoadingVisible = false;

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    getdollor();
    // TODO: implement initState
    super.initState();
    cryptoList = widget.cryptoList;

    Date = widget.Date;
    DateMonth = widget.DateMonth;
    DateDay = widget.DateDay;
    DateDaytype = widget.DateDaytype;
  }

  var dollorPrice = '52345';
  Future<void> getdollor() async {
    //dollor price
    var responsedollor =
        await Dio().get('https://dapi.p3p.repl.co/api/?currency=usd');
    setState(() {
      dollorPrice = responsedollor.data['Price'];
      print(dollorPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        elevation: 7,
        shadowColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 190,
        backgroundColor: blackColor,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => aboutme()));
                    },
                    icon: Icon(Icons.account_balance_outlined)),
                Text(
                  'Crypto 4 You',
                  style: TextStyle(fontFamily: 'mr', fontSize: 26),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => help()));
                    },
                    icon: Icon(Icons.settings)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    onChanged: (value) {
                      _fiterList(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'اسم رمزارز معتبر را سرچ کنید',
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle:
                            TextStyle(fontFamily: 'mr', color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800]),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isSearchLoadingVisible,
              child: Text(
                '...در حال اپدیت اطلاعات رمز ارزها',
                style: TextStyle(color: greenColor, fontFamily: 'mr'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                Text(
                  ' نرخ دلار  =$dollorPrice ریال  ',
                  style: TextStyle(fontFamily: 'mr', fontSize: 17),
                ),
                Icon(
                  Icons.monetization_on,
                  size: 20,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                Text(
                  '$DateDay   $DateDaytype   $DateMonth   ',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontFamily: 'mr', fontSize: 10),
                ),
                Icon(
                  Icons.date_range,
                  size: 14,
                  color: Colors.blueGrey,
                ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  ' $Date:آخرین بروزرسانی',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: 'mr', fontSize: 10, color: Colors.white),
                ),
                Icon(
                  Icons.sync,
                  size: 14,
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _getlistviwe(),
      ),
    );
  }

  Widget _getlistviwe() {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () async {
        // Replace this delay with the code to be executed during refresh
        // and return asynchronous code
      },
      child: Container(
        child: LiveList(
          physics: const AlwaysScrollableScrollPhysics(),
          showItemInterval: const Duration(milliseconds: 300),
          showItemDuration: const Duration(milliseconds: 700),
          itemCount: cryptoList!.length,
          itemBuilder: _buildAnimatedItem,
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: _getList(
              cryptoList![index],
            ),
          ),
        ),
      );

  Widget _getList(
    Crypto crypto,
  ) {
    var tomman = 54 * crypto.priceUsd;

    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: whiteColor),
      ),
      subtitle: Row(
        children: [
          Text(
            crypto.symbol,
            style: TextStyle(color: greyColor),
          ),
          // SizedBox(
          //   width: 10,
          // ),
          // Text(
          //   " ${tomman.toStringAsFixed(0)}ریال",
          //   style: TextStyle(color: greyColor, fontSize: 16),
          // ),
        ],
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
            child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              AssetImage('images/icons/${crypto.symbol.toLowerCase()}.png'),

          //   NetworkImage(
          //       'https://cryptoicons.org/api/icon/${crypto.symbol.toLowerCase()}/400'),
        )

            // Text(
            //   crypto.rank.toString(),
            //   style: TextStyle(color: greyColor),
            // ),
            ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(3),
                  style: TextStyle(color: greyColor, fontSize: 18),
                ),
                Text(
                  crypto.changePercent24hr.toStringAsFixed(3),
                  style: TextStyle(
                    color: _getColorChnageText(crypto.changePercent24hr),
                  ),
                )
              ],
            ),
            SizedBox(
                width: 50,
                child: Center(
                  child: _getIconChangePercent(crypto.changePercent24hr),
                )),
          ],
        ),
      ),
    );
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }

  Color _getColorChnageText(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }

//
// Future<List<Crypto>> _getdata() async {
//   var response = await Dio().get('https://api.coincap.io/v2/assets/');
//   List<Crypto> cryptolist = response.data['data']
//       .map<Crypto>((jsonmodel) => Crypto.fromMapJson(jsonmodel))
//       .toList();
//   print(cryptolist);
//
//   return cryptolist;
// }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    return cryptoList;
  }

  Future<void> _fiterList(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        isSearchLoadingVisible = true;
      });
      var result = await _getData();
      setState(() {
        cryptoList = result;
        isSearchLoadingVisible = false;
      });
      return;
    }
    cryptoResultList = cryptoList!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();

    setState(() {
      cryptoList = cryptoResultList;
    });
  }
}
