import 'package:flutter/material.dart';
import 'package:app_delivery/services/firebase_connect.dart';
import 'package:app_delivery/components/my_input.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController texto = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: MyInput(placeholder: 'Feedback', type: false, controller: texto),
          ),
          ElevatedButton(
            onPressed: () {
              sendFeedback(texto.text);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Feedback enviado!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
