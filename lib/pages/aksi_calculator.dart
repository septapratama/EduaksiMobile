import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_button.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/pages_AksiMenu.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _selectedGender = 'Laki-laki'; // Nilai default
  String _age = ''; // Nilai usia

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  SizedBox(height: 8),
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
                        decoration: InputDecoration(
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
                  SizedBox(height: 16),
                  Text(
                    'Usia',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  SizedBox(height: 8),
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
                        decoration: InputDecoration(
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
                  SizedBox(height: 16),

                  // Form Tinggi Badan
                  Text(
                    'Tinggi Badan (cm)',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  SizedBox(height: 8),
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Input Tinggi Badan Anda',
                        ),
                        onChanged: (value) {
                          // Implementasi onChanged sesuai kebutuhan
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Form Berat Badan
                  Text(
                    'Berat Badan (kg)',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins_Bold',
                    ),
                  ),
                  SizedBox(height: 8),
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Input Berat Badan Anda',
                        ),
                        onChanged: (value) {
                          // Implementasi onChanged sesuai kebutuhan
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: CustomButton.overallButtonStyle(),
                      onPressed: () {
                        // Implementasi ketika tombol ditekan
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
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
                ],
              ),
              // Tambahkan komponen-komponen form lainnya di sini
            ),
          ),
        ],
      ),
    );
  }
}
