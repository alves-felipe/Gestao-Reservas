

import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/default_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reservas_mobile/utils/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  _submitLoginForm() async {
    final username = login.text;
    final senha = password.text;

    Map<String, String> user = {
      "strategy": "local",
      "email": username,
      "password": senha,
    };
    
    globals.accessToken = await getAcessToken(user);

    if (globals.accessToken != '') {
      Navigator.pushNamed(context, "/reservas");
    }
  }

  Future<String> getAcessToken(body) async {
    var resp;
    try {
      resp = await http.post(
        Uri.parse('http://172.20.0.1:3030/authentication'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );
      resp = resp.bodyBytes;

      var parsed = json.decode(utf8.decode(resp));

      print(parsed);
      if (parsed["accessToken"] != null) {
        globals.userId = parsed["user"]["id"];
        return parsed["accessToken"];
      } else {
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...[
              DefaulInput(
                controller: login,
                label: "Email",
              ),
              DefaulInput(
                controller: password,
                label: "Password",
                isPassword: true,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyHomePage()));
                  _submitLoginForm();
                },
                child: const Text('Entrar'),
              ),
            ]
                .map((widget) => Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                      child: widget,
                    ))
                .toList(),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
