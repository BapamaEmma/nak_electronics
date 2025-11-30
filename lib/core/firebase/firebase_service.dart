import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;

  // Add helper methods here as needed
  static Future<void> signInAnonymously() async {
    await auth.signInAnonymously();
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static User? get currentUser => auth.currentUser;

  static Stream<User?> get authStateChanges => auth.authStateChanges();
}
