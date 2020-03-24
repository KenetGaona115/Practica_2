import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/apunte_detalle.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> 
        ApunteDetalle(
          descripcion: widget.descripcion,
          imageUrl: widget.imageUrl,
          materia: widget.materia,
        )));
      },
          child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _showDialogConfirm();
                  },
                )
              ],
            ),
            Image.network(
              widget.imageUrl ?? "https://via.placeholder.com/150",
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            Container(
              child: Text(
                "${widget.materia}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text("${widget.descripcion}"),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _deleteItem() {
    BlocProvider.of<ApuntesBloc>(context).add(
      RemoveDataEvent(index: widget.index),
    );
  }

  void _showDialogConfirm(){
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("¿Desea borrar este elemento?"),
          actions: <Widget>[
            RaisedButton(
              child: Text("ACEPTAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ 
                _deleteItem();
                Navigator.of(context).pop(); 
              },
            ),
            RaisedButton(
              child: Text("CANCELAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ 
                Navigator.of(context).pop(); 
              },
            )
          ],
        );
      }
    );
  }
}
