import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/menu.dart';
import 'package:http/http.dart' as http;
import '../utils/globals.dart' as globals;
import 'dart:convert';

class RelatorioPage extends StatefulWidget {
  const RelatorioPage({super.key});

  @override
  RelatorioPageState createState() => RelatorioPageState();
}

class RelatorioPageState extends State<RelatorioPage> {
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
      Uri.parse('http://192.168.116.75:3030/passagens'),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}'
      },
    );
    resp = resp.bodyBytes;
    var parsed = json.decode(utf8.decode(resp));

    return parsed;
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
                                  final voos = (post['count(assento)'] ?? '');

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
                                                Text('Usuário:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(' $nPasta'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Quantidade de voos comprados:', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(' $voos'),
                                              ],
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
