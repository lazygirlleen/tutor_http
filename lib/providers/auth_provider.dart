import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  //change notifier ngingetin kalau ada sesuatu yang berubah di widgetnya
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //objek auth state yang dikelola oleh firebase

  User? _user;
  //propertinya private untuk kelasnya saja

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> login({required String email, required String password}) async {
    //bisa tampung apa yang akan diterima oleh fitur login
    //buat apa yang bisa diterima di dalam fitur login
    //kita terima mentah aja email dan password (apa yang siap di submit di firebase)
    //< > tipe data
    try {
      //pakai kata kunci credential yang datang dari pemanggilan yang kita tungguin await
      final credential = await _auth.signInWithEmailAndPassword(
        //signin anonymously biasanya buat user yang guest (kita gak butuh simpan datanya tapi diizinkan sebagai anonim)
        email: email,
        password: password,
      );

      _user = credential.user;
      //sampai disini user sudah login
    } on FirebaseAuthException catch (error) {
      //Tembak langsung menggunakan kata kunci on classnya
      //jadi saat kejadian error yang dihasilkan itu menghasilkan kelas firebaseauthexception
      switch (error.code) {
      //kita cukup melihat ccode errornya
        case 'INVALID_LOGIN_CREDENTIALS':
          throw 'Invalid login credentials.';
        default:
          rethrow;
      }
    }

    notifyListeners();
  }

  //prosedur logoutnya sederhana ngehapus data user di aplikasi
   Future<void> logout() async {
    _user = null;

    await _auth.signOut();
    //sesi login nya bisa langsung digugurkan dari ruang lingkup yang sudah terverifikasi itu

    notifyListeners();
  }
}


