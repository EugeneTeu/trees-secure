// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tree _$TreeFromJson(Map<String, dynamic> json) {
  return Tree(
    id: json['id'] as String,
    createdAt: BaseClass.convertTimestampToDateTime(json['created_at']),
    modifiedAt: BaseClass.convertTimestampToDateTime(json['modified_at']),
    commonName: json['common_name'] as String,
    uuid: json['uuid'] as String,
    location: json['location'] as String,
    scientificName: json['scientific_name'] as String,
    girth: json['girth'] as String,
    height: json['height'] as String,
  );
}

Map<String, dynamic> _$TreeToJson(Tree instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created_at', BaseClass.setDateTime(instance.createdAt));
  writeNotNull('modified_at', BaseClass.setDateTime(instance.modifiedAt));
  val['common_name'] = instance.commonName;
  val['uuid'] = instance.uuid;
  val['location'] = instance.location;
  val['scientific_name'] = instance.scientificName;
  val['girth'] = instance.girth;
  val['height'] = instance.height;
  return val;
}
