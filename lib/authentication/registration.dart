// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitrope_app/api/getUserData.dart';
import 'package:fitrope_app/types/fitropeUser.dart';

Future<FitropeUser?> registerWithEmailPassword(String email, String password, String name, String lastName) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'name': name,
      'lastName': lastName,
      'courses': [],
      'tipologiaIscrizione': null,
      'entrateDisponibili': 0,
      'entrateSettimanali': 0,
      'fineIscrizione': null
    });

    Map<String, dynamic>? userData = await getUserData(uid);

    if(userData != null) {
      return FitropeUser.fromJson(userData);
    }

    print("User registered: ${userCredential.user!.email}");
  } 
  on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } 
    else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } 
    else {
      print(e.message);
    }
  } 
  catch (e) {
    print(e);
  }
  
  return null;
}