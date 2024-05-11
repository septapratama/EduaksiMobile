import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:eduapp/utils/JwtProvider.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final JwtProvider jwtProvider = JwtProvider();
  final String baseUrl = "http://192.168.0.105:8000/api/mobile";
  // final String baseUrl = "https://eduaksi.amirzan.my.id/api/mobile";
  final String imgUrl = "http://192.168.0.105:8000/img";
  final String fotoProfilUrl = "http://192.168.0.105:8000/eduaksi/mobile/img/profile/users/";
  Future<String> getAuthToken() async {
    if(await jwtProvider.isExpired()){
      return 'expired';
    }
    return jwtProvider.getJwt();
  }
  Future<Map<String, dynamic>> register(String email, String namaLengkap, String kataSandi, String kataSandiUlang) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'nama_lengkap': namaLengkap,
          'password': kataSandi,
          'password_confirm': kataSandiUlang,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  //Login
  Future<Map<String, dynamic>> login(String email, String kataSandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': 'UserTesting2@gmail.com',
          // 'email': email,
          'password': kataSandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        await jwtProvider.setJwt(responseData['data']);
        return responseData;
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //Send data google login
  Future<Map<String, dynamic>> loginGoogle(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login/google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        await jwtProvider.setJwt(responseData['data']);
        return responseData;
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //send or resend otp
  Future<Map<String, dynamic>> sendOtp(String email, String link) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat lupa password : $e');
    }
  }

  //verify otp
  Future<Map<String, dynamic>> verifyOtp(String email, String link, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + link),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'code': otp,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim otp : $e');
    }
  }

  //kirim reset password dari lupa password
  Future<Map<String, dynamic>> resetPass(String email, String otp, String pass, String passConfirm) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify/password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'code': otp,
          'password':pass,
          'password_confirm':passConfirm,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat reset password : $e');
    }
  }

  //logout
  Future<Map<String, dynamic>> logout() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      print(auth);
      final response = await http.post(
        Uri.parse('$baseUrl/users/logout'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        jwtProvider.logout();
        print(jwtProvider.getJwt());
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('erorr');
        print(responseData['message']);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat logout: $e');
    }
  }

  //download profile
  Future<void> checkFotoProfile() async {
    try {
      final ext = {'image/jpeg':'jpg', 'image/png':'png'};
      final auth = await getAuthToken();
      if(auth == 'expired'){
        // return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseUrl/users/profile/foto'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type']!;
        if (contentType != null && contentType.contains('application/json')) {
          dynamic responseData = json.decode(response.body);
          print(responseData['message']);
        } else if (contentType != null && contentType.contains('image')) {
          Directory directory = await getApplicationDocumentsDirectory();
          String filePath = '${directory.path}/user/profile/foto.${ext[contentType] ?? 'jpg'}';
          File tempFile = File('$filePath.temp');
          await tempFile.writeAsBytes(response.bodyBytes);
          await tempFile.rename(filePath);
          print('Image file saved locally at: $filePath');
        } else {
          print('Unknown response type');
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData['message']);
      }
    } catch (e) {
      throw Exception('Error saat download profile : $e');
    }
  }

  //update profile
  Future<Map<String, dynamic>> updateProfile(String email, String nama_lengkap, String no_hp, String kata_sandi, File? file) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/users/profile'));
      request.headers['Authorization'] = auth;
      request.fields['email'] = email;
      request.fields['nama_lengkap'] = nama_lengkap;
      request.fields['no_telpon'] = no_hp;
      if(file != null){
        request.files.add(await http.MultipartFile.fromPath('image', file.path));
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.transform(utf8.decoder).join());
        print(responseData['message']);
        // await jwtProvider.setJwt(responseData['data']);
        return responseData['message'];
      } else {
        final responseData = json.decode(await response.stream.transform(utf8.decoder).join());
        print(responseData['message']);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }

  //get artikel from dashboard
  Future<Map<String, dynamic>> getDashboard() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){ 
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseUrl/dashboard'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get dashboard : $e');
    }
  }

  //get artikel for artikel page
  Future<Map<String, dynamic>> getArtikel() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){ 
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseUrl/artikel'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get artikel : $e');
    }
  }

  //get detail artikel for detail artikel page
  Future<Map<String, dynamic>> getDetailArtikel(String link) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){ 
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseUrl/artikel/$link'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get detail artikel : $e');
    }
  }

  //get digital literasi
  Future<Map<String, dynamic>> getDisi() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/disi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get digital literasi : $e');
    }
  }

  //get digital literasi artikel
  Future<Map<String, dynamic>> getDisiArtikel() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/disi/artikel'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get artikel digital literasi : $e');
    }
  }

  //get digital literasi dengan usia
  Future<Map<String, dynamic>> getDisiUsia(String usia) async {
    try {
      List<String> parts = usia.split('-');
      if (parts.length == 2) {
        usia = parts.join('-');
      } else {
        usia = usia.trim();
      }
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/disi/usia/$usia'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get digital literasi dari usia : $e');
    }
  }

  //get digital literasi detail
  Future<Map<String, dynamic>> getDisiDetail(String idDisi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/disi/$idDisi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get detail digital literasi : $e');
    }
  }

  //get emosi mental
  Future<Map<String, dynamic>> getEmotal() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/emotal'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get emosi mental : $e');
    }
  }

  //get emosi mental artikel
  Future<Map<String, dynamic>> getEmotalArtikel() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/emotal/artikel'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get artikel emosi mental : $e');
    }
  }

  //get emosi mental dengan usia
  Future<Map<String, dynamic>> getEmotalUsia(String usia) async {
    try {
      List<String> parts = usia.split('-');
      if (parts.length == 2) {
        usia = parts.join('-');
      } else {
        usia = usia.trim();
      }
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/emotal/usia/$usia'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get emosi mental dari usia : $e');
    }
  }

  //get emosi mental detail
  Future<Map<String, dynamic>> getEmotalDetail(String idDisi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/emotal/$idDisi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get detail emosi mental : $e');
    }
  }

  //get nutrisi
  Future<Map<String, dynamic>> getNutrisi() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/nutrisi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get nutrisi : $e');
    }
  }

  //get nutrisi artikel
  Future<Map<String, dynamic>> getNutrisiArtikel() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/nutrisi/artikel'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get artikel nutrisi : $e');
    }
  }

  //get nutrisi dengan usia
  Future<Map<String, dynamic>> getNutrisiUsia(String usia) async {
    try {
      List<String> parts = usia.split('-');
      if (parts.length == 2) {
        usia = parts.join('-');
      } else {
        usia = usia.trim();
      }
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/nutrisi/usia/$usia'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get nutrisi dari usia : $e');
    }
  }

  //get nutrisi detail
  Future<Map<String, dynamic>> getNutrisiDetail(String idDisi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/nutrisi/$idDisi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get detail nutrisi : $e');
    }
  }

  //get pengasuhan
  Future<Map<String, dynamic>> getPengasuhan() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/pengasuhan'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get pengasuhan : $e');
    }
  }

  //get pengasuhan artikel
  Future<Map<String, dynamic>> getPengasuhanArtikel() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/pengasuhan/artikel'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get artikel pengasuhan : $e');
    }
  }

  //get pengasuhan dengan usia
  Future<Map<String, dynamic>> getPengasuhanUsia(String usia) async {
    try {
      List<String> parts = usia.split('-');
      if (parts.length == 2) {
        usia = parts.join('-');
      } else {
        usia = usia.trim();
      }
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/pengasuhan/usia/$usia'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get pengasuhan dari usia : $e');
    }
  }

  //get pengasuhan detail
  Future<Map<String, dynamic>> getPengasuhanDetail(String idDisi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/pengasuhan/$idDisi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat get detail pengasuhan : $e');
    }
  }
  //buat pencatatan
  Future<Map<String, dynamic>> sendCreatePencatatan(
      String nama_lengkap, umur) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_lengkap': nama_lengkap,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim tambah pencatatan : $e');
    }
  }

  //update pencatatan
  Future<Map<String, dynamic>> sendUpdatePencatatan(
      String idPencatatan, String nama_lengkap) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.put(
        Uri.parse('$baseUrl/users/pencatatan/update/$idPencatatan'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_lengkap': nama_lengkap,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim update pencatatan : $e');
    }
  }

  //get konsultasi
  Future<Map<String, dynamic>> getKonsultasi() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/konsultasi'), headers: <String, String>{
        'Authorization': auth,
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error getting konsultasi : $e');
    }
  }

  //get konsultasi detail
  Future<Map<String, dynamic>> getKonsultasiDetail(String idKonsultasi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseUrl/konsultasi/$idKonsultasi'), headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }
}