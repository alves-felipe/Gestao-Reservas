import 'package:flutter/material.dart';
import 'package:reservas_mobile/screens/login.dart';
import 'package:reservas_mobile/screens/relatorio.dart';
import 'package:reservas_mobile/screens/reservas.dart';
import 'package:reservas_mobile/screens/reservas_detalhes.dart';
import 'package:reservas_mobile/screens/reservas_voos.dart';
import 'package:reservas_mobile/screens/users.dart';
import 'package:reservas_mobile/screens/users_create.dart';
import 'package:reservas_mobile/screens/users_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/home": (context) => const LoginPage(),
        "/users": (context) => const UsersPage(),
        "/users/edit": (context) => const UsersEditPage(),
        "/users/create": (context) => const UsersCreatePage(),
        "/reservas": (context) => const ReservasPage(),
        "/reservas/voos": (context) => const ReservasVoosPage(),
        "/reservas/detalhes": (context) => const ReservasDetalhesPage(),
        "/relatorio": (context) => const RelatorioPage(),
      },
      initialRoute: "/home",
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
