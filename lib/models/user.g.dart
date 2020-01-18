// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    createdAt: BaseClass.convertTimestampToDateTime(json['created_at']),
    modifiedAt: BaseClass.convertTimestampToDateTime(json['modified_at']),
    location: json['location'] as String,
    adoptedTrees:
        (json['adopted_trees'] as List)?.map((e) => e as String)?.toList(),
    visitedTrees:
        (json['visited_trees'] as List)?.map((e) => e as String)?.toList(),
    isDarkTheme: json['is_dark_theme'] as bool,
  )..name = json['name'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', BaseClass.setDateTime(instance.createdAt));
  writeNotNull('modified_at', BaseClass.setDateTime(instance.modifiedAt));
  val['name'] = instance.name;
  val['location'] = instance.location;
  val['adopted_trees'] = instance.adoptedTrees;
  val['visited_trees'] = instance.visitedTrees;
  val['is_dark_theme'] = instance.isDarkTheme;
  return val;
}
