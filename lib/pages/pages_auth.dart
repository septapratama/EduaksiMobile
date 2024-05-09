import 'dart:async';
import 'package:eduapp/component/custom_appbar.dart';
import 'package:eduapp/component/custom_colors.dart';
import 'package:eduapp/pages/ganti_password.dart';
import 'package:eduapp/pages/login_screen.dart';
import 'package:eduapp/pages/pages_lupakatasandi.dart';
import 'package:eduapp/pages/popup_screen.dart';
import 'package:eduapp/pages/register_screen.dart';
import 'package:eduapp/utils/ApiService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
  final ApiService apiService = ApiService();
  TextEditingController otpController = TextEditingController();
  @override
  void initState(){
    super.initState();
    if(widget.otpData['waktu'] == null){
      reSendOTP();
    }else{
      widget.startCountdown(widget.otpData['waktu']);
    }
  }
  void sendOTP(BuildContext context) async {
    try {
      if(!widget._timerRunning){
        print('Cannot send OTP ');
        // alert(context, response['message']);
        return;
      }
      if(otpController.text.length < 6){
        print('Please fill all boxes');
        // Alert or display an error message
        return;
      }
      String cond = widget.otpData['cond'];
      Map<String, dynamic> response = await apiService.verifyOtp(widget.otpData['email'], widget.linkVerifyOtp[cond]!, otpController.text);
      if (response['status'] == 'success') {
        //check if from register or lupa password
        if(cond == 'email'){
          Navigator.pushReplacement(context, pageMove.movepage(const PopupScreen(pesan:'Berhasil verifikasi email')));
        }else{
          Navigator.pushReplacement(context, pageMove.movepage(GaPassScreen(gaPassData: {'email': widget.otpData['email'], 'otp': otpController.text})));
        }
      } else {
        print(response['message']);
        // alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat kirim otp : $e');
    }
  }
  void reSendOTP() async {
    try {
      if(widget._timerRunning){
        print('Cannot resend OTP as timer is still running');
        // alert(context, response['message']);
        return;
      }
      Map<String, dynamic> response = await apiService.sendOtp(widget.otpData['email'], widget.linkOtp[widget.otpData['cond']]!);
      if (response['status'] == 'success') {
        widget.startCountdown(DateTime.parse(response['data']['waktu']));
        // alert(context, response['message']);
      } else {
        print(response['message']);
        // alert(context, response['message']);
      }
    } catch (e) {
      print('Error saat kirim ulang otp : $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Kode OTP'),
      body: SafeArea(
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
              PinInputTextField(
                pinLength: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: BoxLooseDecoration(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  strokeColorBuilder: PinListenColorBuilder(
                    const Color(0xFFCCCCCC), // Default border color
                    Colors.black, // Border color when typing
                  ),
                ),
                autoFocus: true,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
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
