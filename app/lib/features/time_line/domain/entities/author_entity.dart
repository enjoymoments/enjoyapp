import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String id;
  final String name;
  final String photo;
  final String email;

  const AuthorEntity(this.id, this.name, this.photo, this.email);

  static AuthorEntity fromSnapshot(Map<String, dynamic> map) {
    return AuthorEntity(
      map['id'],
      map['name'],
      map['photo'],
      map['email'],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        photo,
        email,
      ];
}
