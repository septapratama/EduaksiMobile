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
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List> _events = {};
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _namaAcaraController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(DateTime.now());
  }

  dynamic _changeDate(String cond){
    if (cond == 'date' || cond == 'datetime') {
      DateTime parsedDate = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').parse(_dateController.text);
      int day = parsedDate.day;
      int month = parsedDate.month;
      int year = parsedDate.year;
      if (cond == 'date') {
        return DateTime(year, month, day);
      } else {
        List<String> timeParts = _timeController.text.split(':');
        int minute = int.parse(timeParts[0]);
        int hour = int.parse(timeParts[1]);
        return DateTime(year, month, day, hour, minute);
      }
    } else if (cond == 'time') {
      List<String> timeParts = _timeController.text.split(':');
      int minute = int.parse(timeParts[0]);
      int hour = int.parse(timeParts[1]);
      return {'hour': hour, 'minute': minute};
    } else {
      return null;
    }
  }

  void _tambahAcara(BuildContext context) async {
    try{
      List<Map<String, dynamic>> todayAcara = await acaraClass.getTodayAcara();
      String namaAcara = _namaAcaraController.text;
      String deskripsi = _descriptionController.text;
      String tanggal = _dateController.text;
      String waktu = _timeController.text;
      if(todayAcara.length >= 3){
        // alert(context, "Jumlah hari ini maksimal 3 acara !");
        print('Jumlah hari ini maksimal 3 acara !');
        return;
      }
      if (tanggal.isEmpty) {
        // alert(context, "Tanggal tidak boleh kosong !");
        print('Tanggal tidak boleh kosong !');
        return;
      }
      if (waktu.isEmpty) {
        // alert(context, "Waktu tidak boleh kosong !");
        print('Waktu tidak boleh kosong !');
        return;
      }
      if (namaAcara.isEmpty) {
        // alert(context, "Nama Acara tidak boleh kosong !");
        print('Nama Acara tidak boleh kosong !');
        return;
      }
      if (deskripsi.isEmpty) {
        // alert(context, "Deskripsi tidak boleh kosong !");
        print('Deskripsi tidak boleh kosong !');
        return;
      }
      if (_selectedCategory!.isEmpty) {
        // alert(context, "Kategori tidak boleh kosong !");
        print('Kategori tidak boleh kosong !');
        return;
      }
      DateTime pickDatetime = _changeDate('datetime');
      if (pickDatetime.isBefore(DateTime.now())){
        // alert(context, "Tanggal harus setelah atau sama dengan tanggal sekarang !");
        print('Tanggal harus setelah atau sama dengan tanggal sekarang !');
      }else if(pickDatetime.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        // alert(context, "Waktu harus lebih dari 5 menit dari waktu sekarang !");
        print('Waktu harus lebih dari 5 menit dari waktu sekarang !');
        return;
      }
      todayAcara.forEach((item) {
        if(DateTime.parse(item['tanggal']).difference(pickDatetime).inMinutes <  5){
          // alert(context, "Waktu harus lebih dari 5 menit dari setiap acara !");
          print('Waktu harus lebih dari 5 menit dari setiap acara !');
          return;
        }
      });
      String parDa = DateFormat('dd-MM-yyyy HH:mm').format(pickDatetime);
      Map<String, dynamic> response = await apiService.buatAcara(namaAcara, deskripsi, _selectedCategory!, parDa);
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
        // alert(context, response['message']);
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
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _namaAcaraController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final TimeOfDay initialTime = TimeOfDay(hour: now.hour, minute: now.minute);
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
      DateTime pickDate = _changeDate('date');
      final DateTime selectedDateTime = DateTime(
        pickDate.year,
        pickDate.month,
        pickDate.day,
        picked.hour,
        picked.minute,
      );

      bool isError = false;
      String errMessage = '';
      if(selectedDateTime.isBefore(now)) {
        errMessage = 'pilih waktu harus lebih dari sekarang !';
        isError = true;
      }else if(selectedDateTime.isBefore(now.add(const Duration(minutes: 5)))) {
        errMessage = 'Pilih waktu minimal 5 menit dari sekarang !';
        isError = true;
      }
      if(isError){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Invalid Time"),
              content: Text(errMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }else{
      setState(() {
        _timeController.text = DateFormat('HH:mm').format(selectedDateTime);
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Aksi Calendar Pintar',
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RiwayatCalendar()),
          );
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
                    _dateController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(selectedDay);
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
                    controller: _dateController,
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
