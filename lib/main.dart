import 'IdInput.dart';
import 'package:club_task/newPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/top.png'),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 70.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    Text("タスクの分配",style: TextStyle(fontSize: 30)),
                    Text("&",style: TextStyle(fontSize: 30)),
                    Text("タスクの進捗管理",style: TextStyle(fontSize: 30)),
                    Text("が簡単に",style: TextStyle(fontSize: 30))
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    elevation: 16,
                  ),
                  child: Text('登録',style: TextStyle(fontSize: 15),),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IdInput()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 16,
                  ),
                  child: Text('ログイン',style: TextStyle(color: Colors.black87,fontSize: 15),),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
