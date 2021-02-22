import 'package:capstone_mobile/src/data/models/violation/violation.dart';
import 'package:flutter/material.dart';

class ViolationDetailScreen extends StatefulWidget {
  const ViolationDetailScreen({Key key, @required this.violation})
      : super(key: key);

  static Route route({@required Violation violation}) {
    return MaterialPageRoute<void>(
        builder: (_) => ViolationDetailScreen(
              violation: violation,
            ));
  }

  final Violation violation;

  @override
  _ViolationDetailScreenState createState() => _ViolationDetailScreenState();
}

class _ViolationDetailScreenState extends State<ViolationDetailScreen> {
  TextEditingController descriptionTextFieldController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var violation = widget.violation;
    descriptionTextFieldController =
        TextEditingController(text: violation.description);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, top: 8, right: 16),
        child: ListView(
          children: [
            Container(
              child: Text(
                'violation of ${violation.name}',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: theme.textTheme.headline5.fontSize,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    // child: Text("Created by: ${violation.createdBy}"),
                    ),
                Container(
                  child: Text("Status: ${violation.status}"),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Branch: "),
                  ),
                  Text(violation.branchName ?? 'empty'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Regulation: "),
                  ),
                  Text(violation.regulationName ?? 'empty'),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: Text("Created on: "),
                  ),
                  Text(violation.createdAt ?? 'empty'),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: descriptionTextFieldController,
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
                  Container(
                    child: Text("Evidence: ${violation.imagePath}"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(2),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: violation.imagePath == null
                              ? AssetImage('assets/avt.jpg')
                              : NetworkImage(violation.imagePath),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
