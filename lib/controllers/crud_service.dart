import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDservice {
  User? user = FirebaseAuth.instance.currentUser;

  // Tambah kontak ke Firestore
  Future addNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("Doc Added");
    } catch (e) {
      print(e.toString());
    }
  }

  // Baca dokumen dari FireStore
  Stream<QuerySnapshot> getContact() async* {
    var contacts = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("contacts")
        .orderBy("name")
        .snapshots();

    yield* contacts;
  }

  // Update dokumen
  Future updateContact(
      String name, String phone, String email, String docID) async {
    Map<String, dynamic> data = {"name": name, "email": email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docID)
          .update(data);
      print("Document Upated");
    } catch (e) {
      print(e.toString());
    }
  }
}
