import 'package:app_delivery/components/my_input.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/views/home_page.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController contactController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
      ElevatedButton(
        onPressed: () async {
          await update(nameController.text, contactController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text('Atualizar'),
      )
    ]));
  }
}
