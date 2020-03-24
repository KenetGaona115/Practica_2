part of 'add_bloc_bloc.dart';

abstract class AddBlocState extends Equatable {
  const AddBlocState();
}

class AddBlocInitial extends AddBlocState {
  @override
  List<Object> get props => [];
}

class LoadImageState extends AddBlocState {
  final File img;

  LoadImageState({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props => [img];
  
}

class LoadImageErrorState extends AddBlocState {
  final String err;

  LoadImageErrorState({@required this.err});
  @override
  // TODO: implement props
  List<Object> get props => [err];
  
}

//Guardar en la base de datos
class SaveImageState extends AddBlocState {
  final String img;

  SaveImageState({@required this.img});
  @override
  // TODO: implement props
  List<Object> get props => [img];
  
}

class SaveImageErrorState extends AddBlocState {
  final String err;

  SaveImageErrorState({@required this.err});
  @override
  // TODO: implement props
  List<Object> get props => [err];
  
}

