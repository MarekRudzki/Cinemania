import 'package:cinemania/features/account/model/account_repository.dart';
import 'package:cinemania/features/account/model/datasources/local/account_hive.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_auth.dart';
import 'package:cinemania/features/account/model/datasources/remote/account_firestore.dart';
import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/model/auth_repository.dart';
import 'package:cinemania/features/auth/model/datasources/local/auth_hive.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_auth.dart';
import 'package:cinemania/features/auth/model/datasources/remote/auth_firestore.dart';
import 'package:cinemania/features/auth/view/auth_screen.dart';
import 'package:cinemania/config/firebase_options.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:cinemania/features/home/view/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await dotenv.load();

  await Hive.initFlutter();
  await Hive.openBox('user_box');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
                authFirestore: AuthFirestore(),
                authAuth: AuthAuth(),
                authHive: AuthHive()),
          ),
        ),
        BlocProvider(
          create: (context) => AccountBloc(
            accountRepository: AccountRepository(
              accountFirestore: AccountFirestore(),
              accountHive: AccountHive(),
              accountAuth: AccountAuth(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthBloc(
          authRepository: AuthRepository(
              authFirestore: AuthFirestore(),
              authAuth: AuthAuth(),
              authHive: AuthHive()),
        ).isUserLogged()
            ? const HomeScreen()
            : const AuthScreen(),
      ),
    ),
  );
}
