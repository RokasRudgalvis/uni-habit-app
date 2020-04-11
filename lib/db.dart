import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit/models.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<Habits> streamHabits(String uid) {
    return _db
        .collection('habits')
        .document(uid)
        .snapshots()
        .map((snap) => Habits.fromFirestore(snap));
  }

  Future<Habits> getHabits(String id) async {
    var snap = await _db.collection('habits').document(id).get();

    return Habits.fromMap(snap.data);
  }

  Future<void> updateHabits(Habits habits) {
    DocumentReference ref = _db.collection('habits').document(habits.id);

    return ref.updateData({'habits': habits.habits});
  }

  Stream<List<DailyLog>> streamDailyLog(String uid) {
    var ref = _db.collection('dailyLog').document('azQGM1JCeBVoLFpFPr1C68wv1x73').collection('days');

    return ref.snapshots().map(
      (list) => list.documents.map((doc) => DailyLog.fromFirestore(doc)).toList());
  }

  Future<DailyLog> getDailyLog(String id) async {
    var snap = await _db.collection('daily-log').document(id).get();

    return DailyLog.fromMap(snap.data);
  }

  Future<void> updateDailyLog(DailyLog habits) {
    DocumentReference ref = _db.collection('daily-log').document(habits.id);

    return ref.updateData({'complete': habits.complete});
  }
}
