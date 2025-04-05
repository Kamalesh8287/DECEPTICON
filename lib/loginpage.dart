import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const MaterialApp(home: PhoneAuthPage()));
}

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isOtpSent = false;
  bool _isLoading = false;

  void _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final phoneNumber = '+1${_phoneController.text.trim()}';
        if (!RegExp(r'^\+1\d{10}$').hasMatch(phoneNumber)) {
          throw Exception('Invalid phone number format.');
        }
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (cred) async {
            await _auth.signInWithCredential(cred);
            _showMessage('Phone Number Verified');
          },
          verificationFailed: (e) {
            _showMessage('Verification Failed: ${e.message}');
            setState(() => _isLoading = false);
          },
          codeSent: (id, _) {
            setState(() {
              _isOtpSent = true;
              _isLoading = false;
              _verificationId = id;
            });
            _showMessage('OTP Sent');
          },
          codeAutoRetrievalTimeout: (id) {
            setState(() {
              _verificationId = id;
            });
          },
        );
      } catch (e) {
        _showMessage('Error: $e');
        setState(() => _isLoading = false);
      }
    }
  }

  void _verifyOtp() async {
    if (_otpController.text.trim().isNotEmpty && _verificationId != null) {
      try {
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: _otpController.text.trim(),
        );
        await _auth.signInWithCredential(credential);
        _showMessage('Phone Number Verified');
      } catch (e) {
        _showMessage('Invalid OTP, please try again.');
      }
    } else {
      _showMessage('Please enter the OTP');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text('Login page', style: TextStyle(color: Colors.white 
       , fontWeight: FontWeight.w600)),
        backgroundColor: const Color.fromARGB(255, 246, 97, 97),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB88C), Color(0xFFDE6262)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 8,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.phone_android, size: 80, color: Color.fromARGB(255, 240, 36, 36)),
                      const SizedBox(height: 16),
                      const Text(
                        'Login  ',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 245, 64, 64),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We will send you an OTP to verify your number',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 32),

                      // Phone Field
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // OTP Field
                      if (_isOtpSent)
                        TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter OTP',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                      const SizedBox(height: 24),

                      // Send OTP / Verify Button
                      _isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isOtpSent ? _verifyOtp : _sendOtp,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: const Color.fromARGB(255, 236, 65, 65),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Text(
                                  _isOtpSent ? 'Verify OTP' : 'Send OTP',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
