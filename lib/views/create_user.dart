import 'package:app_delivery/components/my_input.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/views/login_page.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordController2 = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FlutterLogo(
        size: 70,
      ),
      MyInput(
        controller: nameController,
        placeholder: "Nome",
        type: false,
      ),
      MyInput(
        controller: contactController,
        placeholder: "Contato",
        type: false,
      ),
      MyInput(
        controller: emailController,
        placeholder: "Email",
        type: false,
      ),
      MyInput(
        controller: passwordController,
        placeholder: "Senha",
        type: true,
      ),
      MyInput(
        controller: passwordController2,
        placeholder: "Confirmar Senha",
        type: true,
      ),
      ElevatedButton(
        onPressed: () async {
          await register(emailController.text, passwordController.text,
              nameController.text, contactController.text);
          if (passwordController.text == passwordController2.text) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("ERRO"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: Text('Cadastrar'),
      ),
    ]));
  }
}
