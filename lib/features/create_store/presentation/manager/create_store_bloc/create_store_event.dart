part of 'create_store_bloc.dart';

abstract class CreateStoreEvent extends Equatable {
  const CreateStoreEvent();
}

class CreateStoreRequested extends CreateStoreEvent {
  final EditableProfileInfo profileInfo;

  const CreateStoreRequested(this.profileInfo);

  @override
  List<Object?> get props => [profileInfo];
}
