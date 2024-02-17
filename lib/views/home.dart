import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kontak/controllers/auth_service.dart';
import 'package:kontak/controllers/crud_service.dart';
import 'package:kontak/views/update_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quantum Connect")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        child: const Icon(Icons.person_add_alt_1_rounded),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 33,
                  child: Text(FirebaseAuth.instance.currentUser!.email
                      .toString()[0]
                      .toUpperCase()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(FirebaseAuth.instance.currentUser!.email.toString())
              ],
            )),
            ListTile(
              onTap: () {
                AuthService().logout();
                Navigator.pushReplacementNamed(context, "/login");
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logout berhasil")));
              },
              leading: const Icon(Icons.logout_outlined),
              title: const Text("Logout"),
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: CRUDservice().getContact(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Ada yg emror");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Memuat..."));
            }
            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateContact(
                                    docID: document.id,
                                    name: data["name"],
                                    phone: data["phone"],
                                    email: data["email"],
                                  ))),
                      leading: CircleAvatar(
                        child: Text(data["name"][0]),
                      ),
                      title: Text(data["name"]),
                      subtitle: Text(data["phone"]),
                      trailing: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.call)),
                    );
                  })
                  .toList()
                  .cast(),
            );
          }),
    );
  }
}
