import 'package:flutter/material.dart';

enum NotificationType {
  all,
  specific
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationType _notify = NotificationType.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações')
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Notificações',
                  style: TextStyle(
                    fontSize: 20
                  )
                )
              ),
              RadioListTile<NotificationType>(
                title: Text('Todos os eventos'),
                value: NotificationType.all,
                groupValue: this._notify,
                onChanged: (NotificationType? value) {
                  setState(() => this._notify = value!);
                }
              ),
              RadioListTile<NotificationType>(
                title: Text('Selecionar tipos'),
                value: NotificationType.specific,
                groupValue: this._notify,
                onChanged: (NotificationType? value) {
                  setState(() => this._notify = value!);
                }
              ),
            ]
          )
        )
      )
    );
  }
}