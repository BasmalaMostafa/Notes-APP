
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/Shared/Components/components.dart';

import '../manager/authentication_cubit.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static Future<User?> loginUsingEmailAndPassword ({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    User? user;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      user =credential.user;
      Navigator.of(context).pushReplacementNamed('/homepage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password');
        }
      }
    }
    return user;
  }


  final Components components = const Components();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
  builder: (context, state) {
    var authCubit = AuthenticationCubit.get(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                     Center(
                       child: Container(
                           height:130,
                           width: 130,
                           decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(100)
                           ),
                           child: const Image(image: AssetImage('assets/images/image_1.png',),)),
                     ),
                    const Text('Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        const Text("Don't have an account?",
                          style: TextStyle(fontSize: 17,color: Colors.grey),),
                        TextButton(onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                            child: const Text("Register",
                              style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),)),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    components.defaultFormField(
                        textInputType: TextInputType.emailAddress,
                        text: 'Email Address',
                        prefixIcon: Icons.email,
                        controller: emailController,
                        validator:  (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This Field is required';
                                        } else if (value.isNotEmpty &&
                                            !value.contains('@')) {
                                          return 'Invalid Email';
                                        }
                                        return null;
                                      },
                       ),
                    const SizedBox(height: 26,),
                    components.defaultFormField(
                                      controller: passwordController,
                                      text: 'Password',
                                      prefixIcon: Icons.lock,
                                      textInputType: TextInputType.visiblePassword,
                                      isPassword: authCubit.isPassword,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This Field is required';
                                        } else if (value.length < 8) {
                                          return "Password musn't have less than 8 characters";
                                        }
                                        return null;
                                      },
                                      suffixIcon:
                                          authCubit.isPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                      suffixFunction: () {
                                       authCubit.passwordVisibility();
                                      },
                                    ),
                    const SizedBox(height: 5,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {  },
                      child: const Text("Forget Password?",
                        style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),)),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: RawMaterialButton(
                        onPressed: () async{
                          if(formKey.currentState!.validate()){
                            User? user = await LoginScreen.loginUsingEmailAndPassword(
                                email: emailController!.text , password: passwordController!.text, context: context);
                            if (kDebugMode) {
                              print(user);
                            }
                          }
                        },
                        fillColor: Colors.orange,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text('Login'.toUpperCase(),
                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ),
                        Column(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      )),
                                  const Text('  OR  ',style: TextStyle(fontSize: 20),),
                                  Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            components.googleButton(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            components.facebookButton(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            components.twitterButton(),
                          ],
                        ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  },
);
  }
}