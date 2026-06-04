import 'package:flutter/material.dart';
import 'package:flutter_application_1/Reposit/newsRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/Api/newsApiService.dart';
import 'package:flutter_application_1/Bloc/newBloc.dart';
import 'package:flutter_application_1/Bloc/newEvent.dart';
import 'package:flutter_application_1/Ekran/newslistpage.dart';

void main() {
  final dio = Dio();
  final api = NewsApiServiceImpl(dio: dio);
  final repository = NewsRepository(api);
  
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final NewsRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => NewsBloc(repository)..add(LoadNews()),
        child: const NewsListPage(),
      ),
    );
  }
}