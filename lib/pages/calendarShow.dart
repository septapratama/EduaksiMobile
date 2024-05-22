import 'dart:convert';

import 'package:capitalize/capitalize.dart';
import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_appbar.dart';
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
  final Map<DateTime, List> _events = {};
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final TextEditingController _namaAcaraController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();

  final List<String> _categoryList = ['umum', 'penting', 'keluarga'];
  late Map<String, dynamic> acaraData;
  late DateTime _inpDate = DateTime.now();
  late DateTime _pickDateShow = DateTime.now();
  late DateTime _pickDateEdit = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedCategory;
  String? _categoryEdited;
  bool _isEdit = false;
  bool _isEditProcess = false;

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
        _selectedCategory = _categoryList.contains(acaraData['kategori']) ? acaraData['kategori'] : null;
        _inpDate = DateFormat('yyyy-MM-dd HH:mm').parse(acaraData['tanggal']);
        _pickDateShow = _inpDate;
        _pickDateEdit = _inpDate;
        _selectedTime = TimeOfDay(hour: _inpDate.hour, minute: _inpDate.minute);
        _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(_inpDate);
        _waktuController.text = DateFormat('HH:mm').format(_inpDate);
      });
    }
  }

  void _editAcara(BuildContext context) async {
    try{
      if(_isEditProcess) return;
      List<Map<String, dynamic>> todayAcara = await acaraClass.getTodayAcara();
      String namaAcara = _namaAcaraController.text;
      String deskripsi = _deskripsiController.text;
      String tanggal = _tanggalController.text;
      String waktu = _waktuController.text;
      //checking if data same
      if(namaAcara == acaraData['nama_acara'] && deskripsi == acaraData['deskripsi'] && _selectedCategory == acaraData['kategori'] && _pickDateEdit == _inpDate && _selectedTime == TimeOfDay(hour: _inpDate.hour, minute: _inpDate.minute)){
        CostumAlert.show(context, "Data belum diubah !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      //validator
      if (tanggal.isEmpty) {
        CostumAlert.show(context, "Tanggal tidak boleh kosong !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      if (waktu.isEmpty) {
        CostumAlert.show(context, "Waktu tidak boleh kosong !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      if (namaAcara.isEmpty) {
        CostumAlert.show(context, "Nama acara tidak boleh kosong !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      if (deskripsi.isEmpty) {
        CostumAlert.show(context, "Deskripsi tidak boleh kosong !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      if (_selectedCategory!.isEmpty) {
        CostumAlert.show(context, "Kategori tidak boleh kosong !", "gagal edit kalender!",Icons.error, Colors.red);
        return;
      }
      final DateTime pickDatetime = DateTime(
        _pickDateEdit.year,
        _pickDateEdit.month,
        _pickDateEdit.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );
      if (pickDatetime.isBefore(DateTime.now())){
        CostumAlert.show(context, "Tanggal harus setelah atau sama dengan tanggal sekarang !", "gagal edit kalender!",Icons.error, Colors.red);
      }else if(pickDatetime.isBefore(DateTime.now().add(const Duration(minutes: 5)))) {
        CostumAlert.show(context, "Waktu harus lebih dari 5 menit dari waktu sekarang !", "gagal edit kalender!",Icons.error, Colors.red);
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
      _isEditProcess = true;
      Map<String, dynamic> response = await apiService.editAcara(widget.idAcara, namaAcara, deskripsi, _selectedCategory!, parDa);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        Map<String, dynamic> data = {
          'nama_acara':namaAcara,
          'deskripsi':deskripsi,
          'kategori':_selectedCategory!,
          'tanggal':parDa,
        };
        acaraClass.editAcara(widget.idAcara, data);
        CostumAlert.show(context, "Berhasil edit acara","Berhasil edit acara",Icons.check, Colors.green);
        refreshData();
        Future.delayed(const Duration(seconds: 1), () {
          _isEditProcess = false;
        });
      } else {
        CostumAlert.show(context, response['message'], "gagal edit kalender!",Icons.error, Colors.red);
        String errRes = response['message'].toString();
        if(errRes.contains('login') || errRes.contains('expired')){
          Future.delayed(const Duration(seconds: 2), () {
            return Navigator.pushReplacement(context, pageMove.movepage(const LoginScreen()));
          });
        }
        Future.delayed(const Duration(seconds: 1), () {
          _isEditProcess = false;
        });
      }
    } catch (e) {
      print('Error saat edit calender : $e');
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if(!_isEdit) return;
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
        _pickDateEdit.year,
        _pickDateEdit.month,
        _pickDateEdit.day,
        picked.hour,
        picked.minute,
      );
      final DateTime  now = DateTime.now();
      if(selectedDateTime.isBefore(now)) {
        CostumAlert.show(context, "Pilih waktu harus lebih dari sekarang !", "Invalid time!",Icons.error, Colors.red);
        return;
      }else if(selectedDateTime.isBefore(now.add(const Duration(minutes: 5)))) {
        CostumAlert.show(context, "Pilih waktu minimal 5 menit dari sekarang !", "Invalid time!",Icons.error, Colors.red);
        return;
      }
      _selectedTime = picked;
      setState(() {
        _waktuController.text = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }
  void refreshData(){
    setState(() {
      _isEdit = false;
      _categoryEdited = _selectedCategory;
      acaraData = acaraClass.getAcaraData().firstWhere((item) => item['id_acara'] == widget.idAcara);
      _inpDate = DateFormat('yyyy-MM-dd HH:mm').parse(acaraData['tanggal']);
      _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(_inpDate);
      _pickDateShow = _inpDate;
    });
  }
  void _changeMode(){
    _isEdit = !_isEdit;
    setState(() {
      if (_isEdit) {
        _focusNode1.unfocus();
        _focusNode2.unfocus();
      }else{
        _pickDateEdit = _inpDate;
        _selectedTime = TimeOfDay(hour: _inpDate.hour, minute: _inpDate.minute);
        _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(_inpDate);
        _waktuController.text = DateFormat('HH:mm').format(_inpDate);
        if(_categoryList.contains(acaraData['kategori'])){
          _selectedCategory = _categoryEdited ?? acaraData['kategori'];
        }else{
          _selectedCategory = _categoryEdited ?? null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _isEdit ? 'Edit Kalender' : 'Lihat Kalender',
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RiwayatCalendar()),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _isEdit ? TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _pickDateEdit,
                availableGestures: AvailableGestures.horizontalSwipe,
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Month', // Hanya menampilkan format bulanan
                },
                selectedDayPredicate: (day) => isSameDay(day, _pickDateEdit),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _pickDateEdit = selectedDay;
                    _tanggalController.text = DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(selectedDay);
                  });
                },
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
              )
              : TableCalendar(
                firstDay: DateTime.now(),
                lastDay: _pickDateShow,
                focusedDay: _pickDateShow,
                availableGestures: AvailableGestures.none,
                availableCalendarFormats: const {
                  CalendarFormat.month:
                      'Month', // Hanya menampilkan format bulanan
                },
                selectedDayPredicate: (day) => isSameDay(day, _pickDateShow),
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children:[
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
                          onTap: () {
                            _selectTime(context);
                          },
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        items: _categoryList.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text('Acara $category'),
                          );
                        }).toList(),
                        onChanged: _isEdit ? (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        } : null,
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
                          readOnly: !_isEdit,
                          focusNode: _focusNode1,
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
                          readOnly: !_isEdit,
                          focusNode: _focusNode2,
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
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 90,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RiwayatCalendar()));
                        },
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                    _isEdit ?
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
                                backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => _editAcara(context),
                              child: const Text(
                                'Simpan',
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
                      width: 120,
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
                          'Ubah Acara',
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
            ],
          ),
        ),
      ),
    );
  }
}
