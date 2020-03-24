part of 'apuntes_bloc.dart';

abstract class ApuntesState extends Equatable {
  const ApuntesState();
}

class ApuntesInitial extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends ApuntesState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends ApuntesState {
  @override
  List<Object> get props => [];
}
