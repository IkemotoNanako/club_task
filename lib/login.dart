import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.ID}) : super(key: key);
  final ID;
  @override

  State<LoginPage> createState() => _LoginPageState();
}
// State
class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 16.0,
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'このアプリでの表示名',
                    labelStyle: TextStyle(
                      color: Colors.cyan,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  enabled: true,
                  // 入力数
                  maxLength: 10,
                  style: TextStyle(color: Colors.black),
                  obscureText: false,
                  maxLines: 1,
                  //パスワード
                  onChanged: (value) {
                    //  データベースのさーくるIDから検索する関数
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(ID: widget.ID)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  elevation: 16,
                ),
                child: Text(
                  'ログイン',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}