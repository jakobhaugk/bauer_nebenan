import 'dart:convert';

String toBase64(input) {
  Codec<String, String> base64Codec = utf8.fuse(base64);
  return base64Codec.encode(input);
}