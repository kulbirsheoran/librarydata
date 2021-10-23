import 'package:flutter/material.dart';
import 'package:librarydata/studen_info.dart';

import 'db_helper.dart';

class SavedData extends StatefulWidget {
  const SavedData({Key? key}) : super(key: key);

  @override
  _SavedDataState createState() => _SavedDataState();
}

class _SavedDataState extends State<SavedData> {
  List<StudentInfo> studentInfoList = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    studentInfoList = await DbHelper.getStudent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
        child: Expanded(
          child: ListView.builder(
              itemCount: studentInfoList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                StudentInfo studentInfo = studentInfoList[index];
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      StudentInfo studentInfo = studentInfoList[index];
                      DbHelper.delete(studentInfo.name);
                      studentInfoList.removeAt(index);


                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: Colors.deepOrangeAccent),
                      color: Colors.green[200],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Name:${studentInfo.name}"),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Address:${studentInfo.address}"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("MobileNo${studentInfo.mobileNo}"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Date${studentInfo.date}"),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
