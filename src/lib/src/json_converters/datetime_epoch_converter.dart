import 'package:json_annotation/json_annotation.dart';
import 'package:shelf_jwt/src/extensions/datetime_extensions.dart';

class DateTimeEpochConverter implements JsonConverter<DateTime, int> {
  const DateTimeEpochConverter();

  @override
  DateTime fromJson(int json) => DateTimeExtensions.fromSecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.secondsSinceEpoch;
}
