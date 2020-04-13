import 'dart:io';

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit/models.dart';

class DatabaseService {
  Firestore db = Firestore.instance;

  Stream<Habits> streamHabits(String uid) {
    return db
        .collection('habits')
        .document(uid)
        .snapshots()
        .map((snap) => Habits.fromFirestore(snap));
  }

  Future<Habits> getHabits(String id) async {
    var snap = await db.collection('habits').document(id).get();

    if (snap.data == null) {
      return Habits.fromMap({
        'id': id,
        'habits': []
      });
    }

    return Habits.fromMap(snap.data);
  }

  Future<void> updateHabits(Habits habits) {
    DocumentReference ref = db.collection('habits').document(habits.id);

    return ref.updateData({'habits': habits.habits});
  }

  Stream<List<DailyLog>> streamDailyLog(String uid) {
    var ref = db
        .collection('dailyLog')
        .document('azQGM1JCeBVoLFpFPr1C68wv1x73')
        .collection('days');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => DailyLog.fromFirestore(doc)).toList());
  }

  Future<DailyLog> getDailyLog(String id) async {
    var snap = await db.collection('daily-log').document(id).get();

    return DailyLog.fromMap(snap.data);
  }

  Future<void> updateDailyLog(DailyLog habits) {
    DocumentReference ref = db.collection('daily-log').document(habits.id);

    return ref.updateData({'complete': habits.complete});
  }
}
