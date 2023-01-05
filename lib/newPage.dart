import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_task/home.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  var projectArray = [];
  final projectController = TextEditingController();
  final nameController = TextEditingController();
  final clubNameController = TextEditingController();
  final mailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '入力必須です';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: InputDecoration(
                          labelText: 'サークルEmail',
                          hintText: 'ほかのメンバーの参加に使います',
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
                        maxLength: 40,
                        style: TextStyle(color: Colors.black),
                        obscureText: false,
                        maxLines: 1,
                        //パスワード
                        onChanged: (value) {
                          //
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '入力必須です';
                          }
                          return null;
                        },
                        controller: clubNameController,
                        decoration: InputDecoration(
                          labelText: 'サークル名',
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
                          //
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '入力必須です';
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'このアプリでの名前',
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
                        onChanged: (value) {
                          //
                        },
                      ),
                    ],
                  )),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection(mailController.text) // コレクションID指定
                          .doc() // ドキュメントID自動生成
                          .set({
                        'ID': mailController.text,
                        'サークル名': clubNameController.text,
                        // 'name': nameController.text,
                      //  いづれ通知機能をつける
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(ID: mailController.text)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    elevation: 16,
                  ),
                  child: Text("作成", style: TextStyle(fontSize: 15)))
            ],
          ),
        ),
      ),
    );
  }
}
