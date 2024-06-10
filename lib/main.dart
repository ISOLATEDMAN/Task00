import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task00/auths/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task00/bloc/bloc/product_bloc_bloc.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create:(context)=>ProductBlocBloc()),
    ],
     child:MaterialApp(

      home: Login(),
    ));
  }
}