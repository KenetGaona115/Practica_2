import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/models/todo_remainder.dart';
import 'package:practica_dos/recordatorios/reminder_body.dart';

import 'bloc/reminder_bloc.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage({Key key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  ReminderBloc _reminderBloc;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _todoTextController = TextEditingController();
  TimeOfDay _horario;

  @override
  void dispose() {
    // cerrar bloc
    _reminderBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: BlocProvider(
        create: (context) {
          _reminderBloc = ReminderBloc();
          return _reminderBloc;
        },
        child: BlocBuilder<ReminderBloc, ReminderState>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              _reminderBloc.add(OnLoadRemindersEvent());
            }
            return HomeBody(
              homeState: state,
              homeBloc: _reminderBloc,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              // para refrescar la botton sheet en caso de ser necesario
              builder: (context, setModalState) =>
                  _bottomSheet(context, setModalState),
            ),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
          ).then(
            (result) {
              if (result != null)
                _reminderBloc.add(OnAddElementEvent(todoReminder: result));
            },
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_circle),
      ),
    );
  }

  Widget _bottomSheet(BuildContext context, StateSetter setModalState) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Agrega recordatorio",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: _todoTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.text_fields,
                  color: Colors.black,
                ),
                labelText: "Ingrese actividad",
                labelStyle: TextStyle(color: Colors.black87),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () async {
                    await _selectTime(context).then((_) {
                      setModalState(() {});
                    });
                    // refreshes modal bottom sheet with new hour value
                  },
                ),
                Text(
                  _horario == null
                      ? "Seleccione horario"
                      : "${_horario.hour}:${_horario.minute}",
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            MaterialButton(
              child: Text("Guardar"),
              onPressed: () {
                Navigator.of(context).pop(
                  TodoReminder(
                    todoDescription: "${_todoTextController.text}",
                    hour: "${_horario.format(context)}",
                  ),
                );
                _todoTextController.clear();
                _horario = null;
              },
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (time) {
        if (time != null) {
          _horario = time;
        }
      },
    );
  }
}
