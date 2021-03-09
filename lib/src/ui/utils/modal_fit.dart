import 'dart:io';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';

class ViolationModalFit extends StatelessWidget {
  const ViolationModalFit({Key key, @required this.violation})
      : super(key: key);

  final Violation violation;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(16.0),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text('#error code'),
                  ),
                  Container(
                    width: 112,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Center(
                        child: Text(
                      'Status: Rejected',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
              Container(
                child: Text(
                  '${violation.name ?? 'Violation name'}',
                  style: theme.textTheme.headline6,
                ),
              ),
              Divider(
                color: Colors.red,
              ),
              Container(
                child: Text('Branch: ${violation.branchName}'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text('Regulation: ${violation.regulationName}'),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                initialValue: violation.description,
                decoration: InputDecoration(
                  labelText: 'Description: ',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (description) {},
                enabled: false,
                maxLines: 5,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.7,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: violation.imagePath == null
                            ? AssetImage('assets/avt.jpg')
                            : FileImage(File(violation.imagePath)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ModalFit extends StatelessWidget {
  const ModalFit({Key key, this.list, this.title}) : super(key: key);

  final list;
  final String title;

  @override
  Widget build(BuildContext context) {
    print(list.length);
    var size = MediaQuery.of(context).size;
    return Material(
        child: SafeArea(
      top: false,
      child: Container(
        height: size.height * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List<Widget>.generate(
                    list.length,
                    (index) => ListTile(
                      title: Text(list[index].name),
                      onTap: () {
                        Navigator.pop(context, list[index].id);
                      },
                    ),
                  ),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
