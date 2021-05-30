import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;

  const User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.username,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'] as String,
      firstName: json['id'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }

  static const empty = const User(
    id: "-",
    firstName: "-",
    lastName: "-",
    email: "-",
    username: "-",
  );

  @override
  List<Object> get props => [id, firstName, lastName, email, username];

  toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
    };
  }
}
