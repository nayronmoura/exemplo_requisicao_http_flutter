import 'dart:convert';

import 'package:apiconsummer/chucknorris_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChucknorrisModel? chucknorrisModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
        actions: [
          ElevatedButton(
              onPressed: () {
                httpRequest();
              },
              child: Text("Refresh"))
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (chucknorrisModel != null) ...[
              Image.network(chucknorrisModel!.iconUrl),
              SizedBox(height: 20),
              Text(
                chucknorrisModel!.value,
                textAlign: TextAlign.center,
              ),
              Text(chucknorrisModel!.createdAt),
            ] else
              const Text("Não há resultados no momento, clique em Refresh")
          ],
        ),
      )),
    );
  }

  void httpRequest() async {
    Uri url = Uri.parse("https://api.chucknorris.io/jokes/random");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      chucknorrisModel = ChucknorrisModel.fromJson(decoded);
    } else {
      chucknorrisModel = null;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao carregar os dados")));
    }
    setState(() {});
  }

  void dioRequest() async {
    Dio dio = Dio();
    final response = await dio.get("https://api.chucknorris.io/jokes/random");
    if (response.statusCode == 200) {
      chucknorrisModel = ChucknorrisModel.fromJson(response.data);
    } else {
      chucknorrisModel = null;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao carregar os dados")));
    }
    setState(() {});
  }
}
