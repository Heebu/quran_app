import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 868.6),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const MyHomePage(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Al Quran',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
