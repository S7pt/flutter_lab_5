import 'package:flutter/material.dart';
import 'package:to_do_list/bloc/user_auth_bloc.dart';
import 'package:to_do_list/components/edit_wish.dart';
import 'package:to_do_list/models/auth_person.dart';
import 'package:to_do_list/models/snacks_order.dart';
import 'package:to_do_list/screens/home/snacks_list.dart';
import 'package:to_do_list/services/auth.dart';
import 'package:to_do_list/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final UserAuthBloc _authBloc = UserAuthBloc();
  @override
  Widget build(BuildContext context) {
    void _showEditSheet() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: EditWish(),
            );
          });
    }

    final person = Provider.of<Person>(context);
    return StreamProvider<List<Snacks>?>.value(
      value: DatabaseService(uid: person.uid).snacks,
      initialData: [],
      child: Scaffold(
          backgroundColor: Colors.cyan[100],
          appBar: AppBar(
            title: Text('Wishes'),
            backgroundColor: Colors.cyan[400],
            elevation: 0.0,
            actions: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  onPrimary: Colors.white,
                ),
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  _authBloc.eventSink.add(AuthType.signOut);
                },
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[300],
                  onPrimary: Colors.white,
                ),
                icon: const Icon(Icons.create),
                label: const Text("Edit"),
                onPressed: () => {_showEditSheet()},
              )
            ],
          ),
          body: SnacksList()),
    );
  }
}
