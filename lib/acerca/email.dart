import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  _sendEmail() {
    final String _email = 'mailto:' +
        _emailController.text +
        '?subject=' +
        _subjectController.text +
        '&body=' +
        _bodyController.text;
    try {
      launch(_email);
    } catch (e) {
      throw 'No se pudo enviar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacto')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              Text(
                "Llene el formulario a continuacion",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: _subjectController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Asunto',
                ),
              ),
              TextField(
                controller: _bodyController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Mensaje',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text('Enviar Email'),
                color: Colors.blueGrey[51],
                onPressed: _sendEmail,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Desarrollado por Kenet Gaona",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
