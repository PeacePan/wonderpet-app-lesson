import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lesson4/auth.dart';
import 'package:path_provider/path_provider.dart';

PersistCookieJar? _cookieJar;
final dio = Dio();

/// 取得儲存在本地端 App 資料夾下的 cookie jar
Future<CookieJar> get cookieJar async {
  if (_cookieJar == null) {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path));
  }
  return _cookieJar!;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String name = '';
  String email = '';
  String otp = '';
  String myName = '';

  void _incrementCounter() async {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    final dio = Dio(
      BaseOptions(
        method: 'POST',
        headers: {
          'cache-control': 'no-cache',
          'accept': ContentType.json,
          'authorization':
              'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJfaWQiOjE1ODQsInNpZ25hdHVyZSI6IklRZ0JuVDhrdkhDLzlNT01FR1Fzb1dkV1c2YndBeU12UHQveG9UQUtOdjBOUWk2ZHF5djBZSmcwUXppVjBCcHRHd0pyaU1rOUtzVW5ZdWJaQnV2Qm1BPT0iLCJpYXQiOjE3MjQxMzkyMTQsImV4cCI6MTcyNDIyNTYxNCwiYXVkIjoiZGF0YS1hcGktZGV2ZWxvcG1lbnQud29uZGVycGV0LmFzaWEiLCJpc3MiOiJqYXZhY2F0Iiwic3ViIjoiMTU4NC51Y0ozWmUrYSJ9.IEEc9dW6FjurrhBJNngLegxt8f82ATW3BSE07FUgb4Wka3N7TWKebtqj5FKR9PGvY_-aAUrgFiFLowPjPG9QiA',
        },
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
// '395199'
//     final data = {
//       'query': '''
// mutation Otp(\$name: String!, \$email: String) {
//   otp(name: \$name, email: \$email)
// }
// ''',
//       'variables': {'name': '19060110', 'email': 'peace.pan@wonderpet.asia'}
//     };
//     final data = {
//       'query': '''
// mutation Signin(\$name: String!, \$otp: String!, \$email: String) {
//   signin(name: \$name, otp: \$otp, email: \$email)
// }
// ''',
//       'variables': {
//         'name': '19060110',
//         'email': 'peace.pan@wonderpet.asia',
//         'otp': '395199'
//       }
//     };
    final data = {
      'query': '''
query Authenticate {
  authenticate {
    user {
      disabled
      displayName
      name
    }
  }
}
'''
    };

    final cookieInstance = await cookieJar;
    dio.interceptors.add(CookieManager(cookieInstance));
    final response = await dio.post(
      'https://data-api-development.wonderpet.asia/graphql-omo',
      data: jsonEncode(data),
    );
    // debugPrint(response.data['data'].toString());
    final gqlData = Authentication.fromJson(response.data['data']);
    // debugPrint(auth.user?.displayName);
    setState(() {
      myName = gqlData.authenticate?.user?.displayName ?? '';
      // myName = response.data['data']['authenticate']['user']['displayName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              myName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.text,
              enableIMEPersonalizedLearning: false,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              enableIMEPersonalizedLearning: false,
              textInputAction: TextInputAction.send,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'OTP',
              ),
              keyboardType: TextInputType.number,
              enableIMEPersonalizedLearning: false,
              textInputAction: TextInputAction.send,
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  //otp
                },
                child: const Text('OTP')),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                //signin
              },
              child: const Text(
                'Signin',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
