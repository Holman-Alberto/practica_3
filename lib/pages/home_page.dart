import 'package:flutter/material.dart';
import 'package:practica_3/pages/sign_in_page.dart';
import 'package:practica_3/pages/sign_up_page.dart';
import 'package:practica_3/repository/firebase_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("HomePage"),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

