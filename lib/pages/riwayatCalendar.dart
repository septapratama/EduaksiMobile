import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:eduapp/pages/calendar.dart';
import 'package:eduapp/pages/calendarShow.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_button.dart';

// Define your EventData class
class EventData {
  final String tanggal;
  final String waktu;
  final String kategori;
  final String acara;

  EventData({
    required this.tanggal,
    required this.waktu,
    required this.kategori,
    required this.acara
  });
}

// Define your list of data
List<EventData> eventList = [
  EventData(
    tanggal: '2024-05-08',
    waktu: '13:00',
    kategori: 'Acara Umum',
    acara: 'Team meeting for project discussion',
  ),
  EventData(
    tanggal: '2024-05-09',
    waktu: '10:30',
    kategori: 'Acara Penting',
    acara: 'Training session on new software tools',
  ),
  EventData(
    tanggal: '2024-05-10',
    waktu: '15:45',
    kategori: 'Acara Keluarga',
    acara: 'Client presentation for project proposal',
  ),
  EventData(
    tanggal: '2024-05-12',
    waktu: '09:00',
    kategori: 'Acara Umum',
    acara: 'Interview scheduled for new hires',
  ),
];

class RiwayatCalendar extends StatefulWidget {
  RiwayatCalendar({super.key});

  @override
  _RiwayatCalendarState createState() => _RiwayatCalendarState();
}
class _RiwayatCalendarState extends State<RiwayatCalendar> {
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
                itemCount: eventList.length, // Use eventList here
                itemBuilder: (BuildContext context, int index) {
                  // Define color based on category
                  Color cardColor;
                  switch (eventList[index].kategori) {
                    case 'Acara Umum':
                      cardColor = Colors.green; // Hijau untuk Acara Umum
                      break;
                    case 'Acara Penting':
                      cardColor = Colors.red; // Merah untuk Acara Penting
                      break;
                    case 'Acara Keluarga':
                      cardColor = Colors.orange; // Kuning untuk Acara Keluarga
                      break;
                    default:
                      cardColor = Colors
                          .grey; // Warna default jika kategori tidak dikenali
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowCalendar()),
                      );
                    },
                    child: Card(
                      color: cardColor, // Set warna card sesuai dengan kategori
                      margin:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Tanggal: ${eventList[index].tanggal}',
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
                              'Waktu: ${eventList[index].waktu}',
                              style: const TextStyle(
                                color: Colors
                                    .white, // Ganti warna teks menjadi putih
                                fontSize: 14, // Sesuaikan ukuran font
                                fontFamily:
                                    'Poppins_Bold', // Ganti dengan nama font kustom Anda
                              ),
                            ),
                            Text(
                              'Kategori Acara: ${eventList[index].kategori}',
                              style: const TextStyle(
                                color: Colors
                                    .white, // Ganti warna teks menjadi putih
                                fontSize: 14, // Sesuaikan ukuran font
                                fontFamily:
                                    'Poppins_Bold', // Ganti dengan nama font kustom Anda
                              ),
                            ),
                            Text(
                              'Acara: ${eventList[index].acara}',
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
