import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


import '../models/user.dart';

Future<Map> fetch(String method, String endpoint, {User user, Map<String, String> headers, Map body}) async {

  String url = '${DotEnv().env['HOST']}/$endpoint';

  headers ??= {};
  if (user != null) headers = {...user.authHeader};

  http.Response response;
  
  try {
    response = method == 'post'
        ? await http.post(url, headers: headers, body: jsonEncode(body))
        : await http.get(url, headers: headers);
  } 
  on SocketException  { throw ('Netzwerkfehler'); }

  if (response.statusCode == 401) throw ('unauthorized');

  switch (response.statusCode.toString()[0]) {
    case '2': break;
    case '4': throw ('Netzwerkfehler');
    case '5': throw ('Serverfehler');
  }

  Map json = jsonDecode(response.body);

  print(json);

  if (json['status'] == 'failure')
    throw (json['msg']);
  else
    return json;

}
