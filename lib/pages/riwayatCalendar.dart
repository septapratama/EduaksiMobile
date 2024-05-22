import 'dart:convert';

import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:capitalize/capitalize.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_AksiMenu.dart';
import 'package:eduapp/utils/Acara.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/pages/calendar.dart';
import 'package:eduapp/pages/calendarShow.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_button.dart';

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
  late List<Map<String, bool>> _selected = [];
  bool _isSelect = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  void fetchData() async{
    await acaraClass.init();
    acaraData = acaraClass.getAcaraData();
    _selected = List<Map<String, bool>>.generate(acaraData.length, (index) => {'i${acaraData[index]['id_acara']}': false});
    setState(() {});
  }

  void _hapusAcara(BuildContext context) async {
    try{
      bool checkIS = _selected.every((element) {
        return element.containsValue(false);
      });
      if(checkIS){
        CostumAlert.show(context, "Tidak ada pilihan !", "Invalid checkbox!",Icons.error, Colors.red);
        return;
      }
      List<String> checkList = _selected.expand((element) => element.keys.where((key) => element[key] == true).map((key) => key.substring(1))).toList();
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.hapusAcara(checkList.join(','));
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        acaraClass.deleteAcara(checkList);
        CostumAlert.show(context, "Berhasil hapus acara","Berhasil hapus acara",Icons.check, Colors.green);
        setState(() {
          acaraData = acaraClass.getAcaraData();
        });
      } else {
        CostumAlert.show(context, response['message'], "Gagal hapus acara !",Icons.error, Colors.red);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error saat hapus Kalender : $e');
    }
  }

  bool _getCheckboxValue(String idAcara) {
    for (var element in _selected) {
      if (element.containsKey('i$idAcara')) {
        return element['i$idAcara']!;
      }
    }
    return false;
  }

  void _setCheckboxValue(String idAcara, bool value) {
    setState(() {
      for (var element in _selected) {
        if (element.containsKey('i$idAcara')) {
          element['i$idAcara'] = value;
          continue;
        }
      }
    });
  }

  void _changeMode({bool isSelect = false}){
    _isSelect = isSelect ? isSelect : !_isSelect;
    setState(() {
      if (!_isSelect) {
        _selected = List<Map<String, bool>>.generate(acaraData.length, (index) => {'i${acaraData[index]['id_acara']}': false});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Riwayat Kalender',
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AksiMenu()),
          );
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: acaraData.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime inpDate = DateFormat('yyyy-MM-dd HH:mm').parse(acaraData[index]['tanggal']);
                  String tanggalData = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(inpDate);
                  String waktuData = DateFormat('HH:mm').format(inpDate);
                  String indexCheck = 'i${acaraData[index]['id_acara']}';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCalendar(idAcara: acaraData[index]['id_acara'])));
                    },
                    onLongPress: () => _changeMode(isSelect: true),
                    child: Row(
                      children: [
                        if (_isSelect) Checkbox(
                          value: _getCheckboxValue(acaraData[index]['id_acara']),
                          onChanged: (value) => _setCheckboxValue(acaraData[index]['id_acara'], value!),
                        ),
                        Expanded(
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isSelect ?
                    Container(
                      width: 180,
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 90,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:  Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => _hapusAcara(context),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins_Bold',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => _changeMode(),
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins_Bold',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      )
                    : Container(
                      width: 90,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () => _changeMode(),
                        child: const Text(
                          'Pilih',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AksiCalendarPage()));
                        },
                        child: const Text(
                          'Tambah',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: ElevatedButton(
            //       style: CustomButton.overallButtonStyle(),
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => AksiCalendarPage()));
            //         // Handle button press here
            //       },
            //       child: const Padding(
            //         padding:
            //             EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            //         child: Text(
            //           'Tambah',
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontFamily: 'Poppins_Bold',
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
