import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<String> loginPressed(
    {required bool fuckReddit, String? username, String? password}) async {
  var _clientId = "1kh563H1Aj6jrLKFAGF1tA";
  var callbackUrl = "radditech.local.app";
  var callbackScheme = "://login";

  String _oauthUrl =
      'https://www.reddit.com/api/v1/authorize.compact?client_id=$_clientId&response_type=code&state=RANDOM_STRING&redirect_uri=$callbackUrl$callbackScheme&scope=*';
  final result = await FlutterWebAuth.authenticate(
      url: _oauthUrl, callbackUrlScheme: callbackUrl, preferEphemeral: true);
  final queryStrings = Uri.splitQueryString(Uri.parse(result).query);
  var response = await http.post(
    Uri.parse('https://www.reddit.com/api/v1/access_token'),
    headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode(_clientId + ':')),
      'User-Agent':
          'android:radditech.local.app:v0.1.0 (by /u/Interesting-Mud-1460)',
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      'grant_type': 'authorization_code',
      'code': queryStrings['code'],
      'redirect_uri': '$callbackUrl$callbackScheme',
    },
    encoding: Encoding.getByName("utf-8"),
  );
  if (response.body.isEmpty) return ("NULL");
  print('Token : ${jsonDecode(response.body)['access_token']}');
  return (jsonDecode(response.body)['access_token'] ?? "NULL");
}