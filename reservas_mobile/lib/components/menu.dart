import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MenuWidget> {
  logout(context) async {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: SizedBox(height: 1,)
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          title: const Row(
            children: [
              Icon(Icons.flight),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Voos'),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/reservas');
          },
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          title: const Row(
            children: [
              Icon(Icons.person),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Users'),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/users');
          },
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          title: const Row(
            children: [
              Icon(Icons.person),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Relatório'),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/relatorio');
          },
        ),
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          title: const Row(
            children: [
              Icon(Icons.power_settings_new),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sair'),
              )
            ],
          ),
          onTap: () {
            // Update the state of the app.
            // ...
            logout(context);
          },
        ),
      ],
    );
  }
}
