import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Pages/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;
  //VerifyEmail
  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print("Verification Email has been sent");

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black26,
          content: Text(
            'Verification Email has been sent !',
            style: TextStyle(fontSize: 18, color: Colors.amber),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/profile.jpg"),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                const Text(
                  "User ID",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  uid,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email : $email ",
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
    
                /////
                user!.emailVerified
                ?
                const Text('Verified',style: TextStyle(fontSize: 22.0,color: Colors.lightBlue),)
                :
                TextButton(
                    onPressed: (){
                      verifyEmail();
                    },
                    child: const Text(
                      'Verify Email',
                      style: TextStyle(fontSize: 22, color: Colors.lightBlue),
                    ))
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                const Text(
                  "Created",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  creationTime.toString(),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async{
                 await FirebaseAuth.instance.signOut();
                 // ignore: use_build_context_synchronously
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginPage()), (route) => false);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
