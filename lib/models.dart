import 'package:cloud_firestore/cloud_firestore.dart';

class Habits {
  final String id;
  final List<String> habits;

  Habits({this.id, this.habits});

  factory Habits.fromMap(Map data) {
    return Habits(
        id: data['id'] ?? '-1',
        habits: List.from(data['habits']) ?? List.from([]));
  }

  factory Habits.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Habits(
      id: doc.documentID ?? '-1',
      habits: List.from(data['habits']) ?? List.from([]),
    );
  }
}

class DailyLog {
  final String id;
  final Timestamp date;
  final List<String> complete;
  int mood;

  DailyLog({this.id, this.mood, this.date, this.complete});

  factory DailyLog.fromMap(Map data) {
    return DailyLog(
      id: data['id'] ?? '-1',
      complete: List.from(data['complete']) ?? List.from([]),
      date: data['date'] ?? Timestamp(0, 0),
      mood: data['mood'] ?? -1,
    );
  }

  factory DailyLog.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return DailyLog(
      id: doc.documentID,
      date: doc['date'] ?? Timestamp(0, 0),
      mood: doc['mood'] ?? -1,
      complete: List.from(data['complete']) ?? List.from([]),
    );
  }
}
