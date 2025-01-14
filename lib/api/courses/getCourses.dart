import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitrope_app/types/course.dart';

Future<List<Course>> getAllCourses() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('courses');
  QuerySnapshot querySnapshot = await collectionRef.get();

  List<Course> courses = [];

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    if((doc.data() as Map<String, dynamic>)['id'] != null) {
      Course course = Course.fromJson(doc.data() as Map<String, dynamic>);
      courses.add(course);
    }
  }

  return courses;
}