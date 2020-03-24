import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'add_bloc_event.dart';
part 'add_bloc_state.dart';

class AddBlocBloc extends Bloc<AddBlocEvent, AddBlocState> {
  File _choosenImage;
  String _url;
  @override
  AddBlocState get initialState => AddBlocInitial();

  @override
  Stream<AddBlocState> mapEventToState(
    AddBlocEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is InitialEvent) {
      yield AddBlocInitial();
    } else if (event is ChooseImageEvent) {
      if (await _chooseImage()) {
        yield LoadImageState(img: _choosenImage);
      } else
        yield LoadImageErrorState(err: "No se pudo cargar la imagen");
    } else if (event is SaveImageEvent) {
      if (await _uploadFile()) {
        yield SaveImageState(img: _url);
      }else
      yield SaveImageErrorState(err: "No se pudo guardar la imagen");
    }
  }

  Future<bool> _chooseImage() async {
    try {
      await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 720,
        maxWidth: 720,
      ).then((image) {
        _choosenImage = image;
      });
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> _uploadFile() async {
    try {
      String filePath = _choosenImage.path;
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("apuntes/${Path.basename(filePath)}");
      StorageUploadTask uploadTask = reference.putFile(_choosenImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        print("Link>>>>> $imageUrl");
      });

      await reference.getDownloadURL().then((fileURL) {
        print("$fileURL");
        _url = fileURL;
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
