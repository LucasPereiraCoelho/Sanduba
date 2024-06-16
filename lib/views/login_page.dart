import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/views/create_user.dart';
import 'package:app_delivery/views/home_page.dart';
import 'package:flutter/material.dart';
import '../components/my_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(
            size: 70,
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
          ElevatedButton(
            onPressed: () async {
              var auth =
                  await login(emailController.text, passwordController.text);

              if (auth == true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuário ou senha incorrta.'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text('Entrar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUser(),
                  ));
            },
            child: Text('Criar usuário'),
          ),
        ],
      ),
    );
  }
}
