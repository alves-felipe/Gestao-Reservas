import 'package:flutter/material.dart';
import 'package:reservas_mobile/components/default_input.dart';
import 'package:reservas_mobile/components/menu.dart';
import 'package:http/http.dart' as http;
import 'package:reservas_mobile/components/select_form.dart';
import '../utils/globals.dart' as globals;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({super.key});

  @override
  ReservasPageState createState() => ReservasPageState();
}

class ReservasPageState extends State<ReservasPage> {
  final TextEditingController origem = TextEditingController();
  final TextEditingController destino = TextEditingController();

  Future<List>? fiscalizacoes;

  int? origemId;
  int? destinoId;

  var disponiveis;
  var itens = [];

  Future<List> listDisponiveis() async {
    var resp;

    resp = await http.get(
      Uri.parse('http://192.168.116.75:3030/aeroportos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}'
      },
    );
    resp = resp.bodyBytes;
    var parsed = json.decode(utf8.decode(resp));

    return parsed['data'];
  }

  showModal(context, title, field, items) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              ...[
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
              ]
                  .map((widget) => Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: widget,
                      ))
                  .toList(),
              Container(
                height: 250,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          items[index].runtimeType == String
                              ? items[index]
                              : items[index]["name"],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (title == "Origem") {
                          origemId = items[index]['id'];
                          field.text = items[index]['name'];
                          } else {
                            destinoId = items[index]['id'];
                            field.text = items[index]['name'];
                          }
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
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

                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: double.infinity,
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
                                    Expanded(
                                      child: SelectForm(
                                        controller: origem,
                                        hintText: 'Origem',
                                        tap: showModal,
                                        options: lista,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SelectForm(
                                        controller: destino,
                                        hintText: 'Destino',
                                        tap: showModal,
                                        options: lista,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(100, 50),
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    foregroundColor: Colors.white,
                                    textStyle: const TextStyle(fontSize: 18),
                                    backgroundColor:
                                        Color.fromARGB(255, 234, 210, 75),
                                  ),
                                  onPressed: () {
                                    // editUser(id);
                                    print('okkkkkkk $origemId, $destinoId');
                                    globals.origemId = origemId;
                                    globals.destinoId = destinoId;
                                    Navigator.pushNamed(context, "/reservas/voos");
                                  },
                                  child: const Center(
                                    child: Text('Buscar'),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
