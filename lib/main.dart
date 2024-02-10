import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kontak/controllers/auth_service.dart';
import 'package:kontak/firebase_options.dart';
import 'package:kontak/views/add_contact_page.dart';
import 'package:kontak/views/home.dart';
import 'package:kontak/views/login_page.dart';
import 'package:kontak/views/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: 'Quantum Connect',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.soraTextTheme(),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
      useMaterial3: true,
    ),
    routes: {
      "/": (context) => const CheckUser(),
      "/home": (context) => const HomePage(),
      "/signup": (context) => const SignUpPG(),
      "/login": (context) => const LoginPG(),
      "/add": (context) => const AddContact()
    },
  ));
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
