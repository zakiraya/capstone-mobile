import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViolationCreateModal extends StatelessWidget {
  const ViolationCreateModal({Key key, this.context1}) : super(key: key);

  final BuildContext context1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Material(
      clipBehavior: Clip.antiAlias,
      // borderRadius: BorderRadius.circular(16.0),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // context.read<ReportCreateBloc>().add(
                      //       ReportViolationsChanged(
                      //         reportViolation:
                      //             Violation(id: 1, violationCode: "fawefw"),
                      //       ),
                      //     );
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
              Divider(
                color: Colors.red,
              ),
              Container(
                child: Text('Violator: violator\'s name'),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text('Date of violation: 28/12/1998'),
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
                        image: AssetImage('assets/avt.jpg'),
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
