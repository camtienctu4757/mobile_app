import 'dart:convert';

Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = parts[1];
  final normalized = base64Url.normalize(payload);
  final decodedBytes = base64Url.decode(normalized);
  final decodedString = utf8.decode(decodedBytes);

  return json.decode(decodedString);
}

