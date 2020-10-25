import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

//@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

}

class Authenticated extends AuthenticationState {
  final FirebaseUser user;

  Authenticated(this.user) ;

  @override
  String toString() => 'Authenticated ';

  @override
  List<Object> get props => [user];

}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

}