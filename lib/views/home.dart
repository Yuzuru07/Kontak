import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kontak/controllers/auth_service.dart';
import 'package:kontak/controllers/crud_service.dart';
import 'package:kontak/views/update_contact_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _stream;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchfocusNode = FocusNode();

  @override
  void initState() {
    _stream = CRUDservice().getContact();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  // Telpon kontak menggunakan url_launcher
  callUser(String phone) async {
    String url = "tel:$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Tidak bisa menjalankan $url ";
    }
  }

  // FUngsi search untuk menjalankannya
  searchContacts(String search) {
    _stream = CRUDservice().getContact(searchQuery: search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quantum Connect"),
        // Search bar
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width * 8, 80),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    onChanged: (value) {
                      searchContacts(value);
                      setState(() {});
                    },
                    focusNode: _searchfocusNode,
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: const Text("Cari"),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _searchfocusNode.unfocus();
                                  _stream = CRUDservice().getContact();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close),
                              )
                            : null),
                  )),
            )),
      ),
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
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Ada yg emror");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Memuat..."));
            }
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text("Kontak tidak ditemukan..."),
                  )
                : ListView(
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
                                onPressed: () {
                                  callUser(data["phone"]);
                                },
                                icon: const Icon(Icons.call)),
                          );
                        })
                        .toList()
                        .cast(),
                  );
          }),
    );
  }
}
