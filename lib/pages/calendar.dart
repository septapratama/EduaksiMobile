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
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _namaAcaraController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  // List pilihan kategori acara
  final List<String> _categories = [
    'Acara umum',
    'Acara penting',
    'Acara keluarga',
  ];
  
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }
  void _tambahAcara(BuildContext context) async {
    try {
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
      //if using dd-mm-yyyy mm:hh
      List<String> dateParts = tanggal.split('-');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      List<String> timeParts = waktu.split(':');
      int minute = int.parse(timeParts[0]);
      int hour = int.parse(timeParts[1]);
      DateTime pickDatetime = DateTime(year, month, day, hour, minute);
      // DateTime date = DateTime.parse(tanggal);
      // // List<String> timeParts = waktu.split(':');
      // DateTime pickDatetime = DateTime(date.year, date.month, date.day, int.parse(timeParts[0]), int.parse(timeParts[1]));
      // Validasi form, misalnya memastikan semua field terisi dengan benar
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
      if (pickDatetime.isBefore(DateTime.now())){
        // alert(context, "Tanggal harus setelah atau sama dengan tanggal sekarang !");
        print('Tanggal harus setelah atau sama dengan tanggal sekarang !');
      }
      if(pickDatetime.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        // alert(context, "Waktu harus lebih dari 5 menit dari waktu sekarang !");
        print('Waktu harus lebih dari 5 menit dari waktu sekarang !');
        return;
      }
      todayAcara.forEach((item) {
        if(DateTime.parse(item['tanggal']).difference(pickDatetime).inMinutes <  5){
          print('Waktu harus lebih dari 5 menit dari setiap acara !');
          return;
        }
      });
      Map<String, dynamic> response = await apiService.buatAcara(namaAcara, deskripsi, DateFormat('dd-MM-yyyy HH:mm').format(pickDatetime));
      if (response['status'] == 'success') {
        Map<String, dynamic> data = {
          'nama_acara':namaAcara,
          'deskripsi':deskripsi,
          'tanggal':tanggal,
        };
        acaraClass.tambahAcara(data);
        print(response['message']);
        // Navigator.pushReplacement(context, pageMove.movepage(RiwayatCalendar()));
      } else {
        print(response['message']);
        // alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat calendar : $e');
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
    );
    if (picked != null) {
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      final DateTime minDateTime = now.add(const Duration(minutes: 5));

      if (selectedDateTime.isAfter(minDateTime)) {
        setState(() {
          _timeController.text = picked.format(context);
        });
      } else {
        // Show a message or handle invalid time selection
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Invalid Time"),
              content:
                  const Text("Tolong pilih waktu minimal 5 menit dari sekarang."),
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
                    _dateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDay);
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
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
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
                        setState(() {
                          //isi fungsi disini
                        });
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
