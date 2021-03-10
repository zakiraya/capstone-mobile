import 'package:flutter/material.dart';

class Constant {
  static const ROLE_QC = 'QC Manager';
  static const ROLE_BM = 'Branch Manager';

  static final statusColors = {
    'Opening': Colors.blue,
    'Confirmed': Colors.green,
    'Excused': Colors.orange[300],
    'Rejected': Colors.orange[900],
    'Pending': Colors.orange,
    'Submitted': Colors.grey,
  };
}
