import 'dart:async';

import 'package:bloc/bloc.dart';
import  'package:bekloh_user/bloc/authbloc/auth_event.dart';
import  'package:bekloh_user/bloc/authbloc/auth_state.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(null);

  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield Authenticated('dd');
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
   yield Uninitialized();
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
  //  print('hello');
    yield Authenticated("hello");

  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    //_userRepository.signOut();
  }
}