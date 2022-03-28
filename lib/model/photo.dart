import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.photographer,
    required this.imageLarge,
    required this.imageOriginal,
  });

  final int id;
  final String photographer;
  final String imageLarge;
  final String imageOriginal;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json["id"],
      photographer: json["photographer"],
      imageLarge: json["src"]["large"],
      imageOriginal: json["src"]["original"],
    );
  }
  @override
  List<Object?> get props => [id, photographer, imageLarge, imageOriginal];
}
