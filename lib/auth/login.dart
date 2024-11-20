import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220140/auth/register.dart';
import 'package:responsi_124220140/hive/boxes.dart';
import 'package:responsi_124220140/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userBox = Hive.box('user');
  }

  Future<void> login(String usn) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Field tidak boleh kosong')));
      return;
    }

    // Mendapatkan data pengguna dari Hive sebagai User
    final user = userBox.get(username);
    final userpass = userBox.get(password);

    if (user != null && userpass == password) {
      // Shared Preferences sebagai session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', usn);
      // Login berhasil
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login berhasil')));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // Login gagal
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username atau password salah')));
    }
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
                    'Login',
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
                          login(_usernameController.text);
                        },
                        child: const Text('Login')),
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
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text('Register')),
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
