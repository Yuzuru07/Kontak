import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDservice {
  User? user = FirebaseAuth.instance.currentUser;

  // Tambah kontak ke Firestore
  Future addNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Doc added");
    } catch (e) {
      print(e.toString());
    }
  }
}
