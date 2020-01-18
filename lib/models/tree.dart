import 'dart:ffi';

import 'package:tree_secure/models/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree.g.dart';

@JsonSerializable()
class Tree extends BaseClass {
  Tree(
      {String id,
      DateTime createdAt,
      DateTime modifiedAt,
      this.link,
      this.description,
      this.location,
      this.scientificName,
      this.commonName,
      this.coordinates,
      this.image,
      this.girth,
      this.height})
      : super(
          id: id,
          createdAt: createdAt,
          modifiedAt: modifiedAt,
        );

  @JsonKey(name: 'link')
  String link;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'scientific_name')
  String scientificName;
  @JsonKey(name: 'common_name')
  String commonName;
  @JsonKey(name: 'girth')
  String girth;
  @JsonKey(name: 'height')
  String height;
  @JsonKey(name: 'coordinates')
  String coordinates;
  @JsonKey(name: 'image')
  String image;

  /// A necessary factory constructor for creating a new `Trees` instance
  /// from a map. Pass the map to the generated `_$TreesFromJson` constructor.
  /// The constructor is named after the source class, in this case, `Trees`.
  factory Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TreesToJson`.
  Map<String, dynamic> toJson() => _$TreeToJson(this);
}
