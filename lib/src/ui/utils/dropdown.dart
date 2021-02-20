import 'package:capstone_mobile/src/blocs/report_create/report_create_bloc.dart';
import 'package:capstone_mobile/src/blocs/violation_create/violation_bloc.dart';
import 'package:capstone_mobile/src/data/models/branch/branch.dart';
import 'package:capstone_mobile/src/data/models/regulation/regulation.dart';
import 'package:capstone_mobile/src/data/repositories/branch/branch_repository.dart';
import 'package:capstone_mobile/src/data/repositories/regulation/regulation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchDropdown extends StatefulWidget {
  BranchDropdown({Key key}) : super(key: key);

  @override
  BranchDropdownState createState() => BranchDropdownState();
}

class BranchDropdownState extends State<BranchDropdown> {
  BranchRepository _branchRepository = BranchRepository();
  List<Branch> _branches = List();
  Branch dropdownValue;

  Future<String> getBranches() async {
    var branches = await _branchRepository.fetchBranches(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiNiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjAyNDNjMTQxLWYwMWEtNDY3Ny05NWM0LTE2NjE5Y2EzNzA4ZSIsIm5iZiI6MTYxMjA2ODMyNCwiZXhwIjoxNjEyMDY4NjI0LCJpYXQiOjE2MTIwNjgzMjQsImF1ZCI6Ik1hdmNhIn0.dK4_IdMsgrfvzc_8TnN5hPOXhFdfqOOh08gSFcb5WiI");

    setState(() => _branches = branches);
    // [
    //   Branch(id: 1, name: "Br01"),
    //   Branch(id: 2, name: "Br02"),
    //   Branch(id: 3, name: "Br03"),
    //   Branch(id: 4, name: "Br04"),
    // ]);

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: DropdownButton<Branch>(
        isExpanded: true,
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 1,
          color: Colors.black38,
        ),
        onChanged: (newValue) {
          setState(() {
            print('new value: ${newValue.name}');
            dropdownValue = newValue;
          });
          context.read<ViolationCreateBloc>().add(
                ViolationBranchChanged(branchId: newValue.id),
              );
        },
        items: _branches.map<DropdownMenuItem<Branch>>((branch) {
          return DropdownMenuItem<Branch>(
            value: branch,
            child: Text(branch.name),
          );
        }).toList(),
      ),
    );
    // });
  }
}

class RegulationDropdown extends StatefulWidget {
  RegulationDropdown({Key key}) : super(key: key);

  @override
  RegulationDropdownState createState() => RegulationDropdownState();
}

class RegulationDropdownState extends State<RegulationDropdown> {
  RegulationRepository _regulationRepository = RegulationRepository();
  List<Regulation> _regulations = List();
  Regulation dropdownValue;

  Future<String> getBranches() async {
    var regulations = await _regulationRepository.fetchRegulationes(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiNiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjAyNDNjMTQxLWYwMWEtNDY3Ny05NWM0LTE2NjE5Y2EzNzA4ZSIsIm5iZiI6MTYxMjA2ODMyNCwiZXhwIjoxNjEyMDY4NjI0LCJpYXQiOjE2MTIwNjgzMjQsImF1ZCI6Ik1hdmNhIn0.dK4_IdMsgrfvzc_8TnN5hPOXhFdfqOOh08gSFcb5WiI");

    setState(() => _regulations = regulations);

    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: DropdownButton<Regulation>(
        isExpanded: true,
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 1,
          color: Colors.black38,
        ),
        onChanged: (newValue) {
          setState(() {
            print('new value: ${newValue.name}');
            dropdownValue = newValue;
          });
          context.read<ViolationCreateBloc>().add(
                ViolationRegulationChanged(violationRegulation: newValue.id),
              );
        },
        items: _regulations.map<DropdownMenuItem<Regulation>>((regulation) {
          return DropdownMenuItem<Regulation>(
            value: regulation,
            child: Text(regulation.name),
          );
        }).toList(),
      ),
    );
    // });
  }
}
