import 'dart:convert';

extension Base64UrlExtension on Base64Codec {
  String encodeUnpaddedFromBytes(List<int> bytes) =>
      encode(bytes).replaceAll('=', '');

  String encodeUnpaddedFromString(String str) =>
      encodeUnpaddedFromBytes(str.codeUnits);
}
