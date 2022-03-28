import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final String id;
  final String title;

  const Collection({required this.id, required this.title});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(id: json["id"], title: json["title"]);
  }

  @override
  List<Object?> get props => [];
}
