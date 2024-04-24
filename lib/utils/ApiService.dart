import 'dart:convert';
import 'package:eduapp/utils/JwtProvider.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final JwtProvider jwtProvider = JwtProvider();
  final String baseUrl = "http://192.168.0.101:8000/api/mobile";
  // final String baseUrl = "https://eduaksi.amirzan.my.id/api/mobile";
  final String imgUrl = "http://192.168.0.101:8000/img/";
  final String fotoProfilUrl = "http://192.168.0.101:80/eduaksi/mobile/img/profile/users/";
  Future<String> getAuthToken() async {
    if(await jwtProvider.isExpired()){
      return 'expired';
    }
    return jwtProvider.getJwt();
  }
  Future<Map<String, dynamic>> register(
      String email, String namaLengkap, String kataSandi, String kataSandiUlang) async {
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  //Login
  Future<Map<String, dynamic>> login(
      String email, String kataSandi) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          // 'email': 'UserTesting1@gmail.com',
          'email': email,
          'password': kataSandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        await jwtProvider.setJwt(responseData['data']);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //Send data google login
  Future<Map<String, dynamic>> loginGoogle(
      String email) async {
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //lupa kata sandi
  Future<Map<String, dynamic>> lupaPassword(
      String namaLengkap, String kataSandi, String noHp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_lengkap': namaLengkap,
          'kata_sandi': kataSandi,
          'no_hp': noHp,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat lupa password : $e');
    }
  }

  //send otp
  Future<Map<String, dynamic>> sendOtp(
      String namaLengkap, String kataSandi, String noHp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nama_lengkap': namaLengkap,
          'kata_sandi': kataSandi,
          'no_hp': noHp,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat kirim otp : $e');
    }
  }

  //kirim ulang kode otp
  Future<Map<String, dynamic>> resendCodeOtp(
      String email, String kataSandi, String noHp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'kata_sandi': kataSandi,
          'no_hp': noHp,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat kirim ulang otp : $e');
    }
  }
  //logout
  Future<Map<String, dynamic>> logout(
      String email, int number) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'number': number.toString(),
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        jwtProvider.logout();
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat login: $e');
    }
  }

  //update profile
  Future<Map<String, dynamic>> updateProfile(
      String email, String nama_lengkap, String no_hp, String kata_sandi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.post(
        Uri.parse('$baseUrl/users/update'),
        headers: <String, String>{
          'Authorization': auth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'nama_lengkap': nama_lengkap,
          'no_hp': no_hp,
          'kata_sandi': kata_sandi,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat get digital literasi : $e');
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      final response = await http.get(
        Uri.parse('$baseUrl/disi/$idDisi'), 
        headers: <String, String>{
          'Authorization': auth,
        }
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat get emosi mental : $e');
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      final response = await http.get(
        Uri.parse('$baseUrl/emotal/$idDisi'), 
        headers: <String, String>{
          'Authorization': auth,
        }
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat get nutrisi : $e');
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      final response = await http.get(
        Uri.parse('$baseUrl/nutrisi/$idDisi'), headers: <String, String>{
          'Authorization': auth,
        }
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat get pengasuhan : $e');
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      final response = await http.get(
        Uri.parse('$baseUrl/pengasuhan/$idDisi'),
        headers: <String, String>{
          'Authorization': auth,
        }
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
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
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // List<dynamic> responseData = jsonResponse['data'];
        // List<Map<String, dynamic>> parsedData = responseData.cast<Map<String, dynamic>>();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }

  //get konsultasi detail
  Future<Map<String, dynamic>> getKonsultasiDetail(String idKonsultasi) async {
    try {
      final auth = await getAuthToken();
      if(auth == 'expired'){
        return  {'message' : 'token expired'};
      }
      final response = await http.get(
        Uri.parse('$baseUrl/konsultasi/$idKonsultasi'), 
        headers: <String, String>{
          'Authorization': auth,
        }
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
    } catch (e) {
      throw Exception('Error saat update profile : $e');
    }
  }
}