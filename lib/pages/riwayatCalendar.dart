import 'package:eduapp/component/custom_pagemove.dart';
import 'package:capitalize/capitalize.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/utils/Acara.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/pages/calendar.dart';
import 'package:eduapp/pages/calendarShow.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_button.dart';

// Define your EventData class
// class EventData {
//   final String tanggal;
//   final String waktu;
//   final String kategori;
//   final String acara;

//   EventData({
//     required this.tanggal,
//     required this.waktu,
//     required this.kategori,
//     required this.acara
//   });
// }

// Define your list of data
// List<EventData> acaraData = [
//   EventData(
//     tanggal: '2024-05-08',
//     waktu: '13:00',
//     kategori: 'umum',
//     acara: 'Team meeting for project discussion',
//   ),
//   EventData(
//     tanggal: '2024-05-09',
//     waktu: '10:30',
//     kategori: 'penting',
//     acara: 'Training session on new software tools',
//   ),
//   EventData(
//     tanggal: '2024-05-10',
//     waktu: '15:45',
//     kategori: 'keluarga',
//     acara: 'Client presentation for project proposal',
//   ),
//   EventData(
//     tanggal: '2024-05-12',
//     waktu: '09:00',
//     kategori: 'umum',
//     acara: 'Interview scheduled for new hires',
//   ),
// ];`

class RiwayatCalendar extends StatefulWidget {
  const RiwayatCalendar({super.key});

  @override
  _RiwayatCalendarState createState() => _RiwayatCalendarState();
}

class _RiwayatCalendarState extends State<RiwayatCalendar> {
  final ApiService apiService = ApiService();
  final Acara acaraClass = Acara();
  final Map<String, dynamic> colorCard = {'umum':Colors.green, 'penting':Colors.red, 'keluarga':Colors.orange, 'default':Colors.grey};
  List<Map<String, dynamic>> acaraData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async{
    await acaraClass.init();
    // await acaraClass.fetchData();
    acaraData = acaraClass.getAcaraData();
    setState(() {
    });
  }

  void _hapusAcara(BuildContext context, String idAcara) async {
    try{
      Map<String, dynamic> response = await apiService.hapusAcara(idAcara);
      if (response['status'] == 'success') {
        print(response['message']);
        acaraClass.deleteAcara(idAcara);
        setState(() {
          acaraData.removeWhere((item)=> item['id_acara'] == idAcara);
        });
      } else {
        print(response['message']);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
        // alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat calendar : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Riwayat Calendar'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: acaraData.length,
                itemBuilder: (BuildContext context, int index) {
                  List<dynamic> datetimee = acaraData[index]['tanggal'].toString().split(' ');
                  String tanggalData = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(DateFormat('dd-MM-yyyy').parse(datetimee[0]));
                  String waktuData = datetimee[1];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCalendar(idAcara: acaraData[index]['id_acara'])));
                    },
                    child: Card(
                      color: colorCard[acaraData[index]['kategori']] ?? colorCard['default'], // Set warna card sesuai dengan kategori
                      margin:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Tanggal: $tanggalData',
                          style: const TextStyle(
                            color:
                                Colors.white, // Ganti warna teks menjadi putih
                            fontSize: 16, // Sesuaikan ukuran font
                            fontFamily:
                                'Poppins_Bold', // Ganti dengan nama font kustom Anda
                            fontWeight: FontWeight
                                .bold, // Sesuaikan gaya teks jika diperlukan
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Waktu: $waktuData',
                              style: const TextStyle(
                                color: Colors
                                    .white, // Ganti warna teks menjadi putih
                                fontSize: 14, // Sesuaikan ukuran font
                                fontFamily:
                                    'Poppins_Bold', // Ganti dengan nama font kustom Anda
                              ),
                            ),
                            Text(
                              'Kategori: Acara ${IsCapitalize().capitalizeAllWord(value: acaraData[index]['kategori'])}',
                              style: const TextStyle(
                                color: Colors
                                    .white, // Ganti warna teks menjadi putih
                                fontSize: 14, // Sesuaikan ukuran font
                                fontFamily:
                                    'Poppins_Bold', // Ganti dengan nama font kustom Anda
                              ),
                            ),
                            Text(
                              'Acara: ${acaraData[index]['nama_acara']}',
                              style: const TextStyle(
                                color: Colors
                                    .white, // Ganti warna teks menjadi putih
                                fontSize: 14, // Sesuaikan ukuran font
                                fontFamily:
                                    'Poppins_Bold', // Ganti dengan nama font kustom Anda
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: CustomButton.overallButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AksiCalendarPage()));
                    // Handle button press here
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    child: Text(
                      'Tambah',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins_Bold',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
