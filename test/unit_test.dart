import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit/db.dart';
import 'package:habit/models.dart';


void main() {
  test("test create Habits instace from map", () {
    var mockData = {
      'id': '125abe',
      'habits': ['Some habit', 'Other habit']
    };

    expect(Habits.fromMap(mockData).id, '125abe');
    expect(Habits.fromMap(mockData).habits, ['Some habit', 'Other habit'].toList());
  });

  test("test create DailyLog instace from map", () {
    var mockData = {
      'id': '125abe',
      'complete': ['Some habit', 'Other habit'],
      'date': Timestamp(0, 0),
    };

    expect(DailyLog.fromMap(mockData).id, '125abe');
    expect(DailyLog.fromMap(mockData).complete, ['Some habit', 'Other habit'].toList());
    expect(DailyLog.fromMap(mockData).date, Timestamp(0, 0));
  });

}
