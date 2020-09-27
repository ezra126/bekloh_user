import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) ;

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  String toString() => 'PasswordChanged { password: $password }';
}



class Submitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;

  Submitted({@required this.email,@required this.firstName,@required this.lastName, @required this.password,@required this.phoneNumber});

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}