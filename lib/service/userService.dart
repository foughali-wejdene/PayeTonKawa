import 'dart:convert' show json, jsonEncode;
import 'dart:io' show Platform;

import 'package:http/http.dart';
import 'package:mspr/Core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/Core/sharedPref.dart';
import 'package:mspr/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
 * API ROUTES
  `${BASE_URI}/car`).get(this.carController.getCars);
  `${BASE_URI}/car`).post(this.carController.AddNewCar);
	`${BASE_URI}/car/user/:userId`).get(this.carController.getCarOfUser);
	`${BASE_URI}/car/:id`).get(this.carController.getCarWithID);
	`${BASE_URI}/car/:id`).put(this.carController.updateCar);
	`${BASE_URI}/car/:id`).delete(this.carController.deleteCar);
*/

class UserService {
  /// Function to get all the cars of a specific user.
  static Future<List<User>> getAllClient() async {
    Response response;
    String url = "${Constant.iosHost}/customers";
    late Map<String, dynamic> datas;
    List<User> users = List<User>.empty(growable: true);

    if (Platform.isAndroid) {
      url = "${Constant.androidHost}/customers";
    }
    response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      datas = json.decode(response.body);
    }

    datas['datas'].forEach((element) {
      users.add(User.fromMap(element));
    });

    return users;
  }

  static Future<User?> getOneClient(int id) async {
    Response response;
    String url = "${Constant.iosHost}/customers/$id";
    late Map<String, dynamic> datas;

    if (Platform.isAndroid) {
      url = "${Constant.androidHost}/customers/$id";
    }
    response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      datas = json.decode(response.body);
      User client = User.fromMap(datas);

      return client;
    }

    return null;
  }

  static Future<User?> login(String email) async {
    Response response;
    String url = "${Constant.iosHost}/login";
    SharedPref sharedPref = SharedPref();
    late Map<String, dynamic> result;
    Map<String, dynamic> data = {'email': email};

    if (Platform.isAndroid) {
      url = "${Constant.androidHost}/login";
    }
    response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      sharedPref.save("currentUser", result);
      return User.fromMap(result);
    }

    return null;
  }
}
