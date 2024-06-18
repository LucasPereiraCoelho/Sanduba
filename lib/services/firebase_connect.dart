import 'package:app_delivery/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

login(email, password) async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    var auth = FirebaseAuth.instance;
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    print("ok");
    return true;
  } catch (e) {
    print("erro");
    return false;
  }
}

register(email, password, name, contact) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    var auth = FirebaseAuth.instance;

  try {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }  on FirebaseAuthException catch (e) {
    var tipo = e;
    print(tipo.code);
    return e;
  }

  var db = FirebaseFirestore.instance;
  await db
      .collection('Users')
      .doc(auth.currentUser!.uid)
      .set({'name': name, 'email': email, 'contact': contact});
}

sendFeedback(feedback) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var db = FirebaseFirestore.instance;

  try{
    await db.collection('Feedbacks').doc('feedback').set({'feedback': feedback});
    print('ok');
  } catch (e) {
    print('erro');
  }
}


update(String name, String phone) async {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var auth = FirebaseAuth.instance;

  var db = FirebaseFirestore.instance;

  await db.collection('Users').doc(auth.currentUser!.uid).set({

    'name': name,

    'email': auth.currentUser!.email,

    'telefone': phone,

  });

}