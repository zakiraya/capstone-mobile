import 'package:capstone_mobile/src/blocs/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 8, right: 16),
      child: ListView(
        children: [
          Container(
            child: Text(
              'New report',
              style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: theme.textTheme.headline4.fontSize),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  // child: Text("Created by: Lai Van Some"),
                  ),
              Container(
                  // child: Text("Status: "),
                  ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("Branch: "),
                ),
                Container(
                  child: Text('Abc'),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("Created on: "),
                ),
                Container(
                  child: Text('Abc'),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("Submitted on: "),
                ),
                Container(
                  child: Text('Abc'),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text("Description: "),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 8,
                  decoration: InputDecoration.collapsed(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(5.0))),
                      hintText: "Enter your text here"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text("Violation list: "),
          ),
          SizedBox(
            height: 16,
          ),
          Card(
            elevation: 4,
            shadowColor: Colors.purple[300],
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/avt.jpg'),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 16,
                    // ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("#error code"),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Violation name"),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Violator: Hoang Gia Bao",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Violated date: 28/12/1998",
                                  style: TextStyle(fontSize: 8),
                                ),
                                Text("Status: Rejected",
                                    style: TextStyle(fontSize: 8)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_outlined,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Container(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.blue[900],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
