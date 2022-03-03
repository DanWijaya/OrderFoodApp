import 'dart:convert';

import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'mapper.dart';

class AuthApi implements IAuthApi {
  final http.Client _client;
  String baseUrl;

  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String>> signIn(Credential credential) async {
    // TODO: implement signIn
    var endpoint = this.baseUrl + '/auth/signin';
    return await _postCredential(endpoint, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    // TODO: implement signUp
    var endpoint = baseUrl + '/auth/signup';
    return await _postCredential(endpoint, credential);
  }

  Future<Result<String>> _postCredential(
      String endpoint, Credential credential) async {
    var response = await _client.post(Uri.parse(endpoint),
        body: Mapper.toJson(credential));

    if (response.statusCode != 200) {
      return Result<String>.error('Server error');
    }
    var json = jsonDecode(response.body);

    return json['auth_token'] != null
        ? Result<String>.value(json['auth_token'])
        : Result<String>.error(json['message']);
  }
}
