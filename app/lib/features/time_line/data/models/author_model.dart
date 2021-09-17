import 'package:mozin/features/time_line/domain/entities/author_entity.dart';

class AuthorModel {
  String? id;
  String? name;
  String? photo;
  String? email;

  AuthorModel({this.id, this.name, this.photo, this.email});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "photo": photo,
      "email": email,
    };
  }

  static AuthorModel fromEntity(AuthorEntity entity) {
    return AuthorModel(
      id: entity.id,
      name: entity.name,
      photo: entity.photo,
      email: entity.email,
    );
  }
}
