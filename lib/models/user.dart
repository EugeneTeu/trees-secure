import 'package:json_annotation/json_annotation.dart';
import 'package:tree_secure/models/base_class.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends BaseClass {
  User({
    String id,
    DateTime createdAt,
    DateTime modifiedAt,
    this.location,
    this.adoptedTrees,
    this.visitedTrees,
  }) : super(
          id: id,
          createdAt: createdAt,
          modifiedAt: modifiedAt,
        );

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'location')
  String location;
  @JsonKey(name: 'adopted_trees')
  List<String> adoptedTrees;
  @JsonKey(name: 'visited_trees')
  List<String> visitedTrees;

  /// A necessary factory constructor for creating a new `User` instance
  /// from a map. Pass the map to the generated `_$UserFromJson` constructor.
  /// The constructor is named after the source class, in this case, `User`.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
