import 'package:capitalize/capitalize.dart';
import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/utils/Acara.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:eduapp/pages/riwayatCalendar.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';

class ShowCalendar extends StatefulWidget {
  final String idAcara;
  const ShowCalendar({super.key, required this.idAcara});

  @override
  _AksiCalendarPageStateShow createState() => _AksiCalendarPageStateShow();
}

class _AksiCalendarPageStateShow extends State<ShowCalendar> {
  final ApiService apiService = ApiService();
  final Acara acaraClass = Acara();
  late DateTime _pickDate = DateTime.now();
  final Map<DateTime, List> _events = {};
  late Map<String, dynamic> acaraData;
  final TextEditingController _namaAcaraController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  String? _selectedCategory;
  
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async{
    await acaraClass.init();
    acaraData = acaraClass.getAcaraData().firstWhere((item) => item['id_acara'] == widget.idAcara);
    if(acaraData.isEmpty || acaraData == null){
      Navigator.pushReplacement(context, pageMove.movepage(const RiwayatCalendar()));
    }else{
      setState(() {
        _namaAcaraController.text = acaraData['nama_acara'];
        _deskripsiController.text = acaraData['deskripsi'];
        _kategoriController.text = 'Acara ${IsCapitalize().capitalizeAllWord(value: acaraData['kategori'])}';
        List<dynamic> datetimee = acaraData['tanggal'].toString().split(' ');
        _pickDate = DateFormat('dd-MM-yyyy').parse(datetimee[0]);
        _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(_pickDate);
        _waktuController.text = datetimee[1];
      });
    }
  }

  dynamic _changeDate(String cond){
    if (cond == 'date' || cond == 'datetime') {
      DateTime parsedDate = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').parse(_tanggalController.text);
      int day = parsedDate.day;
      int month = parsedDate.month;
      int year = parsedDate.year;
      if (cond == 'date') {
        return DateTime(year, month, day);
      } else {
        List<String> timeParts = _waktuController.text.split(':');
        int minute = int.parse(timeParts[0]);
        int hour = int.parse(timeParts[1]);
        return DateTime(year, month, day, hour, minute);
      }
    } else if (cond == 'time') {
      List<String> timeParts = _waktuController.text.split(':');
      int minute = int.parse(timeParts[0]);
      int hour = int.parse(timeParts[1]);
      return {'hour': hour, 'minute': minute};
    } else {
      return null;
    }
  }

  void _editAcara(BuildContext context) async {
    try{
      List<Map<String, dynamic>> todayAcara = await acaraClass.getTodayAcara();
      String namaAcara = _namaAcaraController.text;
      String deskripsi = _deskripsiController.text;
      String tanggal = _tanggalController.text;
      String waktu = _waktuController.text;
      //checking if data same
      List<dynamic> datetimee = acaraData['tanggal'].toString().split(' ');
      String tanggalDetail = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(DateFormat('dd-MM-yyyy').parse(datetimee[0]));
      if(namaAcara == acaraData['nama_acara'] && deskripsi == acaraData['deskripsi'] && _selectedCategory == acaraData['kategori'] && tanggal == tanggalDetail && waktu == datetimee[1]){
        CostumAlert.show(context, "Data belum diubah !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Data belum diubah !');
        return;
      }
      //validator
      if (tanggal.isEmpty) {
        CostumAlert.show(context, "Tanggal tidak boleh kosong !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Tanggal tidak boleh kosong !');
        return;
      }
      if (waktu.isEmpty) {
        CostumAlert.show(context, "Waktu tidak boleh kosong !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Waktu tidak boleh kosong !');
        return;
      }
      if (namaAcara.isEmpty) {
        CostumAlert.show(context, "Nama acara tidak boleh kosong !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Nama Acara tidak boleh kosong !');
        return;
      }
      if (deskripsi.isEmpty) {
        CostumAlert.show(context, "Deskripsi tidak boleh kosong !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Deskripsi tidak boleh kosong !');
        return;
      }
      if (_selectedCategory!.isEmpty) {
        CostumAlert.show(context, "Kategori tidak boleh kosong !", "gagal tambah acara!",Icons.error, Colors.red);
        // print('Kategori tidak boleh kosong !');
        return;
      }
      DateTime pickDatetime = _changeDate('datetime');
      if (pickDatetime.isBefore(DateTime.now())){
        // CostumAlert.show(context, "Tanggal harus setelah atau sama dengan tanggal sekarang !", "gagal tambah acara!",Icons.error, Colors.red);
        print('Tanggal harus setelah atau sama dengan tanggal sekarang !');
      }else if(pickDatetime.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        // CostumAlert.show(context, "Waktu harus lebih dari 5 menit dari waktu sekarang !", "gagal tambah acara!",Icons.error, Colors.red);
        print('Waktu harus lebih dari 5 menit dari waktu sekarang !');
        return;
      }
      todayAcara.forEach((item) {
        if(DateTime.parse(item['tanggal']).difference(pickDatetime).inMinutes <  5){
          // CostumAlert.show(context, "Waktu harus lebih dari 5 menit dari setiap acara !", "gagal tambah acara!",Icons.error, Colors.red);
          print('Waktu harus lebih dari 5 menit dari setiap acara !');
          return;
        }
      });
      String parDa = DateFormat('dd-MM-yyyy HH:mm').format(pickDatetime);
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.buatAcara(namaAcara, deskripsi, _selectedCategory!, parDa);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        Map<String, dynamic> data = {
          'id_acara':response['data'].toString(),
          'nama_acara':namaAcara,
          'deskripsi':deskripsi,
          'kategori':_selectedCategory!,
          'tanggal':parDa,
        };
        acaraClass.tambahAcara(data);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context, pageMove.movepage(const RiwayatCalendar()));
        });
      } else {
        CostumAlert.show(context, response['message'], "gagal tambah acara!",Icons.error, Colors.red);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error saat tambah calender : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aksi Calendar Pintar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RiwayatCalendar()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: _pickDate,
                focusedDay: _pickDate,
                availableGestures: AvailableGestures.none,
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Month', // Hanya menampilkan format bulanan
                },
                // selectedDayPredicate: (day) {
                //   return isSameDay(_pickDate, day);
                // },
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tanggal',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: _tanggalController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Masukkan tanggal Anda',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Waktu',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: _waktuController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Waktu Anda',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Kategori Acara',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: _kategoriController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Pilih Kategori Acara',
                    // hintText: 'Acara ${_kategoriController.text}',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Acara',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: _namaAcaraController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Nama Acara Anda',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins_Bold',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColor.primaryColors,
                    width: 1.25,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller: _deskripsiController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Deskripsi Anda',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                  style: CustomButton.overallButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RiwayatCalendar()));
                    // Handle button press here
                  },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 100.0),
                        child: Text(
                          'Kembali',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
