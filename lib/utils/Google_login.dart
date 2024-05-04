import 'package:eduapp/utils/ApiService.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleLogin{
  final googleSignIn = GoogleSignIn();
  final ApiService apiService = ApiService();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<Map<String, dynamic>> loginGoogle() async{
    final googleResponse = await googleSignIn.signIn();
    print(googleResponse);
    //send data
      return {'status' : 'error', 'message' : 'login google error'};
    // if(googleResponse.email == null){
    //   return {'status' : 'error', 'message' : 'login google error'};
    // }
    // return await apiService.loginGoogle(googleResponse.email);

  }
  Future logout() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    _user = null;
  }
}