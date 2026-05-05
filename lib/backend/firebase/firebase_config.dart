import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDvh3_BaQu_WQZCVwWxs8V5U-2WaTr7XXw",
            authDomain: "aziz1-we6pwd.firebaseapp.com",
            projectId: "aziz1-we6pwd",
            storageBucket: "aziz1-we6pwd.firebasestorage.app",
            messagingSenderId: "479083541506",
            appId: "1:479083541506:web:dd056497e275d3d699a31b",
            measurementId: "G-GLMKL00K6Z"));
  } else {
    await Firebase.initializeApp();
  }
}
