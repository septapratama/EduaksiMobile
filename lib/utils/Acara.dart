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
    _removeExpiredEvents();
  }

  void _removeExpiredEvents(){
    List<Map<String, dynamic>> acaraData = getAcaraData();
    DateTime now = DateTime.now();
    acaraData.removeWhere((item) {
      DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(item['tanggal']);
      return dateTime.isBefore(now);
    });
    prefs.setString('acara', json.encode(acaraData));
  }


  Future<void> _sorted() async {
    List<Map<String, dynamic>> acaraData = prefs.getString('acara') != null ? json.decode(prefs.getString('acara')!).cast<Map<String, dynamic>>() : [];
    acaraData.sort((a, b) {
      DateTime dateTimeA = DateFormat('yyyy-MM-dd HH:mm').parse(a['tanggal']);
      DateTime dateTimeB = DateFormat('yyyy-MM-dd HH:mm').parse(b['tanggal']);
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
      DateTime tooDate = DateFormat('yyyy-MM-dd HH:mm').parse(item['tanggal']);
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

  Future<void> _initNotifications() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('flutter_logo');
    final IOSInitializationSettings  initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      },
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
        // Handle the notification tapped logic here
      },
    );
    tz.initializeTimeZones();
  }

  Future<void> scheduleNotification(List<Map<String, dynamic>> acaraList) async {
    _initNotifications();
    acaraList.forEach((acara) async {
      DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(acara['tanggal']);
      // Schedule the notification
      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'acara_channel_id', // Change this to a unique channel ID for your app
        'acara_channel_name', // Change this to a unique channel name for your app
        'acara_channel_description', // Change this to a unique channel description for your app
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        acara['id'],
        acara['nama_acara'],
        acara['deskripsi'],
        tz.TZDateTime.from(dateTime, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    });
  }
}