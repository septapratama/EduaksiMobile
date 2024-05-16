import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
class JwtProvider{
  // final ApiService apiServices = ApiService();
  late SharedPreferences prefs;
  static bool isLogout = true;

  JwtProvider(){
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future <Map<String, dynamic>> getData() async {
    final payload = await FlutterSessionJwt.getPayload();
    return payload?['data'];
  }

  String getJwt(){
    return prefs.getString('auth_token') ?? '';
  }

  Future<bool> setJwt(String token) async {
    try {
      await FlutterSessionJwt.saveToken(token);
      isLogout = !(await prefs.setString('auth_token', token));
      return isLogout;
    } catch (e) {
      print("Error setting JWT token: $e");
      return false;
    }
  }

  Future<bool> isExpired() async {
    if(isLogout){
      return true;
    }
    return await FlutterSessionJwt.isTokenExpired();
  }

  Future<bool> logout() async {
    isLogout = await prefs.remove('auth_token');
    return isLogout;
  }
}