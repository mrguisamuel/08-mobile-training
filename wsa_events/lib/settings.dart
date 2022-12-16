import 'package:flutter/material.dart';

enum NotificationType {
  none,
  all,
  specific
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  NotificationType _notify = NotificationType.none;
  List<bool> _notifyTypes = [false, false, false];

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
                title: Text('Nenhum evento'),
                value: NotificationType.none,
                groupValue: this._notify,
                onChanged: (NotificationType? value) {
                  setState(() => this._notify = value!);
                }
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
              Visibility(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: const Text('Título'),
                      value: this._notifyTypes[0],
                      secondary: const Icon(Icons.account_tree_rounded),
                      onChanged: (bool? value) {
                        setState(() => this._notifyTypes[0] = value!);
                      }
                    ),
                    CheckboxListTile(
                      title: const Text('Descrição'),
                      value: this._notifyTypes[1],
                      secondary: const Icon(Icons.account_tree_rounded),
                      onChanged: (bool? value) {
                        setState(() => this._notifyTypes[1] = value!);
                      }
                    ),
                    CheckboxListTile(
                      title: const Text('Participantes'),
                      value: this._notifyTypes[2],
                      secondary: const Icon(Icons.account_tree_rounded),
                      onChanged: (bool? value) {
                        setState(() => this._notifyTypes[2] = value!);
                      }
                    ),
                  ]
                ),
                visible: this._notify == NotificationType.specific
              )
            ]
          )
        )
      )
    );
  }
}