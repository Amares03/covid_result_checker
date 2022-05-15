import 'package:covid_result_checker/services/apiFunctions.dart';
import 'package:flutter/material.dart';

ApiFunction apiFunction = ApiFunction();

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ALL USERS")),
      body: Column(
        children: [],
      ),
    );
  }
}
