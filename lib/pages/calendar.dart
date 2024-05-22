import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/utils/Acara.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:eduapp/pages/riwayatCalendar.dart';
import 'package:eduapp/component/custom_pagemove.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';

class AksiCalendarPage extends StatefulWidget {
  AksiCalendarPage({super.key});

  @override
  _AksiCalendarPageState createState() => _AksiCalendarPageState();
}

class _AksiCalendarPageState extends State<AksiCalendarPage> {
  final ApiService apiService = ApiService();
  final Acara acaraClass = Acara();
  DateTime _selectedDay = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _events = {};
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _namaAcaraController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool isTambah = false;

  @override
  void initState() {
    super.initState();
    _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(DateTime.now());
  }

  void _tambahAcara(BuildContext context) async {
    try{
      if(isTambah) return;
      List<Map<String, dynamic>> todayAcara = await acaraClass.getTodayAcara();
      String namaAcara = _namaAcaraController.text;
      String deskripsi = _descriptionController.text;
      String tanggal = _tanggalController.text;
      String waktu = _timeController.text;
      if(todayAcara.length >= 3){
        CostumAlert.show(context, "Jumlah hari ini maksimal 3 acara !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      if (tanggal.isEmpty) {
        CostumAlert.show(context, "Tanggal tidak boleh kosong !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      if (waktu.isEmpty) {
        CostumAlert.show(context, "Waktu tidak boleh kosong !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      if (namaAcara.isEmpty) {
        CostumAlert.show(context, "Nama acara tidak boleh kosong !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      if (deskripsi.isEmpty) {
        CostumAlert.show(context, "Deskripsi tidak boleh kosong !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      if (_selectedCategory!.isEmpty) {
        CostumAlert.show(context, "Kategori tidak boleh kosong !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      final DateTime pickDatetime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
      if (pickDatetime.isBefore(DateTime.now())){
        CostumAlert.show(context, "Tanggal harus setelah atau sama dengan tanggal sekarang !", "Gagal tambah acara !",Icons.error, Colors.red);
      }else if(pickDatetime.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        CostumAlert.show(context, "Waktu harus lebih dari 5 menit dari waktu sekarang !", "Gagal tambah acara !",Icons.error, Colors.red);
        return;
      }
      for (var item in todayAcara) {
        int differenceInMinutes = DateFormat('yyyy-MM-dd HH:mm').parse(item['tanggal']).difference(pickDatetime).inMinutes;
        if (differenceInMinutes < 5 && differenceInMinutes > -5) {
          CostumAlert.show(context, "Waktu harus lebih dari 5 menit dari setiap kalender !", "gagal edit kalender!",Icons.error, Colors.red);
          return;
        }
      }
      String parDa = DateFormat('yyyy-MM-dd HH:mm').format(pickDatetime);
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.buatAcara(namaAcara, deskripsi, _selectedCategory!, parDa);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        setState(() {
          isTambah = true;
        });
        Map<String, dynamic> data = {
          'id_acara':response['data'].toString(),
          'nama_acara':namaAcara,
          'deskripsi':deskripsi,
          'kategori':_selectedCategory!,
          'tanggal':parDa,
        };
        acaraClass.tambahAcara(data);
        CostumAlert.show(context, "Berhasil tambah acara","Berhasil tambah acara",Icons.check, Colors.green);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, pageMove.movepage(const RiwayatCalendar()));
        });
      } else {
        CostumAlert.show(context, response['message'], "Gagal tambah acara !",Icons.error, Colors.red);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
      }
    } catch (e) {
      print('Error saat tambah kalender : $e');
    }
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _timeController.dispose();
    _namaAcaraController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay initialTime = TimeOfDay(hour: _selectedTime.hour, minute: _selectedTime.minute);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final DateTime selectedDateTime = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        picked.hour,
        picked.minute,
      );
      final DateTime now = DateTime.now();
      if(selectedDateTime.isBefore(now)) {
        CostumAlert.show(context, "Pilih waktu harus lebih dari sekarang !", "Invalid time!",Icons.error, Colors.red);
        return;
      }else if(selectedDateTime.isBefore(now.add(const Duration(minutes: 5)))) {
        CostumAlert.show(context, "Pilih waktu minimal 5 menit dari sekarang !", "Invalid time!",Icons.error, Colors.red);
        return;
      }
      _selectedTime = picked;
      setState(() {
        _timeController.text = DateFormat('HH:mm').format(selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tambah Kalender',
        leadingOnPressed: () {
          if(!isTambah){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RiwayatCalendar()),
            );
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                availableGestures: AvailableGestures.horizontalSwipe,
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Month', // Hanya menampilkan format bulanan
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(selectedDay);
                  });
                },
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
                    controller: _tanggalController,
                    readOnly: true, // Mengaktifkan mode hanya baca
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Input Tanggal Anda',
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
                    controller: _timeController,
                    readOnly: true,
                    onTap: () {
                      _selectTime(context);
                    },
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
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  items: ['umum', 'penting', 'keluarga'].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text('Acara $category'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  hint: const Text('Pilih Kategori Acara'),
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
                    controller: _namaAcaraController,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 20,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Masukkan nama acara',
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
                    controller: _descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 50,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Masukkan Deskripsi Anda',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Widgets lainnya di sini
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      style: CustomButton.overallButtonStyle(),
                      onPressed: () {
                        _tambahAcara(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 100.0),
                        child: Text(
                          'Simpan',
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