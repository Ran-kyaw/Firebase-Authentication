import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Pages/forgot_pass.dart';
import 'package:firebase_authentication/Pages/signup.dart';
import 'package:firebase_authentication/Pages/user_main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Start
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //For User Login
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const UserMain()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email !');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Not user found for that email !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided by the user');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Wrong password provided by the user !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/login.jpg"),
                ),
                //Email container
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.black26, fontSize: 15)),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email !';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid Email !';
                      }
                      return null;
                    },
                  ),
                ),

                //Password container
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.black26, fontSize: 15)),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password !';
                      }
                      return null;
                    },
                  ),
                ),

                //For Login Button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            //User Login
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                                password = passwordController.text;
                              });
                              userLogin();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotPass()));
                          },
                          child: const Text(
                            'Forget Password ?',
                            style: TextStyle(fontSize: 12.0),
                          ))
                    ],
                  ),
                ),

                //Not have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do not have an account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      const Signup(),transitionDuration: const Duration(seconds: 0)),
                              (route) => false);
                        },
                        child: const Text('Signup'))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
