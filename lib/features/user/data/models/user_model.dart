import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:logique_test/core/local/local_constants.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: LocalTypes.user)
class UserModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? firstName;
  @HiveField(3)
  final String? lastName;
  @HiveField(4)
  final String? picture;

  const UserModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        title: user.title,
        picture: user.picture,
        firstName: user.firstName,
        lastName: user.lastName,
      );

  User toEntity() => User(
        id: id,
        title: title,
        picture: picture,
        firstName: firstName,
        lastName: lastName,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        title: json['title'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        picture: json['picture'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'picture': picture,
      };

  @override
  List<Object?> get props => [id, title, firstName, lastName, picture];
}
