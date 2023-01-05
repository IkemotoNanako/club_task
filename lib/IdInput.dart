import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_task/login.dart';
import 'package:flutter/material.dart';
import 'newPage.dart';

class IdInput extends StatefulWidget {
  const IdInput({Key? key}) : super(key: key);
  @override
  State<IdInput> createState() => _IdInputState();
}

class _IdInputState extends State<IdInput> {
  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              child: TextField(
                controller: mailController,
                decoration: InputDecoration(
                  labelText: 'サークルEmail',
                  labelStyle: TextStyle(
                    color: Colors.cyan,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                enabled: true,
                // 入力数
                maxLength: 40,
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
              onPressed: () async {
                var flag;
                await FirebaseFirestore.instance.collection(mailController.text).get().then((QuerySnapshot snapshot) {
                  snapshot.docs.forEach((doc) {
                    print(doc.get('ID'));
                    flag = doc.get('ID');
                  });
                });
                print("!!!!!!!!!!!!");
                print(flag);
                if(flag != null){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(ID: mailController.text)),
                );
              }else{
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("エラー"),
                        content: Text("このメールアドレスは登録されていません"),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                }
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                elevation: 16,
              ),
              child: Text(
                '検索',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Text("新規登録の場合は"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPage()),
                        );
                      },
                      child: Text("こちら",
                          style: TextStyle(color: Colors.deepOrange)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
