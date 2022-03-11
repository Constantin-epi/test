import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:redditech/utils/Io.dart';


Future<Map<String, dynamic>> useApi(
    {required String method,
    required String url,
    required bool json,
    Map<String, dynamic>? data,
    String? type}) async {
  Uri _url = Uri.parse('https://oauth.reddit.com/$url');
  String bearer = await readToken();
  Map<String, String> head;
  if (type == null)
    head = {
      "Authorization": "bearer $bearer",
      "User-Agent":
          "android:radditech.local.app:v0.0.1 (by /u/Interesting-Mud-1460)"
    };
  else
    head = {
      "Authorization": "bearer $bearer",
      "User-Agent":
          "android:radditech.local.app:v0.0.1 (by /u/Interesting-Mud-1460)",
      "Content-Type": '$type'
    };
  print('URL : $_url\nHeaders : $head');
  try {
    if (method == "GET") {
      var response = await http.get(_url, headers: head);
      return jsonDecode(response.body);
    } else if (method == "POST") {
      var response = await http.post(_url,
          headers: head, body: json ? jsonEncode(data!) : data!);
      print('$data');
      return jsonDecode(response.body);
    } else if (method == "PATCH") {
      var response = await http.patch(_url,
          headers: head, body: json ? jsonEncode(data!) : data!);
      return jsonDecode(response.body);
    } else {
      var response = "{}";
      return jsonDecode(response);
    }
  } catch (e) {
    print(e);
    return ({});
  }
}
