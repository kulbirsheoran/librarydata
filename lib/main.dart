import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarydata/db_helper.dart';
import 'package:librarydata/saved_data.dart';
import 'package:librarydata/studen_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  DbHelper dbHelper = DbHelper();

  late File _image;




  @override
  void initState() {
    init();

    super.initState();
  }

  Future init() async {
    await DbHelper.createDatabase();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library information"),
      ),
      body: SingleChildScrollView(
        child
            : Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Column(
                children: [
                  SafeArea(
                    child: Container(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter Name",
                          labelText: "Enter Name",
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter address",
                      labelText: "Enter address",
                    ),
                  ),
                  TextFormField(
                    controller: mobileNoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Mobile No",
                      labelText: "Enter Mobile No",
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              studentInfoRecord();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SavedData()));
                            },
                            child: Text("Submit Data")),
                        SizedBox(
                          width: 20,
                        ),
                       ElevatedButton(onPressed: (){}, child: Text("Camera")),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(onPressed: (){}, child: Text("Id Image"))
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future studentInfoRecord() async {
    String name = nameController.text;
    String address = addressController.text;
    String mobileNo = mobileNoController.text;
    String date = DateTime.now().toString();

    StudentInfo expenseInfo = StudentInfo(
        name: name, address: address, mobileNo: mobileNo, date: date);
    await DbHelper.addExpense(expenseInfo);
    setState(() {});
    nameController.text = "";
    addressController.text = "";
    mobileNoController.text = "";
  }
}
