import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ProfileUpdateBloc extends Cubit<ProfileUpdateState>{
  ProfileUpdateBloc() : super(ProfileUpdatingNotInitializedState());
  void submitEditingProfile() => emit(ProfileUpdatingNotInitializedState());
  void updateProfile() => emit(ProfileOnUpdatingState());

}

abstract class ProfileUpdateState extends Equatable{
  ProfileUpdateState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProfileUpdatingNotInitializedState extends ProfileUpdateState{}

class ProfileOnUpdatingState extends ProfileUpdateState{}