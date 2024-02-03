import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kontak/controllers/auth_service.dart';

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
    );
  }
}
