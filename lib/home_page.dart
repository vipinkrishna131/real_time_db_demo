import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  int listLength = 0;
  int i = 0;
  var itemList = [];

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 8, 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(hintText: 'Enter Text'),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          createData(textEditingController.text);
                        },
                        child: Text('SEND'))
                  ],
                ),
              )),
          Flexible(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: listLength,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(child: Text(itemList[index].value.toString()));
                    }),
              ))
        ],
      ),
    );
  }

  void createData(String text) {
    // databaseReference.child("flutterDevsTeam1").set({
    // 'name': 'Deepak Nishad',
    // 'description': 'Team Lead'
    //   });
    databaseReference.child('1:2').child(i.toString()).set(text);
    i++;
  }

  void readData() {
    databaseReference.child('1:2').onValue.listen((event) {
      listLength = event.snapshot.children.length;
      i = event.snapshot.children.length;
      setState(() {
        itemList = event.snapshot.children.toList();
      });
    });
  }
}
