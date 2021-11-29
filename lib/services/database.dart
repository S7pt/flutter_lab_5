import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/person_snacks_data.dart';
import 'package:to_do_list/models/snacks_order.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference snacksCollection =
      FirebaseFirestore.instance.collection('snacks');

  Future updatePersonData(String name, String snacks) async {
    return await snacksCollection
        .doc(uid)
        .set({'name': name, 'snacks': snacks});
  }

  List<Snacks> _dataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Snacks(
        name: (doc.data() as dynamic)['name'] ?? '',
        snacks: (doc.data() as dynamic)['snacks'] ?? '',
      );
    }).toList();
  }

  PersonData _userdataFromSnapshot(DocumentSnapshot snapshot) {
    return PersonData(
        uid: uid, name: snapshot["name"], snacks: snapshot["snacks"]);
  }

  Stream<List<Snacks>?> get snacks {
    return snacksCollection.snapshots().map(_dataFromSnapshot);
  }

  Stream<PersonData> get userData {
    return snacksCollection.doc(uid).snapshots().map(_userdataFromSnapshot);
  }
}
