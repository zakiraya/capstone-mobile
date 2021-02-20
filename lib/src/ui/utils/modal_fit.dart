import 'dart:io';

import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key key, @required this.violation}) : super(key: key);

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
                child: Text('Branch: ${violation.branchId}'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text('Regulation: ${violation.regulationId}'),
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
