import 'package:app_delivery/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

login(email, password) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    var auth = FirebaseAuth.instance;

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
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  } catch (e) {
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
  var auth = FirebaseAuth.instance;

  try {
    await db
        .collection('Feedbacks')
        .doc(auth.currentUser!.uid)
        .set({'feedback': feedback});
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

addToFavorites(Map<String, String> foodItem) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Favorites').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayUnion([foodItem]),
  }, SetOptions(merge: true));
}

removeFromFavorites(Map<String, String> foodItem) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Favorites').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayRemove([foodItem]),
  }, SetOptions(merge: true));
}

getFavorites() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var doc = await db.collection('Favorites').doc(auth.currentUser!.uid).get();
  if (doc.exists && doc.data() != null) {
    List<dynamic> items = doc.data()!['items'];
    return List<Map<String, String>>.from(
        items.map((item) => Map<String, String>.from(item)));
  }
  return [];
}

addCart(Map<String, String> foodItem) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Cart').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayUnion([foodItem]),
  }, SetOptions(merge: true));
}

removeCart(Map<String, String> foodItem) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Cart').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayRemove([foodItem]),
  }, SetOptions(merge: true));
}

getCartItems() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var doc = await db.collection('Cart').doc(auth.currentUser!.uid).get();
  if (doc.exists && doc.data() != null) {
    List<dynamic> items = doc.data()!['items'];
    return List<Map<String, String>>.from(
        items.map((item) => Map<String, String>.from(item)));
  }
  return [];
}

Future<List<Map<String, dynamic>>> getItems() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var db = FirebaseFirestore.instance;
  var querySnapshot = await db.collection('Items').get();

  return querySnapshot.docs
      .map((doc) => {
            'name': doc.data()['nome'],
            'description': doc.data()['descricao'],
            'imageUrl': doc.data()['imagem'],
            'price': doc.data()['preco']
          })
      .toList();
}

Future<void> finalizePurchase(List<Map<String, String>> cartItems) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;

  try {
    await db.collection('Purchases').add({
      'userId': auth.currentUser!.uid,
      'items': cartItems,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await db.collection('Cart').doc(auth.currentUser!.uid).delete();
  } catch (e) {
    print('Erro ao finalizar compra: $e');
  }
}