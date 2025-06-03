import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kontak/controllers/auth_service.dart';

class LoginPG extends StatefulWidget {
  const LoginPG({super.key});

  @override
  State<LoginPG> createState() => _LoginPGState();
}

class _LoginPGState extends State<LoginPG> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: GoogleFonts.sora(fontSize: 53, fontWeight: FontWeight.w300)
                  .copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Email tidak boleh kosong!" : null,
                    controller: _emailCont,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Email")),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ))),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: TextFormField(
                    validator: (value) => value!.length < 8
                        ? "Password harus memiliki setidaknya 8 karakter."
                        : null,
                    controller: _passCont,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Password")),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ))),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 43,
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService()
                          .loginWithEmail(_emailCont.text, _passCont.text)
                          .then((value) {
                        if (value == "Login anda berhasil") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login berhasil")));
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade600,
                          ));
                        }
                      });
                    }
                  },
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
                    onPressed: () {
                      AuthService().continueWithGoogle().then((value) {
                        if (value == "Google login") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Login menggunakan Google berhasil!")));
                          Navigator.pushReplacementNamed(context, "/home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade600,
                          ));
                        }
                      });
                    },
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
                Text("Tidak punya akun?",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: const Text("Sign Up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
