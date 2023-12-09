import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/menu.dart';
import 'package:http/http.dart' as http;
import '../utils/globals.dart' as globals;
import 'dart:convert';
import 'package:intl/intl.dart';


class ReservasVoosPage extends StatefulWidget {
  const ReservasVoosPage({super.key});

  @override
  ReservasVoosPageState createState() => ReservasVoosPageState();
}

class ReservasVoosPageState extends State<ReservasVoosPage> {
  Future<List>? fiscalizacoes;

  var disponiveis;
  var itens = [];

  Future<List> listDisponiveis() async {
    var resp;

    resp = await http.get(
      Uri.parse('http://192.168.116.75:3030/voos').replace(queryParameters: {
        'origem': globals.origemId.toString(),
        'destino': globals.destinoId.toString()
      }),
      
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

                                  final horarioPartida = (post['horarioPartida'] ?? '');
                                  final horarioChegada = (post['horarioChegada'] ?? '');
                                  final valor = (post['valor'] ?? '');
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
                                                Text('Horário de saída: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(
                                                    '${DateFormat.Hm().format(DateTime.parse(horarioPartida))}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Horário de chegada: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(
                                                    '${DateFormat.Hm().format(DateTime.parse(horarioChegada))}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Valor: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(
                                                    'R\$ $valor'),
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
                                                globals.vooId = id;
                                                print('idddddddd: $id');
                                                Navigator.pushNamed(context, "/reservas/detalhes");
                                              },
                                              child: const Center(
                                                child: Text('Ver Detalhes'),
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
