import 'package:provider/provider.dart';
import 'package:to_do_list/models/auth_person.dart';
import 'package:to_do_list/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
