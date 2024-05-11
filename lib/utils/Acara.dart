import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Acara{
  late SharedPreferences prefs;
  Acara(){
    init();
  }
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
  Future<List<Map<String, dynamic>>> getTodayAcara() async {
    List<Map<String,dynamic>> acaraData = json.decode(prefs.getString('acara')!) ?? {};
    List<Map<String, dynamic>> todayAcara = [];
    DateTime curDay = DateTime.now();
    acaraData.forEach((item) {
      DateTime tooDate = DateTime.parse(item['tanggal']);
      if (tooDate.year == curDay.year && tooDate.month == curDay.month && tooDate.day == curDay.day) {
        todayAcara.add(item);
      }
    });
    return todayAcara;
  }
  Future<void> tambahAcara(Map<String, dynamic> data) async {
    List<Map<String,dynamic>> acaraData = json.decode(prefs.getString('acara')!) ?? {};
    prefs.setString('acara', json.encode(acaraData));
    // await scheduleNotification();
  }
  Future<void> editAcara(Map<String, dynamic> data) async {
    List<Map<String,dynamic>> acaraData = json.decode(prefs.getString('acara')!);
    acaraData;
    prefs.setString('acara', json.encode(acaraData));
    // await scheduleNotification();
  }
  Future<void> deleteAcara(String id_acara) async {
    List<Map<String,dynamic>> acaraData = json.decode(prefs.getString('acara')!);
    acaraData.removeWhere((item)=> item['id_acara'] == id_acara);
    prefs.setString('acara', json.encode(acaraData));
    // await scheduleNotification();
  }
  // Future<void> scheduleNotification(Map<String, dynamic> data) async {
  //   // Extract event details from the data map
  //   String namaAcara = data['nama_acara'];
  //   String deskripsi = data['deskripsi'];
  //   String tanggalWaktu = data['tanggal_waktu'];

  //   // Schedule the notification
  //   final DateTime notificationTime = DateTime.parse(tanggalWaktu);
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'acara_channel_id', // Change this to a unique channel ID for your app
  //     'acara_channel_name', // Change this to a unique channel name for your app
  //     'acara_channel_description', // Change this to a unique channel description for your app
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //   const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     0, // Use a unique ID for each notification
  //     'Reminder: $namaAcara', // Notification title
  //     deskripsi, // Notification body
  //     tz.TZDateTime.from(notificationTime, tz.local), // Notification time
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

}