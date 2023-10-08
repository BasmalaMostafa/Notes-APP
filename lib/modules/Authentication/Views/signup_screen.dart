import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Shared/Components/components.dart';
import '../manager/authentication_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final Components components = const Components();

  final TextEditingController userNameController = TextEditingController();

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
                      const Text('SignUp',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                    const Text("SignUp to Continue using the APP",
                      style: TextStyle(color: Colors.grey,fontSize: 17,
                          ),),
                      const SizedBox(height: 20,),
                      components.defaultFormField(
                        textInputType: TextInputType.text,
                        text: 'UserName',
                        prefixIcon: Icons.person,
                        controller: userNameController,
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'This Field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 26,),
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
                      const SizedBox(height: 40,),
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          onPressed: () async{
                            if(formKey.currentState!.validate()){

                            }
                          },
                          fillColor: Colors.orange,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text('Register'.toUpperCase(),
                            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?",
                            style: TextStyle(fontSize: 17,color: Colors.grey),),
                          TextButton(onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                              child: const Text("Login",
                                style: TextStyle(color: Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),)),
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
