import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ApunteDetalle extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;

  ApunteDetalle(
      {Key key,
      @required this.imageUrl,
      @required this.materia,
      @required this.descripcion})
      : super(key: key);

  @override
  _ApunteDetalleState createState() => _ApunteDetalleState();
}

class _ApunteDetalleState extends State<ApunteDetalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle ${widget.materia}"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 250,
                height: 250,
                child: PhotoView(imageProvider: NetworkImage(widget.imageUrl)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "${widget.materia}",
                        style:
                            TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.descripcion}",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
