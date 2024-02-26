import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/domain.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AuthService {
  //func Google signin
  // signinGoogle() async {
  //   //Signin process
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken
  //       );

  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<Null> processSigninWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    await Firebase.initializeApp().then((googleUserData) async {
      await _googleSignIn.signIn().then((googleUserData) async {
        
        String? name = googleUserData!.displayName;
        String email = googleUserData.email;
        String? image = googleUserData.photoUrl;
        await googleUserData.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
              accessToken: value2.accessToken, idToken: value2.idToken);
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((googleUID) async {
            String UID = googleUID.user!.uid;
            print(
                "Login With Google Success : {name: $name, email: $email, imageUrl: $image}");

            String Url = "${Mydomain.testNode}/ApiRouters/googleAuth";
            final uri = Uri.parse(Url);
            final headersApi = {"Content-Type": "application/json"};

            Map<String, dynamic> reqBody = {
              "name": name,
              "email": email,
              "UID": UID,
              "image": image
            };

            final response = await http.post(uri,
                headers: headersApi, body: jsonEncode(reqBody));

            final responseData = json.decode(response.body);

            if (response.statusCode == 500) {
              print("req error");
            } else if (response.statusCode == 404) {
              print("Insert error");
            } else if (response.statusCode == 201) {
              print("insert success: $responseData");
            } else if (response.statusCode == 200) {
              await GetStorage().write('googleName', name);
              await GetStorage().write('googleEmail', email);
              await GetStorage().write('googleUID', UID);
              await GetStorage().write('googleImage', image);
              print("signin success : $responseData");
            }
          });
        });
      });
    });
  }
}
