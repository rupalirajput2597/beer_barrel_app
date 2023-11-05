import 'package:equatable/equatable.dart';

//user model
class User extends Equatable {
  final String? name;
  final String? email;
  final String? photoUrl;

  const User({
    this.email,
    this.name,
    this.photoUrl,
  });

  bool get isNotEmpty => name != null && email != null;

  @override
  List<Object?> get props => [email, name, photoUrl];
}
