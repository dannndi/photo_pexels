import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"]);
  }

  @override
  List<Object?> get props => [id, name];
}
