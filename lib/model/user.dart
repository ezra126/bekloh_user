import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePic;
  final String rating;

  User(this.id, this.firstName, this.lastName, this.email, this.phoneNumber, this.profilePic, this.rating);

  User.named(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.profilePic,
        this.rating});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName= json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        phoneNumber = json[' phoneNumber'],
        profilePic = json['profilePic'],
        rating = json['rating'];

  Map<String, dynamic> toJson() =>
      {
        'id' : this.id,
        'firstName': this.firstName,
        'lastName': this.lastName,
        'email': this.email,
        'phoneNumber': this.phoneNumber,
        ' profilePic': this.profilePic,
        'rating': this.rating,

      };

  @override
  List<Object> get props =>
      [id, firstName,lastName,email,phoneNumber,profilePic,rating];
}