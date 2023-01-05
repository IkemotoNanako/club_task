import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key, required this.ID, this.projectName, this.color})
      : super(key: key);

  final ID;
  final projectName;
  final color;
  @override
  // _MyHomePageStateを利用する
  State<ProjectPage> createState() => _ProjectPageState();
}

// State
class _ProjectPageState extends State<ProjectPage> {
  Future _pickDate(BuildContext context, document) async {
    final initialDate = DateTime.now();
    DateTime selectedDate = initialDate;
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2));
    if (newDate != null) {
      setState(() => selectedDate = newDate);
      var id;
      await FirebaseFirestore
          .instance
          .collection(widget.ID) // コレクションID指定
          .where('プロジェクト名', isEqualTo: widget.projectName)
          .where('タスク名', isEqualTo: document.get('タスク名'))
          .get()
          .then((QuerySnapshot snapshot) => {
        snapshot.docs.forEach((f) {
          print("documentID---- " + f.reference.id);
          id = f.reference.id;
        }),
      });
      await FirebaseFirestore
          .instance
          .collection(widget.ID)
          .doc(id)
          .update({
        '期日':Timestamp.fromDate(selectedDate),
      });
    } else {
      return;
    }
  }
  var timestampString;
  Future _pickDate2(BuildContext context) async {
    final initialDate = DateTime.now();
    DateTime selectedDate2 = initialDate;
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2));
    if (newDate != null) {
      setState(() => timestampString =DateFormat('yyyy-MM-dd').format(newDate));
    } else {
      return;
    }
  }
  final taskController = TextEditingController();
  final bunruiController = TextEditingController();
  final kizituController = TextEditingController();
  final tantouController = TextEditingController();
  final sekininController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.ID)
            .where('プロジェクト名', isEqualTo: widget.projectName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Scaffold(body: Text('Error: ${snapshot.error}'));
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(body: Text('Loading...'));
            default:
              return Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50.0,
                            horizontal: 16.0,
                          ),
                          child: Text(
                            widget.projectName,
                            style:
                                TextStyle(fontSize: 40, color: Colors.orange),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("タスク追加"),
                                      content: Form(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: taskController,
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
                                            ElevatedButton(onPressed: (){
                                              _pickDate2(context);
                                            }, child: Text("期日入力")),
                                            TextFormField(
                                              controller: tantouController,
                                              decoration: InputDecoration(
                                                labelText: '担当者',
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
                                            TextFormField(
                                              controller: sekininController,
                                              decoration: InputDecoration(
                                                labelText: '責任者',
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
                                          ],
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
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                    widget.ID) // コレクションID指定
                                                    .doc() // ドキュメントID自動生成
                                                    .set({
                                                  'ID': widget.ID,
                                                  'プロジェクト名':
                                                  widget.projectName,
                                                  'タスク名': taskController.text,
                                                  '担当者': tantouController.text,
                                                  '責任者': sekininController.text,
                                                  '期日': Timestamp.fromDate(DateTime.parse(timestampString)),
                                                  '色': widget.color
                                                });
                                                taskController.text = '';
                                                tantouController.text = '';
                                                sekininController.text = '';
                                                Navigator.pop(context);
                                            }),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add_circle_outline, size: 50.0),
                              color: Colors.cyan,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 500,
                        child: ListView(children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        color: Colors.amber,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 8, 0, 8),
                                          child: Text(
                                            "タスク名",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        color: Colors.amber,
                                        width: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 8, 0, 8),
                                          child: Text(
                                            "期日",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        color: Colors.amber,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 8, 0, 8),
                                          child: Text(
                                            "担当者",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        color: Colors.amber,
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 8, 0, 8),
                                          child: Text(
                                            "責任者",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            color: Colors.amber[100],
                                            width: 100,
                                            height: 33,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 8, 0, 8),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          document.get('タスク名')),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "タスク名"),
                                                                  content: Form(
                                                                    child:
                                                                        TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'Please enter some text';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                          taskController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'タスク名',
                                                                        labelStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        enabledBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      enabled:
                                                                          true,
                                                                      // 入力数
                                                                      maxLength:
                                                                          10,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                      obscureText:
                                                                          false,
                                                                      maxLines:
                                                                          1,
                                                                      onChanged:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    // ボタン領域
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.grey,
                                                                        elevation:
                                                                            16,
                                                                      ),
                                                                      child: Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                    ),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.cyan,
                                                                          elevation:
                                                                              16,
                                                                        ),
                                                                        child: Text(
                                                                            "OK"),
                                                                        onPressed:
                                                                            () async {
                                                                          var id;
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID) // コレクションID指定
                                                                              .where('プロジェクト名', isEqualTo: widget.projectName)
                                                                              .where('タスク名', isEqualTo: document.get('タスク名'))
                                                                              .get()
                                                                              .then((QuerySnapshot snapshot) => {
                                                                                    snapshot.docs.forEach((f) {
                                                                                      print("documentID---- " + f.reference.id);
                                                                                      id = f.reference.id;
                                                                                    }),
                                                                                  });
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID)
                                                                              .doc(id)
                                                                              .update({
                                                                            'タスク名':
                                                                                taskController.text,
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                          taskController.text =
                                                                              '';
                                                                        }),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 15,
                                                          ))
                                                    ])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            color: Colors.amber[100],
                                            width: 150,
                                            height: 33,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        2, 8, 0, 8),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                DateFormat('yyyy-MM-dd').format(document.get('期日').toDate())
                                                          ),
                                                      IconButton(
                                                          onPressed: () {
                                                            _pickDate(context,document);
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 15,
                                                          ))
                                                    ])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            color: Colors.amber[100],
                                            width: 100,
                                            height: 33,
                                            child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    2, 8, 0, 8),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                          document.get('担当者')),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "担当者"),
                                                                  content: Form(
                                                                    child:
                                                                    TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null ||
                                                                            value.isEmpty) {
                                                                          return 'Please enter some text';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                      tantouController,
                                                                      decoration:
                                                                      InputDecoration(
                                                                        labelText:
                                                                        '担当者',
                                                                        labelStyle:
                                                                        TextStyle(
                                                                          color:
                                                                          Colors.grey,
                                                                        ),
                                                                        enabledBorder:
                                                                        UnderlineInputBorder(
                                                                          borderSide:
                                                                          BorderSide(
                                                                            color:
                                                                            Colors.grey,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                        UnderlineInputBorder(
                                                                          borderSide:
                                                                          BorderSide(
                                                                            color:
                                                                            Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      enabled:
                                                                      true,
                                                                      // 入力数
                                                                      maxLength:
                                                                      10,
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.black),
                                                                      obscureText:
                                                                      false,
                                                                      maxLines:
                                                                      1,
                                                                      onChanged:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    // ボタン領域
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                        Colors.grey,
                                                                        elevation:
                                                                        16,
                                                                      ),
                                                                      child: Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () =>
                                                                          Navigator.pop(context),
                                                                    ),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                          Colors.cyan,
                                                                          elevation:
                                                                          16,
                                                                        ),
                                                                        child: Text(
                                                                            "OK"),
                                                                        onPressed:
                                                                            () async {
                                                                          var id;
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID) // コレクションID指定
                                                                              .where('プロジェクト名', isEqualTo: widget.projectName)
                                                                              .where('タスク名', isEqualTo: document.get('タスク名'))
                                                                              .get()
                                                                              .then((QuerySnapshot snapshot) => {
                                                                            snapshot.docs.forEach((f) {
                                                                              print("documentID---- " + f.reference.id);
                                                                              id = f.reference.id;
                                                                            }),
                                                                          });
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID)
                                                                              .doc(id)
                                                                              .update({
                                                                            '担当者':
                                                                            tantouController.text,
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                          tantouController.text =
                                                                          '';
                                                                        }),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 15,
                                                          ))
                                                    ])),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            color: Colors.amber[100],
                                            width: 100,
                                            height: 33,
                                            child: Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(
                                                    2, 8, 0, 8),
                                                child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                          document.get('責任者')),
                                                      IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "責任者"),
                                                                  content: Form(
                                                                    child:
                                                                    TextFormField(
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                            null ||
                                                                            value.isEmpty) {
                                                                          return 'Please enter some text';
                                                                        }
                                                                        return null;
                                                                      },
                                                                      controller:
                                                                      sekininController,
                                                                      decoration:
                                                                      InputDecoration(
                                                                        labelText:
                                                                        '責任者',
                                                                        labelStyle:
                                                                        TextStyle(
                                                                          color:
                                                                          Colors.grey,
                                                                        ),
                                                                        enabledBorder:
                                                                        UnderlineInputBorder(
                                                                          borderSide:
                                                                          BorderSide(
                                                                            color:
                                                                            Colors.grey,
                                                                          ),
                                                                        ),
                                                                        focusedBorder:
                                                                        UnderlineInputBorder(
                                                                          borderSide:
                                                                          BorderSide(
                                                                            color:
                                                                            Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      enabled:
                                                                      true,
                                                                      // 入力数
                                                                      maxLength:
                                                                      10,
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.black),
                                                                      obscureText:
                                                                      false,
                                                                      maxLines:
                                                                      1,
                                                                      onChanged:
                                                                          (value) {},
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    // ボタン領域
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                        Colors.grey,
                                                                        elevation:
                                                                        16,
                                                                      ),
                                                                      child: Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () =>
                                                                          Navigator.pop(context),
                                                                    ),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                          Colors.cyan,
                                                                          elevation:
                                                                          16,
                                                                        ),
                                                                        child: Text(
                                                                            "OK"),
                                                                        onPressed:
                                                                            () async {
                                                                          var id;
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID) // コレクションID指定
                                                                              .where('プロジェクト名', isEqualTo: widget.projectName)
                                                                              .where('タスク名', isEqualTo: document.get('タスク名'))
                                                                              .get()
                                                                              .then((QuerySnapshot snapshot) => {
                                                                            snapshot.docs.forEach((f) {
                                                                              print("documentID---- " + f.reference.id);
                                                                              id = f.reference.id;
                                                                            }),
                                                                          });
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection(widget.ID)
                                                                              .doc(id)
                                                                              .update({
                                                                            '責任者':
                                                                            sekininController.text,
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                          sekininController.text =
                                                                          '';
                                                                        }),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 15,
                                                          ))
                                                    ])),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                        ]),
                      )
                      // }).toList(),
                    ],
                  ),
                ),
              );
          }
        });
  }
}
