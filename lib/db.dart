import 'dart:io';

import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit/models.dart';

class DatabaseService {
  Firestore db = Firestore.instance;

  /// Habits logic
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
      return Habits.fromMap({'id': id, 'habits': []});
    }

    return Habits.fromMap(snap.data);
  }

  Future<void> updateHabits(Habits habits) {
    DocumentReference ref = db.collection('habits').document(habits.id);

    return ref.setData({'habits': habits.habits}, merge: true);
  }

  /// DailyLog logic
  Future<DailyLog> createDailyLog(String uid) async {
    // Check if today is already logged
    var ref = await db.collection('dailyLog').document(uid).collection('days');

    var docs = await ref.getDocuments();

    var nowDateString = DateTime.now().toString();
    var yearNow = DateTime.parse(nowDateString).year;
    var monthNow = DateTime.parse(nowDateString).month;
    var dayNow = DateTime.parse(nowDateString).day;
    var nowDate = [yearNow, monthNow, dayNow].join(' ');

    var exists = false;
    var docId;
    docs.documents.forEach((e) {
      var date = new DateTime.fromMicrosecondsSinceEpoch(
          e.data['date'].seconds * 1000 * 1000);

      var year = date.year;
      var month = date.month;
      var day = date.day;

      if (nowDate == [year, month, day].join(' ')) {
        exists = true;
        docId = e.documentID;
      }
    });

    if (exists) {
      return getSingleDailyLog(uid, docId);
    }

    var ref2 = await db
        .collection('dailyLog')
        .document(uid)
        .collection('days')
        .add({'complete': [], 'mood': -1, 'date': DateTime.now()});

    var doc = await ref2.get();

    return DailyLog.fromFirestore(doc);
  }

  Stream<List<DailyLog>> streamDailyLog(String uid) {
    var ref = db
        .collection('dailyLog')
        .document(uid)
        .collection('days')
        .orderBy('date', descending: true);

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => DailyLog.fromFirestore(doc)).toList());
  }

  Stream<DailyLog> streamSingleDailyLog(String uid, String logId) {
    return db
        .collection('dailyLog')
        .document(uid)
        .collection('days')
        .document(logId)
        .snapshots()
        .map((doc) => DailyLog.fromFirestore(doc));
  }

  Future<DailyLog> getSingleDailyLog(String uid, String logId) async {
    var doc = await db
        .collection('dailyLog')
        .document(uid)
        .collection('days')
        .document(logId)
        .get();

    return DailyLog.fromFirestore(doc);
  }

  Future<DailyLog> getDailyLog(String id) async {
    var snap = await db.collection('daily-log').document(id).get();

    return DailyLog.fromMap(snap.data);
  }

  Future<void> updateDailyLog(String uid, DailyLog dailyLog) {
    DocumentReference ref = db
        .collection('dailyLog')
        .document(uid)
        .collection('days')
        .document(dailyLog.id);

    return ref.setData({
      'complete': dailyLog.complete,
      'mood': dailyLog.mood,
    }, merge: true);
  }

  /// Points logic
  Stream<int> streamPoints(String uid) {
    return db
        .collection('points')
        .document(uid)
        .snapshots()
        .map((snap) => snap.data['points'] ?? 0);
  }

  Future<int> getPoints(String uid) async {
    var snap = await db.collection('points').document(uid).get();

    return snap.data['points'] ?? 0;
  }

  Future<void> addPoint(String uid) async {
    DocumentReference ref = db.collection('points').document(uid);

    return ref.setData({'points': FieldValue.increment(1)}, merge: true);
  }

  Future<void> removePoint(String uid) async {
    DocumentReference ref = db.collection('points').document(uid);

    return ref.setData({'points': FieldValue.increment(-1)}, merge: true);
  }
}
