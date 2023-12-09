import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/menu.dart';
import 'package:http/http.dart' as http;
import '../utils/globals.dart' as globals;
import 'dart:convert';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  Future<List>? fiscalizacoes;

  var disponiveis;
  var itens = [];

  void editUser(userId) {
    globals.userEdit = userId;
    Navigator.pushNamed(context, "/users/edit");
  }

  Future<List> listDisponiveis() async {
    var resp;

    resp = await http.get(
      Uri.parse('http://192.168.116.75:3030/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      },
    );
    resp = resp.bodyBytes;
    var parsed = json.decode(utf8.decode(resp));

    return parsed['data'];
  }

  void deleteUser(id) async {
    await http.delete(
      Uri.parse('http://192.168.116.75:3030/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      },
    );

    fiscalizacoes = listDisponiveis();
    setState(() {});
  }

  void createUser () {
    Navigator.pushNamed(context, "/users/create");
  }

  @override
  void initState() {
    super.initState();
    fiscalizacoes = listDisponiveis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
          child: MenuWidget(),
          ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            fiscalizacoes = listDisponiveis();
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 0),
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Color.fromARGB(255, 21, 176, 49),
                  ),
                  onPressed: () async {
                    createUser();
                  },
                  child: const Center(
                    child: Text('Adicionar Usuário'),
                  ),
                ),
                SizedBox(height: 20,),
                FutureBuilder(
                  future: fiscalizacoes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      var lista = snapshot.data as List;

                      return lista.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: lista.length,
                                itemBuilder: (context, index) {
                                  final post = lista[index];

                                  final nPasta = (post['name'] ?? '');
                                  final email = (post['email'] ?? '');
                                  final id = (post['id'] ?? '');

                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            // offset: const Offset(0, 15),
                                          ).scale(1)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Nome:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(' $nPasta'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Email:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(' $email'),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(100, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 5, 20, 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor: Colors.white,
                                                textStyle: const TextStyle(
                                                    fontSize: 18),
                                                backgroundColor: Color.fromARGB(
                                                    255, 234, 210, 75),
                                              ),
                                              onPressed: () {
                                                editUser(id);
                                              },
                                              child: const Center(
                                                child: Text('Editar'),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(100, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 5, 20, 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                foregroundColor: Colors.white,
                                                textStyle: const TextStyle(
                                                    fontSize: 18),
                                                backgroundColor:
                                                    const Color(0xffac15b0),
                                              ),
                                              onPressed: () async {
                                                deleteUser(id);
                                                // setState(() {});
                                              },
                                              child: const Center(
                                                child: Text('Deletar'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 100, 181, 246),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              // color: Colors.blue[300],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 15, 10, 15),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 53, 142, 214),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                    child:
                                        Icon(Icons.info, color: Colors.white),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "---",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return const Text('erro');
                    } else {
                      return const Text('else');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
