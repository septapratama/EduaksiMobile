import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleLogin{
  static final _googleSignIn = GoogleSignIn();
  final ApiService apiService = ApiService();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<Map<String, dynamic>> loginGoogle(BuildContext context) async{
    await _googleSignIn.signOut();
    final googleResponse = await _googleSignIn.signIn();
    if(googleResponse == 'null'){
      return {'status' : 'error', 'message' : 'login google error'};
    }
    return await apiService.loginGoogle(googleResponse!.email, context);
  }
  Future logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    _user = null;
  }
}