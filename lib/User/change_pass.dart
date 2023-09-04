import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Pages/login.dart';
import 'package:flutter/material.dart';

class Changepass extends StatefulWidget {
  const Changepass({super.key});

  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  final _formKey = GlobalKey<FormState>();
  var newPassword = "";
  final newPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  
 ///Change Password
  changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black26,
          content: Text(
            'Your password has been Changed.. Login again !',
            style: TextStyle(fontSize: 18, color: Colors.amber),
          )));
    }catch (error){
     return null;
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("assets/images/change-pass.jpg"),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.black26, fontSize: 15)),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password !';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePassword();
                      }
                    },
                    child: const Text(
                      "Change Password",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          )),
    );
  }
}
