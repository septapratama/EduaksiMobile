import 'dart:async';
import 'package:eduapp/component/custom_alert.dart';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/component/custom_loading.dart';
import 'package:eduapp/pages/ganti_password.dart';
import 'package:eduapp/pages/popup_screen.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:eduapp/component/custom_pagemove.dart';

class OTPScreen extends StatefulWidget {
  final Map<String, dynamic> otpData;
  OTPScreen({super.key, required this.otpData});
  final linkOtp = {
    'email': '/verify/create/email',
    'password':  '/verify/create/password',
  };
  final linkVerifyOtp = {
    'email': '/verify/otp/email',
    'password':  '/verify/otp/password',
  };
  @override
  _OTPScreenState createState() => _OTPScreenState();
  late Timer _timer;
  late StreamController<String> _controller = StreamController<String>();
  bool _timerRunning = false;
  Stream<String> get timerStream => _controller.stream;
  void startCountdown(DateTime waktu) {
    _timerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration difference = waktu.difference(now);
      if (difference.inSeconds <= 0) {
        _timer.cancel();
        _controller.add('00:00');
        _timerRunning = false;
        return;
      }
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);
      String timerString = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      _controller.add(timerString);
    });
  }
  void dispose() {
    _controller.close();
    _timer.cancel();
    _timerRunning = false;
  }
}
class _OTPScreenState extends State<OTPScreen> {
  final double _wBox = 100;
  final double _hBox = 68;
  final ApiService apiService = ApiService();
  late List<TextEditingController> otpController;
  @override
  void initState(){
    super.initState();
    otpController = List.generate(6, (index) => TextEditingController());
    if(widget.otpData['waktu'] == null){
      reSendOTP();
    }else{
      widget.startCountdown(widget.otpData['waktu']);
    }
  }
  void sendOTP(BuildContext context) async {
    try {
      if(!widget._timerRunning){
        print('kode otp sudah terkirim mohon cek kembali');
        CostumAlert.show(context, 'kode otp sudah terkirim mohon cek kembali', "Gagal kirim ulang kode otp!", Icons.error, Colors.red);
        return;
      }
      if (!otpController.every((controller) => controller.text.length == 1)) {
        print('Semua kotak harus di isi !');
        CostumAlert.show(context, 'Semua kotak harus di isi !', "Gagal kirim ulang kode otp!", Icons.error, Colors.red);
        return;
      }
      String otpCode = otpController.map((controller) => controller.text).join();
      String cond = widget.otpData['cond'];
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.verifyOtp(widget.otpData['email'], widget.linkVerifyOtp[cond]!, otpCode);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        //check if from register or lupa password
        if(cond == 'email'){
          Navigator.pushReplacement(context, pageMove.movepage(const PopupScreen(pesan:'Berhasil verifikasi email')));
        }else{
          Navigator.pushReplacement(context, pageMove.movepage(GaPassScreen(gaPassData: {'email': widget.otpData['email'], 'otp': otpCode})));
        }
      } else {
        print(response['message']);
        CostumAlert.show(context, response['message'], "Gagal kirim ulang kode otp!", Icons.error, Colors.red);
      }
    } catch (e) {
      print('Error saat kirim otp : $e');
    }
  }
  void reSendOTP() async {
    try {
      if(widget._timerRunning){
        CostumAlert.show(context, 'Kode otp sudah terkirim mohon cek kembali', "Gagal kirim ulang kode otp!", Icons.error, Colors.red);
        return;
      }
      CustomLoading.showLoading(context);
      Map<String, dynamic> response = await apiService.sendOtp(widget.otpData['email'], widget.linkOtp[widget.otpData['cond']]!);
      CustomLoading.closeLoading(context);
      if (response['status'] == 'success') {
        CostumAlert.show(context, 'Kode otp sukses terkirim mohon cek kembali',"Berhasil kirim ulang kode otp!",Icons.check, Colors.green);
        widget.startCountdown(DateTime.parse(response['data']['waktu']));
      } else {
        CostumAlert.show(context, response['message'], "Gagal kirim ulang kode otp!", Icons.error, Colors.red);
      }
    } catch (e) {
      print('Error saat kirim ulang otp : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kode OTP'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 75, right: 75),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align content to the start (left)
            children: [
              const Text(
                'Kode OTP',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins_SemiBold',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Masukan Kode OTP Anda!',
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins_Regular',
                    color: Color.fromARGB(255, 80, 81, 85)),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Flexible(
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Container(
                            // height: 68,
                            // width: 100,
                            child: TextField(
                              controller: otpController[index],
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.white,
                                // isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  // minHeight: 100,
                                ),
                              ),
                              style: Theme.of(context).textTheme.headlineLarge,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // PinInputTextField(
              //   pinLength: 6,
              //   controller: otpController,
              //   keyboardType: TextInputType.number,
              //   decoration: BoxLooseDecoration(
              //     textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              //     strokeColorBuilder: PinListenColorBuilder(
              //       const Color(0xFFCCCCCC), // Default border color
              //       Colors.black, // Border color when typing
              //     ),
              //     gapSpace: 10.0, // Space between each input box
              //     strokeWidth: 2.0, // Border width

              //   ),
              //   autoFocus: true,
              //   textInputAction: TextInputAction.done,
              //   inputFormatters: <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly
              //   ],
              // ),
              // Add space between the OTP input and text button
              StreamBuilder<String>(
                stream: widget.timerStream,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text(snapshot.data ?? '00:00');
                  } else {
                    return const Text('00:00');
                  }
                }
              ),
              const SizedBox(height: 35),
              const Text(
                'Anda belum menerima kode OTP? ',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins_Regular'),
              ),
              TextButton(
                onPressed: () => reSendOTP(),
                child: Text(
                  'Kirim ulang',
                  style: TextStyle(
                      fontSize: 14,
                      color: customColor.primaryColors,
                      fontFamily: 'Poppins_SemiBold'),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: () => sendOTP(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 50), // Adjust padding as needed
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(30, 84, 135, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Oke',
                    style: TextStyle(
                      fontFamily: 'Poppins_SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}