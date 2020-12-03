import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationBloc extends Cubit<int>{
  NavigationBloc() : super(0);
  void makeIndexToMyOrder() => emit(state+1);
  void makeIndexToHome() => emit(0);
  void makeIndexToAccount() => emit(state+2);
}



