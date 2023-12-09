import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/default_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reservas_mobile/utils/globals.dart' as globals;

class UsersCreatePage extends StatefulWidget {
  const UsersCreatePage({super.key});

  @override
  UsersCreatePageState createState() => UsersCreatePageState();
}

class UsersCreatePageState extends State<UsersCreatePage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  void editUser(Map body) async {
    await http.post(
      Uri.parse('http://192.168.116.75:3030/users'),
      body: body,
      // headers: {
      //   'Authorization': 'Bearer ${globals.accessToken}'
      // },
    );
    Navigator.pushNamed(context, "/users");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 18),
              backgroundColor: Colors.deepPurple,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            editUser({
              'name': name.text == '' ? '' : name.text,
              'password': password.text == '' ? '' : password.text,
              'email': email.text == '' ? '' : email.text
            });
          },
          child: const Text('Criar'),
        ),
      ),
      drawer: const Drawer(
          // child: MenuWidget(),
          ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ...[
              SizedBox(
                height: 10,
              ),
              DefaulInput(
                controller: email,
                label: "Email",
              ),
              DefaulInput(
                controller: name,
                label: "Nome",
              ),
              DefaulInput(
                controller: password,
                label: "Password",
                isPassword: true,
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
