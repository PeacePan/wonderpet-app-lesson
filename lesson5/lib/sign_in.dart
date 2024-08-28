import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    userNameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                top: 52,
                left: 16,
              ),
              margin: const EdgeInsets.only(bottom: 128),
              child: Text('員工登入', style: TextStyle(fontSize: 32)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: userNameCtrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '門市',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: TextFormField(
                        controller: passwordCtrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '員工編號',
                          helperText: errorText,
                          helperStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          onPressed: () {
                            final isInvalid = RegExp(r'[a-zA-Z]').hasMatch(
                              passwordCtrl.text,
                            );
                            setState(() {
                              errorText = isInvalid ? '員工編號格式輸入錯誤' : null;
                            });
                          },
                          child: Text(
                            '登入',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
