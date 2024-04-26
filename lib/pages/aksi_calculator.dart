import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/pages_AksiMenu.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _selectedGender = 'Laki-laki'; // Nilai default
  String _age = ''; // Nilai usia
  String _tinggiBadan = ''; // Nilai tinggi badan dalam cm
  String _beratBadan = ''; // Nilai berat badan dalam kg
  double _beratBadanIdeal = 0.0; // Variabel untuk menyimpan berat badan ideal

  void calculateIdealWeight() {
    if (_tinggiBadan.isNotEmpty) {
      try {
        final tinggiBadanCm = double.parse(_tinggiBadan); // Pastikan ini dalam cm
        if (_selectedGender == 'Laki-laki') {
          _beratBadanIdeal = tinggiBadanCm - 100; // Rumus Broca untuk laki-laki
        } else {
          _beratBadanIdeal = tinggiBadanCm - 104; // Rumus Broca untuk perempuan
        }
      } catch (e) {
        // Handle error, misal dengan menampilkan pesan error bahwa input tidak valid
        print("Error: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Calculator Berat Badan Ideal',
        buttonOnPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AksiMenu()),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: customColor.primaryColors,
                          width: 1.25), // Menambahkan border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Menghapus border bawaan
                          isDense: true, // Mengurangi ketinggian dropdown
                          contentPadding:
                              EdgeInsets.zero, // Menghilangkan padding dropdown
                        ),
                        value: _selectedGender,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue!;
                          });
                        },
                        items: <String>['Laki-laki', 'Perempuan']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Usia',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity, // Menyesuaikan lebar dengan parent
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: customColor.primaryColors,
                          width: 1.25), // Menambahkan border
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Input Usia Anda',
                          // Atur tinggi di sini
                        ),
                        onChanged: (value) {
                          setState(() {
                            _age = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Form Tinggi Badan
                  const Text(
                    'Tinggi Badan (cm)',
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
                          color: customColor.primaryColors, width: 1.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Input Tinggi Badan Anda (cm)',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _tinggiBadan = value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Form Berat Badan
                  const Text(
                    'Berat Badan (kg)',
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
                          color: customColor.primaryColors, width: 1.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Input Berat Badan Anda (kg)',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _beratBadan = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: CustomButton.overallButtonStyle(),
                      onPressed: () {
                        setState(() {
                          calculateIdealWeight();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30.0),
                        child: Text(
                          'Hitung',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins_Bold',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          ListTile(
                            leading: const Icon(Icons.person_outline, size: 24),
                            title: const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text(_selectedGender),
                          ),
                          ListTile(
                            leading: const Icon(Icons.cake, size: 24),
                            title: const Text('Umur', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text('$_age tahun'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.monitor_weight, size: 24),
                            title: const Text('Berat Ideal', style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text('${_beratBadanIdeal.toStringAsFixed(1)} kg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
