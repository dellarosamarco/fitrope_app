import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrope_app/types/course.dart';

class FitropeUser {
  final String uid;
  final String name;
  final String lastName;
  final List<Course> courses;
  final TipologiaIscrizione? tipologiaIscrizione;
  final int? entrateDisponibili;
  final Timestamp? inizioIscrizione;
  final Timestamp? fineIscrizione;

  const FitropeUser({
    required this.name, 
    required this.lastName, 
    required this.uid, 
    required this.courses, 
    this.tipologiaIscrizione, 
    this.entrateDisponibili,
    this.inizioIscrizione, 
    this.fineIscrizione
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'lastName': lastName,
      'courses': courses.map((course) => course.toJson()).toList(),
      'tipologiaIscrizione': tipologiaIscrizione?.toString().split('.').last,
      'entrateDisponibili': entrateDisponibili,
      'inizioIscrizione': inizioIscrizione,
      'fineIscrizione': fineIscrizione,
    };
  }

  factory FitropeUser.fromJson(Map<String, dynamic> json) {
    return FitropeUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      courses: (json['courses'] as List<dynamic>)
          .map((courseJson) => Course.fromJson(courseJson as Map<String, dynamic>))
          .toList(),
      tipologiaIscrizione: json['tipologiaIscrizione'] != null 
          ? TipologiaIscrizione.values.firstWhere((e) => e.toString().split('.').last == json['tipologiaIscrizione']) 
          : null,
      entrateDisponibili: json['entrateDisponibili'] as int?,
      inizioIscrizione: json['inizioIscrizione'] as Timestamp?,
      fineIscrizione: json['fineIscrizione'] as Timestamp?,
    );
  }
}

enum TipologiaIscrizione {
  PACCHETTO_ENTRATE,
  ABBONAMENTO
}