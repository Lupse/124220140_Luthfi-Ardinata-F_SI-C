import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220140/auth/login.dart';
import 'package:responsi_124220140/hive/boxes.dart';
import 'package:responsi_124220140/hive/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('user');
  }

  // Fungsi untuk registrasi pengguna baru
  void register() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Field tidak boleh kosong')));
      return;
    }

    if (userBox.containsKey(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username sudah terdaftar')));
      return;
    }

    // Menyimpan data pengguna ke Hive
    userBox.put(username, password);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 375,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        label: Text('Username'), border: OutlineInputBorder()),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        label: Text('password'), border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: () {
                          register();
                        },
                        child: const Text('Register')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text('Login')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
