part of 'create_store_bloc.dart';

abstract class CreateStoreState extends Equatable {
  const CreateStoreState();
}

class CreateStoreInitial extends CreateStoreState {
  @override
  List<Object> get props => [];
}

class CreateStoreSuccess extends CreateStoreState {
  const CreateStoreSuccess();

  List<Object?> get props => [];
}

class CreateStoreFailure extends CreateStoreState {
  const CreateStoreFailure();

  List<Object?> get props => [];
}

class CreateStoreInProgress extends CreateStoreState {
  const CreateStoreInProgress();

  List<Object?> get props => [];
}
