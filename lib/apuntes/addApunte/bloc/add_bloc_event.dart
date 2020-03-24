part of 'add_bloc_bloc.dart';

abstract class AddBlocEvent extends Equatable {
  const AddBlocEvent();
}

class InitialEvent extends AddBlocEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class ChooseImageEvent extends AddBlocEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
  
}

class SaveImageEvent extends AddBlocEvent {
  final File img;
  SaveImageEvent({@required this.img});

  @override
  // TODO: implement props
  List<Object> get props => [img];
  
}