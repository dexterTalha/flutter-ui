import 'dart:collection';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
SharedPreferences preferences;
  Future<bool> saveWelcomePref() async {

    preferences = await SharedPreferences.getInstance();
    return preferences.setBool("old", true);
    /*preferences.commit;
    return true;*/
  }
   Future<bool> getWelcomePref() async {
    preferences = await SharedPreferences.getInstance();
    bool old = preferences.getBool("old");
    return old ??= false;
  }

  Future<bool> saveData(String sid, String id, String email, String password, String mobile) async{
    preferences = await SharedPreferences.getInstance();

    preferences.setString("sid", sid);
    preferences.setString("id", id);
    preferences.setString("email", email);
    preferences.setString("password", password);
    preferences.setString("mobile", mobile);
    preferences.commit;
    return true;
  }

  Future<Map<String, String>> getUserData() async{
    preferences = await SharedPreferences.getInstance();
    Map<String, String> user = HashMap<String, String>();

    String sid = preferences.getString("sid");
    String id = preferences.getString("id");
    String email = preferences.getString("email");
    String password = preferences.getString("password");
    String mobile = preferences.getString("mobile");

    user["sid"] = sid;
    user["id"] = id;
    user["email"] = email;
    user["password"] = password;
    user["mobile"] = mobile;

    return user??=null;

  }
}
