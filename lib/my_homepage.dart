import 'package:flutter/material.dart';
import 'package:sql_text/dphelper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbhelper = DatabaseHelper.instance;

  void insertData() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: "Prince",
      DatabaseHelper.columnAge: 30
    };

    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrow = await dbhelper.quaryall();
    allrow.forEach((row) {
      print(row);
    });
  }

  void queryspecific() async {
    var allrows = await dbhelper.queryspecific(18);
    print(allrows);
  }

  void update() async {
    var row = await dbhelper.update(3);
    print(row);
  }

  void delete() async {
    var id = await dbhelper.deletedata(2);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: insertData,
            child: Text("INSERT", style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: queryall,
            child: Text("QUERY", style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: queryspecific,
            child: Text("QUERYSPECIFIC", style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: update,
            child: Text("UPDATE", style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: delete,
            child: Text("DELETE", style: TextStyle(fontSize: 20)),
          ),
        ],
      )),
    );
  }
}
