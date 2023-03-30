import 'package:quran_prime/page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var jsonList = [];
  MaterialColor mainColoring = Colors.brown;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var response =
          await Dio().get('https://api.alquran.cloud/v1/quran/quran-uthmani');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data["data"]['surahs'];
        });
      } else {
        print(response.statusCode);
        SnackBar(
          content: Text(response.statusCode.toString()),
        );
      }
    } catch (e) {
      print('error $e');
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _launchURL(Uri url) async {
      launchUrl(url);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Al-Quran'),
        centerTitle: true,
        backgroundColor: mainColoring,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        shadowColor: mainColoring.shade500,
        elevation: 10.h,
        child: ListView(
          itemExtent: 100,
          children: [
            ListTile(
              title: Center(
                  child: Text(
                'Quran Prime',
                style: TextStyle(
                    color: mainColoring,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp),
              )),
            ),

            //colors
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Colors Palette'),
                      content: Text('Change the App color'),
                      actionsOverflowAlignment: OverflowBarAlignment.start,
                      actions: [
                        Wrap(
                          spacing: 20,
                          children: [
                            MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.green;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.red;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                              //child: Text('Blue')
                            ),
                            MaterialButton(
                              color: Colors.brown,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.brown;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                              //child: Text('Blue')
                            ),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.blue;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.pink,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.pink;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            MaterialButton(
                              color: Colors.purple,
                              onPressed: () {
                                setState(() {
                                  mainColoring = Colors.purple;
                                  Navigator.pop(context);
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                title: Text('Color'),
                trailing: Icon(Icons.color_lens_rounded),
              ),
            ),

            //feedbacks
            GestureDetector(
              onTap: () {
                _launchURL(Uri.parse('https://wa.me/2348112006431'));
              },
              child: ListTile(
                title: Text('Feedbacks'),
                trailing: Icon(Icons.feedback),
              ),
            ),

            //github source code
            GestureDetector(
              onTap: () {
                _launchURL(Uri.parse('https://github.com/Heebu'));
              },
              child: ListTile(
                title: Text('Github'),
                trailing: Icon(Icons.repeat),
              ),
            ),
          ],
        ),
      ),
      body: jsonList.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: mainColoring,
              ),
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Pages(
                          surah: jsonList[index]['name'],
                          englishName: jsonList[index]['englishName'],
                          englishNameTranslation: jsonList[index]
                              ['englishNameTranslation'],
                          revelationType: jsonList[index]['revelationType'],
                          surahs: jsonList[index]['ayahs'],
                          bismiLlah: jsonList[0]['ayahs'][0]['text'],
                          number: jsonList[index]['ayahs'].length,
                          mainColoring: mainColoring,
                          tawba: jsonList[index]['number'] == 9 ? true : false,
                        );
                      },
                    ));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(jsonList[index]['englishName']),
                      subtitle: Text(jsonList[index]['name']),
                      leading: Text(jsonList[index]['number'].toString()),
                      trailing:
                          Text(jsonList[index]['revelationType'].toString()),
                    ),
                  ),
                );
              }),
              itemCount: jsonList.length,
            ),
    );
  }
}
