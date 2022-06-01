import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shelf_jwt/src/extensions/base64url_extensions.dart';
import 'package:shelf_jwt/src/jwt/jwt_algorithm_type.dart';

part 'jwt_header.g.dart';

@JsonSerializable()
class JwtHeader extends Equatable {
  final AlgorithmType alg;
  final String typ;

  JwtHeader(this.alg, this.typ);

  factory JwtHeader.fromJsonString(String json) =>
      JwtHeader.fromJson(jsonDecode(json));

  String toJsonString() => jsonEncode(toJson());

  factory JwtHeader.fromJson(Map<String, dynamic> json) =>
      _$JwtHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$JwtHeaderToJson(this);

  @override
  List<Object?> get props => [alg, typ];

  String toEncodedString() =>
      base64Url.encodeUnpaddedFromString(toJsonString());
}
