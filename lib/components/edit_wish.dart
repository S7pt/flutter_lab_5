import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/person_data_bloc.dart';
import 'package:to_do_list/components/spinner.dart';
import 'package:to_do_list/components/textbox.dart';
import 'package:to_do_list/models/auth_person.dart';
import 'package:to_do_list/models/person_snacks_data.dart';
import 'package:to_do_list/services/database.dart';

class EditWish extends StatefulWidget {
  const EditWish({Key? key}) : super(key: key);

  @override
  _EditWishState createState() => _EditWishState();
}

class _EditWishState extends State<EditWish> {
  final UserUpdateBloc bloc = UserUpdateBloc();
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  String? _currentWishes;
  final UserUpdateBloc _updateBloc = UserUpdateBloc();
  @override
  Widget build(BuildContext context) {
    final person = Provider.of<Person>(context);
    return StreamBuilder<PersonData>(
        stream: DatabaseService(uid: person.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your wish.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                    "Write your name or anything that can identify you",
                    style: TextStyle(fontSize: 9),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    initialValue: snapshot.data?.name,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    decoration:
                        textInput.copyWith(hintText: "Name or nickname"),
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                    "Write what do you want(leave empty if nothing)",
                    style: TextStyle(fontSize: 9),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    initialValue: snapshot.data?.snacks,
                    decoration: textInput.copyWith(hintText: "Wish"),
                    onChanged: (val) => setState(() => _currentWishes = val),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        onPrimary: Colors.white,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        bloc.eventSink.add([
                          person.uid,
                          _currentName ?? snapshot.data!.name,
                          _currentWishes ?? snapshot.data!.snacks
                        ]);
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          } else {
            return Spinner();
          }
        });
  }
}
