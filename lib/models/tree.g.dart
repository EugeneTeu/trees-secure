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
    link: json['link'] as String,
    description: json['description'] as String,
    location: json['location'] as String,
    scientificName: json['scientific_name'] as String,
    commonName: json['common_name'] as String,
    coordinates: json['coordinates'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
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
  val['link'] = instance.link;
  val['description'] = instance.description;
  val['location'] = instance.location;
  val['scientific_name'] = instance.scientificName;
  val['common_name'] = instance.commonName;
  val['girth'] = instance.girth;
  val['height'] = instance.height;
  val['coordinates'] = instance.coordinates;
  val['images'] = instance.images;
  return val;
}
