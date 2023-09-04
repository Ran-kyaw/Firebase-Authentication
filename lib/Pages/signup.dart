import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Pages/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  //Registration
  registration() async{
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Registered Successfully. Please Sign In !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }on FirebaseAuthException catch(error){
           if (error.code == 'weak-password') {
        print('Password is too weak');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Password is too weak !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      } else if (error.code == 'email-already-in-use') {
        print('Account is already exists');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Account is already exists !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      }
      }
    }else{
      print('Password and Confirm password does not match');
      // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              'Password and Confirm password does not match !',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            )));
      }
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
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset('assets/images/signup.jpg'),
                ),
                //For Email
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
                        return 'Please enter email !';
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
                //confirmPassword container
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.black26, fontSize: 15)),
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Confirm Password !';
                      }
                      return null;
                    },
                  ),
                ),
                
                const SizedBox(height: 15,),
                //For button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        //For Signup
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email= emailController.text;
                            password=passwordController.text;
                            confirmPassword=confirmPasswordController.text;
                          });
                          registration();
                        }
                      }, 
                      child: const Text('Signup',style: TextStyle(fontSize: 18),)
                      )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Already have an account ?'),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>const LoginPage(),transitionDuration: const Duration(seconds: 0)));
                    }, child: const Text('Login'))
                  ],
                )

              ],
            ),
          )),
    );
  }
}
