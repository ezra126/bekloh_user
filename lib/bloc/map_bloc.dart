import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class MapBloc extends Cubit<MapState>{
  MapBloc() : super(MapOnLoadingState());
  void mapLoaded() => emit(MapLoadedState());
}

abstract class MapState extends Equatable{
  MapState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MapOnLoadingState extends MapState{}

class MapLoadedState extends MapState{}