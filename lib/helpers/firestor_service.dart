import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:override_todo_demo/models/task.dart';

class FirestoreService {
  Future<Task> createTODOTask(String taskname, String taskdetails,
      String taskdate, String tasktime, String tasktype) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final user = await FirebaseAuth.instance.currentUser();
      final CollectionReference myCollection =
          Firestore.instance.collection(user.uid);
      final DocumentSnapshot ds = await tx.get(myCollection.document());

      final Task task =
          new Task(taskname, taskdetails, taskdate, tasktime, tasktype);
      final Map<String, dynamic> data = task.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Task.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit, String collection}) {

    Stream<QuerySnapshot> snapshots =  Firestore.instance.collection(collection).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

}
