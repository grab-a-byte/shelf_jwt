import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shelf_jwt/src/extensions/base64url_extensions.dart';
import 'package:shelf_jwt/src/json_converters/datetime_epoch_converter.dart';

part 'jwt_payload.g.dart';

@JsonSerializable(includeIfNull: false)
@DateTimeEpochConverter()
class JwtPayload extends Equatable {
  final String? iss; // issuer
  final DateTime iat; // issued at
  final DateTime exp; // expiry time
  final List<String>? entitlements; // entitilements use has

  JwtPayload(this.iss, this.iat, this.exp, this.entitlements);

  factory JwtPayload.fromJsonString(String json) =>
      JwtPayload.fromJson(jsonDecode(json));

  String toJsonString() => jsonEncode(toJson());

  factory JwtPayload.fromJson(Map<String, dynamic> json) =>
      _$JwtPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$JwtPayloadToJson(this);

  @override
  List<Object?> get props => [iss, iat, exp, entitlements];

  String toEncodedString() =>
      base64Url.encodeUnpaddedFromString(toJsonString());
}
