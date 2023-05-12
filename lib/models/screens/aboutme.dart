import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutme extends StatelessWidget {
  const aboutme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.blueAccent,
          Colors.black,
          Colors.black,
        ],
        secondaryColors: const [
          Colors.black,
          Colors.black,
          Colors.blueAccent,
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('images/ui/aboutme.png')),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  ' : راه های ارتباطی ',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.red, fontFamily: 'mr', fontSize: 26),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Image(
                          width: 90,
                          image: AssetImage(
                            'images/ui/insta.png',
                          )),
                      onTap: () {
                        Showdialog(context, 'Instagram', '@thisisdariush',
                            'https', 'yek.link/Thisisdariush', null);
                      },
                    ),
                    InkWell(
                        child: Image(
                          width: 90,
                          image: AssetImage('images/ui/whatsapp.png'),
                        ),
                        onTap: () {
                          Showdialog(
                            context,
                            'Phone Number',
                            '09369700686',
                            'sms',
                            '09369700686',
                            <String, String>{
                              'body':
                                  ' سلام, من از آخرین نگارش برنامه < گواهینامه من > استفاده می کنم لطفا از نظرات  من :() جهت بهبود برنامه استفاده کنید باتشکر .'
                            },
                          );
                        }),
                    InkWell(
                      child: Image(
                        width: 90,
                        image: AssetImage('images/ui/telegram.png'),
                      ),
                      onTap: () {
                        Showdialog(context, 'Telegram', '@thisisdarius',
                            'https', 't.me/thisisdarius', null);
                      },
                    ),
                    InkWell(
                      child: Image(
                        width: 90,
                        image: AssetImage('images/ui/site.png'),
                      ),
                      onTap: () {
                        Showdialog(context, 'Site', 'www.dariushcode.ir',
                            'https', 'www.dariushcode.ir', null);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                child: Image(
                  width: double.infinity,
                  image: AssetImage('images/ui/email.png'),
                ),
                onTap: () {
                  Showdialog(
                    context,
                    'Email',
                    'dariushnotes@gmail.com',
                    'mailto',
                    'dariushnotes@gmail.com',
                    <String, String>{
                      'body':
                          ' سلام, من از آخرین نگارش برنامه < crypto4you > استفاده می کنم لطفا از نظرات  من :() جهت بهبود برنامه استفاده کنید باتشکر .'
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Image(
                  width: double.infinity,
                  image: AssetImage('images/ui/coment.png'),
                ),
                onTap: () {
                  Showdialog(
                      context,
                      'CafeBazzar',
                      'لطفا بعد  انتخاب برنامه < Crypto4you > نظر خود را اعلام کنید باتشکر',
                      'https',
                      'cafebazaar.ir/developer/989943102094',
                      null);
                },
              ),
            ),
            Expanded(
              child: InkWell(
                child: Image(
                  width: double.infinity,
                  image: AssetImage('images/ui/resource.png'),
                ),
                onTap: () {
                  Showdialog(
                      context,
                      'منابع',
                      '      https://www.coingecko.com/en/api/documentation'
                          ''
                          '  https://www.tgju.org/'
                          ''
                          ' http://time.ir/'
                          '   ',
                      'cafebazaar.ir/developer/989943102094',
                      '',
                      null);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void Showdialog(context, var titel, var text, String schemetext,
    String pathtext, var query) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('$titel'),
      content: Text('$text '),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    scheme: schemetext,
                    path: pathtext,
                    queryParameters: query,
                  );

                  launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3C80F7),
                ),
                child: Text('     باز کردن $titel  ')),
          ],
        )
      ],
    ),
  );
}
