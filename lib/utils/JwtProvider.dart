import 'package:flutter_session_jwt/flutter_session_jwt.dart';
class JwtProvider{
  static String jwtToken = '';
  static bool isLogout = false;
  Future <Map<String, dynamic>> getData() async {
    final payload = await FlutterSessionJwt.getPayload();
    return payload?['data'];
  }
  String getJwt(){
    return jwtToken;
  }
  Future<void> setJwt(String token) async {
    isLogout = false;
    await FlutterSessionJwt.saveToken(token);
    jwtToken = token;
  }
  Future<bool> isExpired() async {
    if(isLogout){
      return true;
    }
    return await FlutterSessionJwt.isTokenExpired();
  }
  void logout() {
    isLogout = true;
  }
}