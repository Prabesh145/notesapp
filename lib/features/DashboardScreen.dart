import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/features/AddnotesScreen.dart';
import 'package:notesapp/features/UpdatenotesScreen.dart';
import 'package:notesapp/features/ChangepasswordScreen.dart';
import 'package:notesapp/models/note.dart';

class DashboardScreen extends StatefulWidget {
  final String token;
  const DashboardScreen({super.key, required this.token});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<note> _notes = [];

  @override
  void initState() {
    super.initState();
    fetchmynotes();
  }

  void fetchmynotes() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': widget.token
    };

    var dio = Dio();
    var response = await dio.request(
      'http://192.168.1.7:4000/api/note',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      List<note> notes =
          jsonData.map((noteJson) => note.fromJson(noteJson)).toList();
      setState(() {
        _notes = notes;
      });
    } else {
      print(response.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Notes",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ChangePasswordScreen(
                        token: widget.token,
                      )))
            },
            child:
                Icon(Icons.account_circle, color: Color(0xff212435), size: 50),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            GridView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _notes.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                if (index == _notes.length) {
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AddNotesScreen(
                            token: widget.token,
                          ),
                        ),
                      );

                      if (result == 'noteAdded') {
                        fetchmynotes();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 192, 188, 188),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Color(0x859d9b9b), width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  );
                } else {
                  final note = _notes[index];
                  return Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Color(0xfffffcfc),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Color(0x859d9b9b), width: 1),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                note.title ?? '',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: Text(
                                  note.description ?? '',
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(
                                                  note.createdAt ?? '')) ??
                                          '',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        color: Color(0xff696868),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UpdateNotesScreen(
                                    token: widget.token,
                                    selected: note,
                                  ),
                                ),
                              );

                              if (result == 'noteAdded') {
                                fetchmynotes();
                              }
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 8,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Note'),
                                    content: Text(
                                        'Do you want to delete this note?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () async {
                                          var headers = {
                                            'Content-Type': 'application/json',
                                            'Authorization': widget.token
                                          };

                                          var dio = Dio();
                                          var response = await dio.request(
                                            'http://192.168.1.7:4000/api/note/' +
                                                note.sId.toString(),
                                            options: Options(
                                              method: 'DELETE',
                                              headers: headers,
                                            ),
                                          );

                                          if (response.statusCode == 200) {
                                            print(json.encode(response.data));
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Note Deleted Successfully",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color.fromARGB(
                                                    255, 66, 243, 12),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            fetchmynotes();
                                            Navigator.of(context).pop();
                                          } else {
                                            print(response.statusMessage);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
