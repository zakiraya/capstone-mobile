import 'package:capstone_mobile/src/blocs/authentication/authentication_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownFieldBranch extends StatefulWidget {
  @override
  _DropdownFieldBranchState createState() => _DropdownFieldBranchState();
}

class _DropdownFieldBranchState extends State<DropdownFieldBranch> {
  String id;
  List<String> list = [
    'america',
    'vietnam',
    'canada',
    'thailand',
    'laos',
  ];

  BranchRepository _branchRepository = BranchRepository();
  List<Branch> _branches = List();
  List<String> _brancheNames = List();
  String _initValue;

  Future<String> getBranches() async {
    var branches = await _branchRepository.fetchBranches(
        BlocProvider.of<AuthenticationBloc>(context).state.token);

    if (this.mounted) {
      setState(() {
        _branches = branches;
        _brancheNames = _branches.map((e) => e.name).toList();
      });
    }

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropDownField(
        onValueChanged: (value) {
          id = value;
          print(_branches.firstWhere((element) => element.name == value).id);
        },
        value: _initValue,
        hintText: 'Choose a branch',
        labelText: 'Branch',
        items: _brancheNames,
        strict: false,
      ),
    );
  }
}
