import 'dart:async';
import 'dart:convert';
import "dart:core";
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class PetShopAPI {
  String? url;
  String? consumerKey;
  String? consumerSecret;
  bool? isHttps;

  PetShopAPI() {
    this.url = baseUrl + '/wp-json';
    this.consumerKey = ConsumerKey;
    this.consumerSecret = ConsumerSecret;

    if (this.url!.startsWith("https")) {
      this.isHttps = true;
    } else {
      this.isHttps = false;
    }
  }

  Uri? _getOAuthURL(String requestMethod, String endpoint) {
    var url = this.url! + endpoint;
    var containsQueryParams = url.contains("?");

    // If website is HTTPS based, no need for OAuth, just return the URL with CS and CK as query params
    if (/*this.isHttps == */ true) {
      return Uri.parse(url +
          (containsQueryParams == true
              ? "&consumer_key=" + this.consumerKey.validate() + "&consumer_secret=" + this.consumerSecret.validate()
              : "?consumer_key=" + this.consumerKey.validate() + "&consumer_secret=" + this.consumerSecret.validate()));
    }
  }

  Map<String, String> _buildHeaderTokens({bool print = true}) {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'no-cache',
    };

    if (appStore.isLoggedIn) {
      header.putIfAbsent('token', () => '${appStore.token}');
      header.putIfAbsent('id', () => '${appStore.userId}');
    }
    if (print) log(jsonEncode(header));
    return header;
  }

  Future<http.Response> getAsync(String endPoint, {requireToken = false, isFood = false}) async {
    Uri? url = this._getOAuthURL("GET", endPoint);
    log(url);

    if (url == null) throw 'Invalid URL';

    final response = await http.get(url, headers: _buildHeaderTokens());
    log('${response.statusCode} $url');
    log(response.body);
    return response;
  }

  Future<http.Response> postAsync(String endPoint, Map data, {requireToken = false}) async {
    Uri? url = this._getOAuthURL("POST", endPoint);
    log(url);

    if (url == null) throw 'Invalid URL';

    log(jsonEncode(data));

    var client = new http.Client();
    var response = await client.post(url, body: jsonEncode(data), headers: _buildHeaderTokens());

    log(response.statusCode);
    log(jsonDecode(response.body));
    return response;
  }

  Future<http.Response> putAsync(String endPoint, Map data, {requireToken = false}) async {
    var url = this._getOAuthURL("POST", endPoint);
    log(url);

    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'no-cache',
    };
    if (requireToken) {
      SharedPreferences pref = await getSharedPref();
      var header = {"token": "${pref.getString(API_TOKEN)}", "id": "${pref.getInt(USER_ID)}"};
      headers.addAll(header);
    }

    log(jsonEncode(headers));
    log(jsonEncode(data));

    var client = new http.Client();
    var response = await client.put(url!, body: jsonEncode(data), headers: headers);

    log(response.statusCode);
    log(jsonDecode(response.body));
    return response;
  }

  Future<http.Response> deleteAsync(String endPoint) async {
    Uri? url = this._getOAuthURL("DELETE", endPoint);
    log(url);
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.cacheControlHeader: 'no-cache',
    };
    var client = new http.Client();

    final response = await client.delete(url!, headers: headers);

    return response;
  }
}
