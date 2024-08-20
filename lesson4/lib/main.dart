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

/// 取得儲存在本地端 app 資料夾下的 cookie jar
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
  String name = '';
  String email = '';
  String otp = '';
  String jwt = '';
  String displayName = '';
  void getOtp() async {
    final dio = Dio(BaseOptions(
      method: 'POST',
      headers: {
        'cache-control': 'no-cache',
        'accept': ContentType.json,
      },
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    ));

    final data = {
      'query': '''
mutation Otp(\$name: String!, \$email: String) {
  otp(name: \$name, email: \$email)
}
''',
      'variables': {'name': name, 'email': email}
    };
    final cookieInstance = await cookieJar;
    dio.interceptors.add(CookieManager(cookieInstance));
    final response = await dio.post(
        'https://data-api-development.wonderpet.asia/graphql-omo',
        data: jsonEncode(data));
    // final response = await dio.get('https://dart.dev');
    debugPrint(response.data.toString());
  }

  void signIn() async {
    final dio = Dio(BaseOptions(
      method: 'POST',
      headers: {
        'cache-control': 'no-cache',
        'accept': ContentType.json,
      },
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    ));

    final data = {
      'query': '''
mutation Signin(\$name: String!, \$otp: String!, \$email: String) {
  signin(name: \$name, otp: \$otp, email: \$email)
}
''',
      'variables': {'name': name, 'email': email, 'otp': otp}
    };
    final cookieInstance = await cookieJar;
    dio.interceptors.add(CookieManager(cookieInstance));
    final response = await dio.post(
        'https://data-api-development.wonderpet.asia/graphql-omo',
        data: jsonEncode(data));
    debugPrint(response.data['data'].toString());
    debugPrint(response.data['data']['signin'].toString());
    // final response = await dio.get('https://dart.dev');
    setState(() {
      jwt = response.data['data']['signin'];
    });
  }

  void authenticate() async {
    final dio = Dio(BaseOptions(
      method: 'POST',
      headers: {
        'cache-control': 'no-cache',
        'accept': ContentType.json,
        'authorization': 'Bearer $jwt'
      },
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    ));

    final data = {
      'query': '''
query Authenticate {
  authenticate {
    user {
      displayName
    }
  }
}
''',
    };
    final cookieInstance = await cookieJar;
    dio.interceptors.add(CookieManager(cookieInstance));
    setState(() {
      displayName = '';
    });
    final response = await dio.post(
        'https://data-api-development.wonderpet.asia/graphql-omo',
        data: jsonEncode(data));
    debugPrint(response.data['data'].toString());
    Authentication authentication =
        Authentication.fromJson(response.data['data']);
    setState(() {
      displayName = authentication.authenticate!.user!.displayName;
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
            Text(
              '你是：$displayName',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'name',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'email',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  otp = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'otp',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getOtp();
              },
              child: const Text('Otp'),
            ),
            ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: const Text('SignIn'),
            ),
            ElevatedButton(
              onPressed: () {
                authenticate();
              },
              child: const Text('Who am I?'),
            ),
          ],
        ),
      ),
    );
  }
}
