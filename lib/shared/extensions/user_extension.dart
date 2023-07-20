import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';

extension UserExt on User {
  String get name {
    final first = firstName;
    final last = lastName;
    final resultTitle = title?.toTitleCase();
    return '$resultTitle. $first $last';
  }
}

extension UserDetailExt on UserDetail {
  String get name {
    final first = firstName;
    final last = lastName;
    final resultTitle = title?.toTitleCase();
    return '$resultTitle. $first $last';
  }

  String get address {
    final country = location?.country;
    final state = location?.state;
    final street = location?.street;
    final city = location?.street;
    return '$country, $state, $street, $city';
  }
}
