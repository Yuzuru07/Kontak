import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPG extends StatefulWidget {
  const LoginPG({super.key});

  @override
  State<LoginPG> createState() => _LoginPGState();
}

class _LoginPGState extends State<LoginPG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          Text(
            "Login Page",
            style: GoogleFonts.sora(fontSize: 43, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 13,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email")),
              )),
          const SizedBox(
            height: 17,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Password")),
              )),
        ],
      ),
    );
  }
}
