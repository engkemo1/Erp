import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../models/message.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  final String _ipAddress = "207.154.211.87:3000";
//192.168.1.169:3001
//192.168.1.216
//192.168.1.216:3001
  //*
  //final String _baseUrl = "http://dev.accountly.me:3006/";
  final String _baseUrl = "192.168.1.216:3000";

  final String API_KEY = "AIzaSyBuDGFI-HdSlxDxv6vN9TP_f_7zf4xo6vg";

  Future<Map<String, String>> getHeaders() async {
    String language = Intl.getCurrentLocale();
    return {"language": language, "Authorization": getAuthorization()!};
  }

  String? getAuthorization() {
    final stroage = GetStorage();

    var x = stroage.read("token");
    return "JWT " + x ?? "null";
  }

  getAddressFromLatLng(context, double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$API_KEY&language=ar&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print(data);
        String formattedAddress = data["results"][0]["formatted_address"];
        return formattedAddress;
      }
    }
    return null;
  }

  Future<dynamic> get(String url, Map<String, String>? header,
      {Map<String, dynamic>? body}) async {
    var responseJson;
    try {
      var headers = await getHeaders();
      final response = await http.get(Uri.http(_baseUrl, '/$url', body),
          headers: header ?? headers);
      responseJson = _returnResponse(response);
    } catch (err) {
      print(err);
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body,
      {Map<String, String>? header, Map<String, dynamic>? data}) async {
    var responseJson;
    try {
      var headers = await getHeaders();

      final response = await http.post(
          Uri.parse(
            'http://192.168.1.216:3000/$url',
          ),
          body: body,
          headers: header ?? headers);
      print('response $response');
      responseJson = _returnResponse(response);
    } catch (ex) {
      throw ex.toString();
    }
    return responseJson;
  }

  Future<String> postFile(String filePath) async {
    var responseJson;
    try {
      File file = File(filePath);
      var request =
          http.MultipartRequest('POST', Uri.http(_baseUrl, "storage"));
      request.files.add(http.MultipartFile(
          'upload', file.readAsBytes().asStream(), file.lengthSync(),
          filename: "123.jpg"));
      var response = await request.send();
      if (response.statusCode == 200) {
        String reply = await response.stream.transform(utf8.decoder).join();
        Map<String, dynamic> userMap = jsonDecode(reply);
        return userMap['file_url'];
      }
    } catch (ex) {
      throw ex;
    }
    return responseJson;
  }

  Future put(String url, dynamic body, Map<String, String>? header) async {
    var responseJson;
    try {
      var headers = await getHeaders();
      final response = await http.put(
          Uri.parse('http://192.168.1.216:3000/$url'),
          body: body,
          headers: header ?? headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var apiResponse;
    var headers = await getHeaders();

    try {
      final response =
          await http.delete(Uri.http(_baseUrl, url), headers: headers);
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      var responseJson = json.decode(response.body.toString());
      Message message = Message.fromJson(responseJson);
      throw message.message!;
    case 404:
      var responseJson = json.decode(response.body.toString());
      Message message = Message.fromJson(responseJson);
      throw message.message!;
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
