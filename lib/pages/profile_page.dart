import 'package:flutter/material.dart';
import 'package:practica_3/pages/sign_in_page.dart';
import 'package:practica_3/repository/firebase_api.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final FirebaseApi _firebaseApi= FirebaseApi();

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
                const Text("Sección de perfil"),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF0F8555),
                    fixedSize: const Size(400, 60),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (){
                    _firebaseApi.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInPage()));
                  },
                  child: const Text("Cerrar sesión"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
