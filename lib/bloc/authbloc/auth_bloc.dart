import 'dart:async';

import 'package:bloc/bloc.dart';
import  'package:bekloh_user/bloc/authbloc/auth_event.dart';
import  'package:bekloh_user/bloc/authbloc/auth_state.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        final FirebaseUser user = await _userRepository.getUser();
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }
  void loggedIn() async {
    emit(Authenticated(await _userRepository.getUser()));
  }
  Future<void> loggedOut() async {
    await _userRepository.signOut();
    final isSignedOut = await _userRepository.isSignOut();
    if(isSignedOut)
      emit(Unauthenticated());
  }


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
     try {
       final isSignedIn = await _userRepository.isSignedIn();
       if (isSignedIn) {
         final user = await _userRepository.getUser();
         emit(Authenticated(user));

       } else {
         emit(Unauthenticated());
       }
     } catch (_) {
       emit(Unauthenticated());
     }
  }


   _mapLoggedOutToState() async* {
    var isLoggedOut=false;
    _userRepository.signOut().then((value) {
      isLoggedOut=true;

    }
    );
  //  if(isLoggedOut== true) yield Unauthenticated();
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
