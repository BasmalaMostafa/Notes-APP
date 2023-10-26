import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class Components{
  const Components();

  Widget defaultFormField({
    required TextInputType textInputType,
    required String text,
    required IconData prefixIcon,
    required TextEditingController controller,
    bool isPassword = false,
    IconData? suffixIcon,
    required String? Function(String?) validator,
    void Function()? suffixFunction,
  }) =>
      TextFormField(
        obscureText: isPassword ? true : false,
        controller: controller,
        keyboardType: textInputType,
        onFieldSubmitted: (value) {
          if (kDebugMode) {
            print("onSubmitted: $value");
          }
        },
        onChanged: (value) {
          if (kDebugMode) {
            print("onChanged: $value");
          }
        },
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
            labelText: text,
            prefixIcon: Icon(prefixIcon,color: Colors.orange),
            suffixIcon: suffixIcon != null
                ? IconButton(
              icon: Icon(suffixIcon,color: Colors.orange),
              onPressed: suffixFunction,
            )
                : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey[300]!)
          ),
            ),
      );

  Widget facebookButton() => SizedBox(
    width: double.infinity,
    height: 40.0,
    child: SignInButton(
      Buttons.Facebook,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () {},
      text: 'Sign-In with Facebook',
    ),
  );

  Widget googleButton({required Function() signInWithGoogle}) => Container(
    width: double.infinity,
    height: 40.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: SignInButton(
      Buttons.Google,
      onPressed: signInWithGoogle
      ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      text: 'Sign-In with Google',
    ),
  );

  Widget twitterButton() => Container(
    width: double.infinity,
    height: 40.0,
    child: SignInButton(
      Buttons.Twitter,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      text: 'Sign-In with Twitter',
    ),
  );

  showPopUp(msg,context,type,title,{deleteProcess=false,function}) {
    return AwesomeDialog(
        context: context,
        dialogType: type,
        animType: AnimType.rightSlide,
        title: title,
        desc: msg,
        btnCancelOnPress: () {},
    btnOkOnPress: deleteProcess? function : (){},
    ).show();
  }


}