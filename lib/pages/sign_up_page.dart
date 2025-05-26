import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica_3/repository/firebase_api.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum Genre {male,female}

class _SignUpPageState extends State<SignUpPage> {

  Genre? _genre = Genre.male;

  bool _isPasswordObscure = true;
  bool _isRepPasswordObscure = true;

  String buttonMsg = "Fecha de nacimiento";

  DateTime _bornDate = DateTime.now();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  final FirebaseApi _firebaseApi = FirebaseApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nombre",
                    prefixIcon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Correo electrónico",
                    prefixIcon: Icon(Icons.mail),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if (value!.isEmpty) {
                      return "Dabe digitar un correo electrónico";
                    } else {
                      if (!value!.isValidEmail()) {
                        return "El correo no es válido";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _password,
                  obscureText: _isPasswordObscure,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(

                        icon: Icon(_isPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),

                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                      labelText: "Contraeña"),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _repPassword,
                  obscureText: _isRepPasswordObscure,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(

                        icon: Icon(_isRepPasswordObscure
                            ? Icons.visibility
                            : Icons.visibility_off),

                        onPressed: () {
                          setState(() {
                            _isRepPasswordObscure = !_isRepPasswordObscure;
                          });
                        },
                      ),
                      labelText: "Repita la constraseña"),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Text("Elija su rol"),
                    Expanded(
                        child: RadioListTile(
                          title: const Text("Entrenador"),
                          value: Genre.male,
                          groupValue: _genre,
                          onChanged: (Genre? value){
                            setState(() {
                              _genre = value;
                            });
                          },
                        )
                    ),
                    Expanded(
                        child: RadioListTile(
                          title: const Text("Deportista"),
                          value: Genre.female,
                          groupValue: _genre,
                          onChanged: (Genre? value){
                            setState(() {
                              _genre = value;
                            });
                          },
                        )
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: (){
                      _showSelectedDate();

                    },
                    child: Text(buttonMsg)
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: (){
                      _onRegisterButtonClicked();
                    },

                    child: Text("Registrarse")
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonClicked(){
    if (_email.text.isEmpty || _password.text.isEmpty || _repPassword.text.isEmpty){
      showMsg("Debe digitar todos los campos");
    }else if(_password.text != _repPassword.text) {
      showMsg("Las contraseñas deben de ser iguales");
    }else if (_password.text.length <6){
      showMsg("La contraseña debe tener mínimo 6 caracteres");
    }else{
      createUser(_email.text,_password.text);
    }
  }

  void createUser(String email,String password) async{
    var result = await _firebaseApi.createUser(email, password);
    if (result == 'weak password'){
      showMsg("La contraseña debe tener minimo 6 caracteres");
    }else if(result == 'email-already-in-use'){
      showMsg("Ya exite una cuenta con ese correo electrónico");
    }else if(result == 'invalid email'){
      showMsg("El correo electrónico está mal escrito");
    }else if(result == 'network-request-failed'){
      showMsg("Revise su conexión a internet");
    }else{
      showMsg("Usuario registrado correctamente");
      Navigator.pop(context);
    }
  }

  void showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
        SnackBar(content: Text(msg),
          duration: Duration(seconds: 10),
          action: SnackBarAction(label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),)
    );
  }

  void _showSelectedDate() async{
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1925,1),
      lastDate: DateTime.now(),
      helpText: "Fecha de nacimiento",
    );
    if (newDate != null){
      setState(() {
        _bornDate = newDate;

        buttonMsg = "Fecha de nacimiento: ${_dateConverter(newDate)}";
      });
    }
  }

  String _dateConverter(DateTime date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(date);
    return dateFormatted;
  }

}

extension on String {
  bool isValidEmail(){
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }
}
