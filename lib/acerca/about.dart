import 'package:flutter/material.dart';
import 'package:practica_dos/acerca/email.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Descripcion:\nEsta aplicacion permite a el usuario poder logearse por su cuenta de correo de Gmail"+
              " ademas de poder registrar 'materias' con fotografia y descripcion, las cuales pueden ser vistas con detalle"+
              " por el usuario, siendo de esa manera se pueden visualisar a manera de lista y eliminar los elementos que se deseen "+
              "y por ultimo permite mandar un correo con la direccion que se ingrese.",
              style: TextStyle(
                fontSize: 18
              ),  
            ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Desarrollado por Kenet Gaona",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(
                height: 18,
              ),
              MaterialButton(
            minWidth: 150,
            color: Colors.blueGrey[100] ,
            child: Text(
              "Email",
              style: TextStyle(
                fontSize: 18
              ),
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Email()));
            }),
          ],
        ),
      ),
    );
  }
}
