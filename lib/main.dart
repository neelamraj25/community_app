import 'package:community_view/bloc/community_bloc.dart';
import 'package:community_view/screen/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => CommunityBloc(),
        child: CommunityView(),)
    );
  }
}