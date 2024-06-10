import 'package:flutter/material.dart';
import 'package:task00/auths/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task00/screens/BNB.dart';
import 'package:task00/screens/home.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN",style: TextStyle(fontSize: 40),),
            SizedBox(height: 30,),
            SizedBox(
              width: 340,
              child: TextFormField(
                controller: _email,
                decoration:InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Enter ur email..."
              ),),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 340,
              child: TextFormField(
                controller: _pass,
                decoration:InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Enter ur pass..."
              ),),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(width: 120,),
                Text("dont have an account.."),
                InkWell(
                  child: Text("CREATE"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Create()));
                  },
                )
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              login(_email.text, _pass.text);
            }, child: Text("submit"))
          ],
        ),
      ),
    );
  }
  void login(String email,String pass)async{
    try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: pass,
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bnb()));
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }

}