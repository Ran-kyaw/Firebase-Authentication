import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Pages/login.dart';
import 'package:firebase_authentication/Pages/signup.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  final emailController = TextEditingController();
  
  //For ResetButton
  resetPassword() async{
   try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.amber,
      content: Text('Password Reset Email has been sent !',style: TextStyle(
        fontSize: 18
      ),)
      ));

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
   }on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        print('No user found for that email');
         // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No user found for that email !',style: TextStyle(
        fontSize: 18,color: Colors.amber
      ),)
      ));
      }
   }
  }

  //dispose
  @override
  void dispose() {
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("assets/images/forgot.jpg",height: 250,),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const Text('Reset link will be send to your email ID !',
                style: TextStyle(fontSize: 20.0)),
          ),
          Expanded(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding:
                const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            autofocus: false,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                    color: Colors.black26, fontSize: 15)),
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
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                //Send Email
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    email = emailController.text;
                                  });
                                  resetPassword();
                                }
                              },
                               child: const Text('Send email',style: TextStyle(fontSize: 18),)
                               ),TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                                },
                                 child: const Text('Login',style: TextStyle(fontSize: 13),)
                                 )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Do not have an account ?'),
                          TextButton(
                            onPressed: (){
                              Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>const Signup()), (route) => false);
                            },
                             child: const Text('Signup')
                             )
                        ],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
