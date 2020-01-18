import 'package:json_annotation/json_annotation.dart';

/// A `Base` abstract for all models to inherit from.
/// This class contains the `Base` parameters like `id`, `createdAt` etc.
abstract class BaseClass {
  BaseClass({
    this.id,
    this.createdAt,
    this.modifiedAt,
  });
  @JsonKey(nullable: true, includeIfNull: false)
  String id;

  /// The timestamp of the `Base` model which is first created in Firestore.
  /// See also:
  ///  * https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/Timestamp-class.html,
  ///    which shows the details of Timestamp class.
  @JsonKey(
    name: 'created_at',
    nullable: true,
    fromJson: convertTimestampToDateTime,
    toJson: setDateTime,
    includeIfNull: false,
  )
  DateTime createdAt;
  @JsonKey(
    name: 'modified_at',
    nullable: true,
    fromJson: convertTimestampToDateTime,
    toJson: setDateTime,
    includeIfNull: false,
  )
  DateTime modifiedAt;

  /// If the `Base` model is selected during the lifecycle of the app.
  /// For in-app use only.
  @JsonKey(ignore: true)
  bool isSelected = false;

  /// `setDateTime` helper method sets the datetime object as DateTime.
  static DateTime setDateTime(DateTime date) => date;

  /// `convertTimestampToDateTime` helper method converts the json object into DateTime.
  /// If the json object's runtime type is Timestamp, call the timestamp.toDate().
  static DateTime convertTimestampToDateTime(dynamic timestamp) {
    if (timestamp != null) {
      if (timestamp.runtimeType != DateTime)
        return timestamp.toDate();
      else
        return timestamp;
    }
    return null;
  }
}
