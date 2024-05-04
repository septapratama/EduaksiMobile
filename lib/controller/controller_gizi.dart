class GiziController{
  //hitung kalkulator gizi
  // referensi https://www.mymealcatering.com/kesehatan/cara-menghitung-akg-yang-benar.html
  Map<String, dynamic> hitungGizi(String nama, String jenis_kelamin, int usia, int bb, int tb, int kondisi){
    const olahraga = [1.2, 1.375, 1.55, 1.725, 1.9];
    int kalori = 0;
    if(jenis_kelamin == 'laki_laki'){
      //hitung kalori perhari
      kalori = (66 + (13.7 * bb) + (5 * tb) - (6.8 * usia)).toInt();
      //hitung kalori dengan olahraga
      kalori = (kalori * olahraga[kondisi]).toInt();
    }else if(jenis_kelamin == 'perempuan'){
      //hitung kalori perhari
      kalori = (655 + (9.6 * bb) + (1.8 * tb) - (4.7 * usia)).toInt();
      //hitung kalori dengan olahraga
      kalori = (kalori * olahraga[kondisi]).toInt();
    }
    if(kalori == 0){
      return { 'status':'error'};
    }
    int protein = ((kalori * 14) ~/100 *4).toInt(); // convert ke gram
    int karbohidrat = ((kalori * 60) ~/100 * 4).toInt(); // convert ke gram
    int lemak = ((kalori * 15) ~/ 100 * 4).toInt(); // convert ke gram
    return { 'status':'success', 'data':{
      'protein':'$protein gram',
      'karbohidrat':'$karbohidrat gram',
      'lemak':'$lemak gram'
    }};
  }

  // hitung indeks massa tubuh
  // Helper function to determine BMI status
  String _getBMIStatus(double bmi, double bmiThreshold) {
    if (bmi < bmiThreshold) {
      return 'Underweight';
    } else if (bmi >= bmiThreshold && bmi < 25.0) {
      return 'Normal';
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
  //referensi https://hellosehat.com/nutrisi/cara-menghitung-indeks-massa-tubuh/
  Map<String, dynamic> calculateBMI(String jenis_kelamin, int bb, int tb) {
    const double bmiLakiLaki = 22.0;
    const double bmiPerempuan = 21.0;
    double bmi = 0.0;
    String status = '';
    if (jenis_kelamin == 'laki_laki') {
      bmi = bb / ((tb / 100) * (tb / 100));
      status = _getBMIStatus(bmi, bmiLakiLaki);
    } else if (jenis_kelamin == 'perempuan') {
      bmi = bb / ((tb / 100) * (tb / 100));
      status = _getBMIStatus(bmi, bmiPerempuan);
    } else {
      return {'status': 'error', 'message': 'Invalid gender value'};
    }
    return {
      'status': 'success',
      'data': {
        'bmi': bmi.toStringAsFixed(2),
        'status': status,
      },
    };
  }
}