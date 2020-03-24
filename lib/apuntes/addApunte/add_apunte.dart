import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

import 'bloc/add_bloc_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  AddBlocBloc _bloc;
  File _choosenImage;
  String _url;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Agregar apunte")),
        body: BlocProvider(
          create: (_) {
            _bloc = AddBlocBloc()..add(InitialEvent());
            return _bloc;
          },
          child: BlocListener<AddBlocBloc, AddBlocState>(
            listener: (_, state) {
              if (state is LoadImageState) {
                Scaffold.of(_)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Cargando imagen..."),
                  ));
              } else if (state is LoadImageErrorState) {
                Scaffold.of(_)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("No se puede cargar imagen..."),
                  ));
              } else if (state is SaveImageState) {
                Scaffold.of(_)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Guardando imagen..."),
                  ));
              } else if (state is SaveImageErrorState) {
                Scaffold.of(_)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("No se pudo guardar la imagen..."),
                  ));
              }
            },
            child: BlocBuilder<AddBlocBloc, AddBlocState>(builder: (_, state) {
              if (state is LoadImageState) {
                _choosenImage = state.img;
              } else if (state is SaveImageState) {
                _url = state.img;
                _saveData();
              }
              return _body();
            }),
          ),
        ));
  }

  void _saveData() {
    BlocProvider.of<ApuntesBloc>(context).add(
      SaveDataEvent(
        materia: _materiaController.text,
        descripcion: _descripcionController.text,
        imageUrl: _url,
      ),
    );
    _isLoading = false;

    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _choosenImage != null
                    ? Image.file(
                        _choosenImage,
                        width: 150,
                        height: 150,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        child: Placeholder(
                          fallbackHeight: 150,
                          fallbackWidth: 150,
                        ),
                      ),
                SizedBox(height: 48),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    _bloc.add(ChooseImageEvent());
                  },
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _materiaController,
                  decoration: InputDecoration(
                    hintText: "Nombre de la materia",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _descripcionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Notas para el examen...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Guardar"),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _bloc.add(SaveImageEvent(img: _choosenImage));
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            _isLoading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}
