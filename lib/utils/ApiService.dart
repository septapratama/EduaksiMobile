import 'dart:convert';
import 'dart:io';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/utils/Acara.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eduapp/utils/JwtProvider.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final JwtProvider jwtProvider = JwtProvider();
  final Acara acaraClass = Acara();
  // final String baseURL = "http://11111111:8000";
  // final String baseURL = "https://eduaksi.tifnganjuk.com";
  final String baseURL = "https://eduaksi.amirzanfikri.my.id";

  late String baseMobile = "";
  late String imgUrl = "";
  ApiService(){
    baseMobile = '$baseURL/api/mobile';
    imgUrl = '$baseURL/img';
  }
  Future<String> getAuthToken() async {
    if(JwtProvider.isLogout){
      return 'logout';
    }else if(await jwtProvider.isExpired()){
      return 'expired';
    }
    return jwtProvider.getJwt();
  }
  Future<Map<String, dynamic>> register(String email, String namaLengkap, String kataSandi, String kataSandiUlang) async {
    try {
      final response = await http.post(
        Uri.parse('$baseMobile/users/register'),
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
        Uri.parse('$baseMobile/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',  
        },
        body: jsonEncode(<String, String>{
          // 'email': 'UserTesting2@gmail.com',
          // 'password': 'Admin@1234567890',
          'email': email,
          'password': kataSandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        await jwtProvider.setJwt(responseData['data']);
        await acaraClass.init(this);
        await acaraClass.removeAcara();
        await acaraClass.fetchData(this);
        return responseData;
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //Send data google login
  Future<Map<String, dynamic>> loginGoogle(String email, BuildContext context) async {
    try {
      CustomLoading.showLoading(context);
      final response = await http.post(
        Uri.parse('$baseMobile/users/login/google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );
      CustomLoading.closeLoading(context);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        await jwtProvider.setJwt(responseData['data']);
        await acaraClass.init(this);
        await acaraClass.removeAcara();
        await acaraClass.fetchData(this);
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
        Uri.parse(baseMobile + link),
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
        Uri.parse(baseMobile + link),
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
        Uri.parse('$baseMobile/verify/password'),
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseMobile/users/logout'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if(await jwtProvider.logout()){
          await acaraClass.init(this);
          await acaraClass.removeAcara();
          return responseData;
        }else{
          return {'status': 'error', 'message': 'error logout !'};
        }
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat logout: $e');
    }
  }

  //download foto profile
  Future<Map<String, dynamic>> getFotoProfile() async {
    try {
      final ext = {'image/jpeg':'jpg', 'image/png':'png'};
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseMobile/users/profile/foto'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type']!;
        if (contentType != null && contentType.contains('application/json')) {
          dynamic res =  json.decode(response.body);
          return res;
        } else if (contentType != null && contentType.contains('image')) {
          final String dirPath = '${(await getApplicationDocumentsDirectory()).path}/user/profile';
          String cacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
          String filePath = '$dirPath/foto.${ext[contentType] ?? 'jpg'}?cache=$cacheBuster';
          File tempFile = File('$filePath.temp');
          await tempFile.writeAsBytes(response.bodyBytes);
          await tempFile.rename(filePath);
          return {'status': 'success', 'message': 'get new foto', 'data': filePath};
        } else {
          return {'status': 'error', 'message': 'random type'};
        }
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        responseData['status_code'] = response.statusCode;
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat download profile : $e');
    }
  }

  //update profile
  Future<Map<String, dynamic>> updateProfile(String email, String nama_lengkap, String jenisKelamin, String no_hp, String? kata_sandiLama, String? kata_sandi, String? kata_sandiUlangi, File? file) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final request = http.MultipartRequest('POST', Uri.parse('$baseMobile/users/profile/update'));
      request.headers['Authorization'] = auth;
      request.fields['email_new'] = email;
      request.fields['nama_lengkap'] = nama_lengkap;
      request.fields['jenis_kelamin'] = jenisKelamin;
      request.fields['no_telpon'] = no_hp;
      if((kata_sandiLama != null && kata_sandiLama.isNotEmpty) && (kata_sandi != null && kata_sandi.isNotEmpty) && (kata_sandiUlangi != null && kata_sandiUlangi.isNotEmpty)){
        request.fields['password_old'] = kata_sandiLama;
        request.fields['password'] = kata_sandi;
        request.fields['password_confirm'] = kata_sandiUlangi;
      }
      if(file != null){
        request.files.add(await http.MultipartFile.fromPath('foto', file.path));
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = json.decode(await response.stream.transform(utf8.decoder).join());
        await jwtProvider.setJwt(responseData['data']);
        return responseData;
      } else {
        final responseData = json.decode(await response.stream.transform(utf8.decoder).join());
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseMobile/dashboard'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){ 
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseMobile/artikel'), headers: <String, String>{
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
  Future<Map<String, dynamic>> getArtikelDetail(String link) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){ 
        return  {'message' : 'token expired'};
      }
      final response = await http.post(Uri.parse('$baseMobile/artikel/$link'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/disi'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/disi/artikel'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/disi/usia/$usia'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/disi/$idDisi'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/emotal'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/emotal/artikel'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/emotal/usia/$usia'), headers: <String, String>{
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
  Future<Map<String, dynamic>> getEmotalDetail(String idEmotal) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/emotal/$idEmotal'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/nutrisi'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/nutrisi/artikel'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/nutrisi/usia/$usia'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/nutrisi/$idDisi'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/pengasuhan'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/pengasuhan/artikel'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/pengasuhan/usia/$usia'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/pengasuhan/$idDisi'), headers: <String, String>{
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

  //fetch acara
  Future<Map<String, dynamic>> fetchAcara() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(
        Uri.parse('$baseMobile/kalender'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim fetch acara : $e');
    }
  }
  //buat acara
  Future<Map<String, dynamic>> buatAcara(String nama_acara, String deskripsi, String kategori, String tanggal) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseMobile/kalender/tambah'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_acara': nama_acara,
          'deskripsi': deskripsi,
          'kategori': kategori,
          'tanggal': tanggal,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim tambah acara : $e');
    }
  }

  //update acara
  Future<Map<String, dynamic>> editAcara(String idAcara, String nama_acara, String deskripsi, String kategori, String tanggal) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.put(
        Uri.parse('$baseMobile/kalender/update'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id_acara': idAcara,
          'nama_acara': nama_acara,
          'deskripsi': deskripsi,
          'kategori': kategori,
          'tanggal': tanggal,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim update acara : $e');
    }
  }

  //delete acara
  Future<Map<String, dynamic>> hapusAcara(String idAcara,) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.delete(
        Uri.parse('$baseMobile/kalender/delete'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id_acara': idAcara,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw Exception('Error saat kirim hapus acara : $e');
    }
  }

  //get konsultasi
  Future<Map<String, dynamic>> getKonsultasi() async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/konsultasi'), headers: <String, String>{
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
      if(auth == 'expired' || auth == 'logout'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(Uri.parse('$baseMobile/konsultasi/$idKonsultasi'), headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        dynamic errr = json.decode(response.body);
        errr['code'] = response.statusCode;
        return errr;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }
}