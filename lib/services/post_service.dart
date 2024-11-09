import 'dart:convert';

import 'package:http/http.dart' as http; //import seperti berikut ini supaya kita bisa membedakan pemanggilan library http nya kayak gimana
import 'package:tutor_http/models/post.dart';

class PostService {
  //khususnya dalam flutter (mayoritas bahasa pemrograman yang berkaitan dengan request dari server) dirancang tiak bisa nungguin respon nya
  //sekedar request aja gak nungguin sampai dapat hasilnya
  //sifat kerjanya tidak ditemuin sekali jalan yah jalan sendiri (async)
  //tau tau beres pokoknya
  static Future<List<Post>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  //disini kita tinggal generalisasi library di http menggunakan baris import
  //secara request menggunakan method get
  //untuk kita bisa untuk mendapatkan sesuatu menggunakan fungsi get
  //uri -> rest architecture
  //mulai belajar dari rest terus ke http protocol
    if (response.statusCode == 200) {
    //ngecek apakah respon nya tersebut status code responnya sama dengan 200
      final List<dynamic> data = jsonDecode(response.body);
      //isi respon dari server
      return data.map((item) => Post.fromJson(item)).toList();
      //dari data yang sudah di confirm kita pakai function map
      //pakai post 
    } else {
      //kalau misalnya if nya nda lolos maka langsung throw saja sebuah exception
      throw Exception('Failed to load posts');
    }
  }
}