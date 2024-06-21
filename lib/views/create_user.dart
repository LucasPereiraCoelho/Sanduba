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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                MyInput(
                  controller: nameController,
                  placeholder: "Nome",
                  type: false,
                ),
                SizedBox(height: 20),
                MyInput(
                  controller: contactController,
                  placeholder: "Contato",
                  type: false,
                ),
                SizedBox(height: 20),
                MyInput(
                  controller: emailController,
                  placeholder: "Email",
                  type: false,
                ),
                SizedBox(height: 20),
                MyInput(
                  controller: passwordController,
                  placeholder: "Senha",
                  type: true,
                ),
                SizedBox(height: 20),
                MyInput(
                  controller: passwordController2,
                  placeholder: "Confirmar Senha",
                  type: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (passwordController.text == passwordController2.text) {
                      await register(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        contactController.text,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("As senhas não coincidem."),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  child: Text('Cadastrar'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Já tem uma conta? Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
