import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskflow_getx/bindings/counter_binding.dart';
import 'package:taskflow_getx/screens/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow - GetX',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      //  Home
      // home: CounterScreen(),

      // GoRoutes
      initialRoute: '/counter',
      getPages: [
        GetPage(
          name: '/counter',
          page: () => CounterScreen(),
          binding: CounterBinding(),
        ),
      ],
    );
  }
}
