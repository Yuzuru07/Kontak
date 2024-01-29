import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPG extends StatefulWidget {
  const SignUpPG({super.key});

  @override
  State<SignUpPG> createState() => _SignUpPGState();
}

class _SignUpPGState extends State<SignUpPG> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign Up",
            style: GoogleFonts.sora(fontSize: 53, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 80,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: TextFormField(
                controller: _emailCont,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Email")),
              )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: TextFormField(
                controller: _passCont,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Password")),
              )),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 43,
            width: 300,
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 17),
                )),
          ),
          const SizedBox(
            height: 27,
          ),
          SizedBox(
              height: 43,
              width: 300,
              child: OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/google.png",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Lanjut dengan Google",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ))),
          const SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sudah punya akun?"),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Login"))
            ],
          )
        ],
      ),
    );
  }
}
