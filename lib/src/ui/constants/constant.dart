import 'package:flutter/material.dart';

class Constant {
  static const ROLE_QC = 'QC Manager';
  static const ROLE_BM = 'Branch Manager';

  static final violationStatusColors = {
    'Opening': Colors.blue,
    'Confirmed': Colors.green,
    'Excused': Colors.orange[300],
    'Rejected': Colors.orange[900],
  };

  static final reportStatusColors = {
    'Opening': Colors.blue,
    // 'Pending': Colors.orange,
    'Submitted': Colors.grey,
  };
}
