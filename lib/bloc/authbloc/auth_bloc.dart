import 'dart:async';

import 'package:bloc/bloc.dart';
import  'package:bekloh_user/bloc/authbloc/auth_event.dart';
import  'package:bekloh_user/bloc/authbloc/auth_state.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationCubit({@required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(Uninitialized());

 // AuthenticationState get initialState => Uninitialized();

  void appStarted()  async {
   // emit(Authenticated(''));
  //  _mapAppStartedToState();
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        emit(Authenticated(name));

      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }
  void loggedIn() => emit(_mapLoggedInToState());
  void loggedOut() => emit( _mapLoggedOutToState());


 /* @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield Authenticated('dd');
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }
*/
  Stream<AuthenticationState> _mapAppStartedToState() async* {
    //  print('hhhhhhhhhhhhhhhhhhhhh');
     try {
       final isSignedIn = await _userRepository.isSignedIn();
       if (isSignedIn) {
         final name = await _userRepository.getUser();
         emit(Authenticated(name));

       } else {
         emit(Unauthenticated());
       }
     } catch (_) {
       emit(Unauthenticated());
     }
  }

   _mapLoggedInToState() async* {
    // print('hello');
     yield Authenticated('hf');

  }

   _mapLoggedOutToState() async* {
    print('hello hfhfhfhffh');
    yield Unauthenticated();
    _userRepository.signOut();
  }
}

/*

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

*/
