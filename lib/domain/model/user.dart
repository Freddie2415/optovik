import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final phone;

  const User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.username,
    @required this.phone,
  });

  static const empty =  const User(id: 0, firstName: "-", lastName: "-", email: "-", username: "-", phone: "-");

  @override
  List<Object> get props => [id, firstName, lastName, email, username, phone];
}
