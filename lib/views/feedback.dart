import 'package:flutter/material.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/components/my_input.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController texto = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyInput(
                  placeholder: 'Feedback',
                  type: false,
                  controller: texto,
                ),
                SizedBox(height: 16), // Espaço entre o input e o botão
                ElevatedButton(
                  onPressed: () {
                    sendFeedback(texto.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Feedback enviado!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
