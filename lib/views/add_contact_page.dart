import 'package:flutter/material.dart';
import 'package:kontak/controllers/crud_service.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({super.key});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _phoneCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Kontak"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? "Nama tidak boleh kosong"
                          : null,
                      controller: _nameCont,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text("Nama")),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? "Nomor telepon tidak boleh kosong"
                          : null,
                      controller: _phoneCont,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("No Telp.")),
                    )),
                const SizedBox(
                  height: 30,
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
                  height: 43,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          CRUDservice().addNewContacts(
                              _nameCont.text, _phoneCont.text, _emailCont.text);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Tambahkan",
                        style: TextStyle(fontSize: 17),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
