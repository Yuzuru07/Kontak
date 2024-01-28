import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPG extends StatefulWidget {
  const LoginPG({super.key});

  @override
  State<LoginPG> createState() => _LoginPGState();
}

class _LoginPGState extends State<LoginPG> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Quantum Connect!",
            style: GoogleFonts.sora(fontSize: 33, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 103,
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
                  "Login",
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
              const Text("Tidak punya akun?"),
              TextButton(onPressed: () {}, child: const Text("Sign Up"))
            ],
          )
        ],
      ),
    );
  }
}
