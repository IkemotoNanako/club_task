import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'project.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.ID}) : super(key: key);
  final ID;
  @override
  State<HomePage> createState() => _HomePageState();
}

// State
class _HomePageState extends State<HomePage> {
  // var projectArray = ["春合宿", "サマライ", "三送会", "春ライ"];
  var list = [];
  var projectArray = [];
  var colorArray = [
    Colors.amber,
    Colors.lime,
    Colors.lightBlueAccent,
    Colors.pinkAccent
  ];
  final formKey = GlobalKey<FormState>();
  final projectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(widget.ID)
          .where('プロジェクト名', isNull: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Scaffold(body: Text('Error: ${snapshot.error}'));
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Scaffold(body: Text('Loading...'));
          default:
            list = [];
            // snapshot.data!.docs.map((DocumentSnapshot document){
            //   debugPrint("!!!!!!!!!!!!!!!");
            //   debugPrint(document.get('プロジェクト名'));
            //   projectArray.add(document.get('プロジェクト名'));
            //   // print(document.get('プロジェクト名'));
            // });
            // print(projectArray);
            // projectArray.toSet().toList();
            // print(projectArray);
            // return Scaffold(body: GridView.count(
            //     crossAxisCount: 3,
            //     shrinkWrap: true,
            //     children: snapshot.data!.docs.map((DocumentSnapshot document){
            //       print(document.get('プロジェクト名'));
            //       var list = [];
            //       list.add(document.get('プロジェクト名'));
            //       return ListTile(
            //         title: list.contains(document.get('プロジェクト名')) ? Text(document.get('')) : Text(document.get('プロジェクト名')),
            //       );
            //     }
            //     ).toList(),
            //   ),

            return Scaffold(
              body: Container(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 0.0),
                          child: Text(
                            "サークル名",
                            style:
                                TextStyle(fontSize: 40, color: Colors.orange),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 60, 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("プロジェクト追加"),
                                      content: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '入力必須です';
                                            }
                                            return null;
                                          },
                                          controller: projectController,
                                          decoration: InputDecoration(
                                            labelText: 'プロジェクト名',
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
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
                                          onChanged: (value) {},
                                        ),
                                      ),
                                      actions: <Widget>[
                                        // ボタン領域
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            elevation: 16,
                                          ),
                                          child: Text("Cancel"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.cyan,
                                              elevation: 16,
                                            ),
                                            child: Text("OK"),
                                            onPressed: () async {
                                              DateTime now = DateTime.now();
                                              DateFormat outputFormat = DateFormat('yyyy-MM-dd');
                                              String date = outputFormat.format(now);
                                              if (formKey.currentState!
                                                  .validate()) {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        widget.ID) // コレクションID指定
                                                    .doc() // ドキュメントID自動生成
                                                    .set({
                                                  'ID': widget.ID,
                                                  'プロジェクト名':
                                                      projectController.text,
                                                  'タスク名': '',
                                                  '分類': '',
                                                  '担当者': '',
                                                  '責任者': '',
                                                  '期日': date,
                                                  '色': Random().nextInt(4)
                                                });
                                                Navigator.pop(context);
                                              }
                                            }),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add_circle_outline, size: 50.0),
                              color: Colors.cyan,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16.0,
                        ),
                        child: SizedBox(
                          height: 500,
                          // child: GridView.count(
                          //   crossAxisCount: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                print(document.get('プロジェクト名'));
                                list.add(document.get('プロジェクト名'));
                                print(list
                                    .where((element) =>
                                        element == document.get('プロジェクト名'))
                                    .length);
                                return Column(children: [
                                  list
                                              .where((element) =>
                                                  element ==
                                                  document.get('プロジェクト名'))
                                              .length ==
                                          1
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 150,
                                            width: 150,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          colorArray[document
                                                              .get('色')])),
                                              child: Text(
                                                document.get('プロジェクト名'),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProjectPage(
                                                              ID: widget.ID,
                                                              projectName:
                                                                  document.get(
                                                                      'プロジェクト名'),
                                                            color: document.get('色')
                                                          )),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Offstage(
                                          offstage: true,
                                        ),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
