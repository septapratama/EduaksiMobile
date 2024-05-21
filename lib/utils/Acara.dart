import 'dart:convert';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Acara{
  late SharedPreferences prefs;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Acara(){
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    // _removeExpiredEvents();
  }

  // Future<void> _initNotifications() async {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //   // Initialize time zones
  //   tz.initializeTimeZones();
  // }

  Future<void> _removeExpiredEvents() async {
    List<Map<String, dynamic>> acaraData = getAcaraData();
    DateTime now = DateTime.now();
    acaraData.removeWhere((item) {
      DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(item['tanggal']);
      return dateTime.isBefore(now);
    });
    prefs.setString('acara', json.encode(acaraData));
  }


  Future<void> _sorted() async {
    List<Map<String, dynamic>> acaraData = prefs.getString('acara') != null ? json.decode(prefs.getString('acara')!).cast<Map<String, dynamic>>() : [];
    acaraData.sort((a, b) {
      DateTime dateTimeA = DateFormat('dd-MM-yyyy HH:mm').parse(a['tanggal']);
      DateTime dateTimeB = DateFormat('dd-MM-yyyy HH:mm').parse(b['tanggal']);
      Duration differenceA = dateTimeA.difference(DateTime.now());
      Duration differenceB = dateTimeB.difference(DateTime.now());
      return differenceA.compareTo(differenceB);
    });
    prefs.setString('acara', json.encode(acaraData));
  }

  Future<void> fetchData(ApiService apiService) async {
    if(prefs.getString('acara') == null){
      Map<String, dynamic> response = await apiService.fetchAcara();
      if (response['status'] == 'success') {
        prefs.setString('acara', json.encode(response['data']));
        _sorted();
      } else {
        // print(response['message']);
      }
    }
  }

  List<Map<String, dynamic>> getAcaraData() {
    return prefs.getString('acara') != null ? json.decode(prefs.getString('acara')!).cast<Map<String, dynamic>>() : [];
  }

  Future<List<Map<String, dynamic>>> getTodayAcara() async {
    List<Map<String, dynamic>> acaraData = getAcaraData();
    DateTime curDay = DateTime.now();
    return acaraData.where((item) {
      DateTime tooDate = DateFormat('dd-MM-yyyy HH:mm').parse(item['tanggal']);
      return tooDate.year == curDay.year && tooDate.month == curDay.month && tooDate.day == curDay.day;
    }).toList();
  }

  Future<void> tambahAcara(Map<String, dynamic> data) async {
    List<Map<String, dynamic>> acaraData = getAcaraData();
    acaraData.add(data);
    prefs.setString('acara', json.encode(acaraData));
    _sorted();
    // await scheduleNotification(acaraData);
  }

  Future<void> editAcara(String idAcara,Map<String, dynamic> data) async {
    List<Map<String, dynamic>> acaraData = getAcaraData();
    acaraData.forEach((item) {
      if (item['id_acara'] == idAcara) {
        item['nama_acara'] = data['nama_acara'];
        item['deskripsi'] = data['deskripsi'];
        item['tanggal'] = data['tanggal'];
      }
    });
    prefs.setString('acara', json.encode(acaraData));
    _sorted();
    // await scheduleNotification(acaraData);
  }

  //delete acara from riwayat acara
  Future<void> deleteAcara(List<String> idAcara) async {
    List<Map<String,dynamic>> acaraData = getAcaraData();
    idAcara.forEach((element) {
      acaraData.removeWhere((item)=> item['id_acara'] == element);
    });
    prefs.setString('acara', json.encode(acaraData));
    _sorted();
    // await scheduleNotification(acaraData);
  }

  Future<void> removeAcara() async{
    prefs.remove('acara');
  }

  // Future<void> scheduleNotification(List<Map<String, dynamic>> acaraList) async {
  //   _initNotifications();
  //   acaraList.forEach((acara) async {
  //     DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(acara['tanggal']);
  //     // Schedule the notification
  //     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'acara_channel_id', // Change this to a unique channel ID for your app
  //       'acara_channel_name', // Change this to a unique channel name for your app
  //       'acara_channel_description', // Change this to a unique channel description for your app
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //     );
  //     const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  //     await flutterLocalNotificationsPlugin.zonedSchedule(
  //       acara['id'], // Use a unique ID for each notification
  //       acara['nama_acara'], // Notification title
  //       acara['deskripsi'], // Notification body
  //       tz.TZDateTime.from(dateTime, tz.local), // Notification time
  //       platformChannelSpecifics,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  //   });
  // }
}