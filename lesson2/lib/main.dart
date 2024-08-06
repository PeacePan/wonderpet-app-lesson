import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/example.dart';
import 'routes/home.dart';
import 'routes/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ExampleProvider()),
        // ChangeNotifierProvider<ExampleProvider>(
        //   create: (context) => ExampleProvider(),
        //   builder: (context, child) {
        //     return child!;
        //   },
        // ),
      ],
      child: MaterialApp(
        title: 'Lesson2',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          Navigator.defaultRouteName: (context) =>
              const MyHomePage(title: '主選單'),
          '/other_page': (context) => const OtherPage(title: '其他頁面'),
        },
      ),
    );
    ;
  }
}
