import 'package:cinemania/features/account/viewmodel/bloc/account_bloc.dart';
import 'package:cinemania/features/auth/view/auth_screen.dart';
import 'package:cinemania/config/firebase_options.dart';
import 'package:cinemania/features/auth/viewmodel/bloc/auth_bloc.dart';
import 'package:cinemania/features/details/viewmodel/bloc/details_bloc.dart';
import 'package:cinemania/features/home/viewmodel/bloc/home_bloc.dart';
import 'package:cinemania/features/main/view/main_screen.dart';
import 'package:cinemania/features/search/viewmodel/pagination/pagination_bloc.dart';
import 'package:cinemania/features/search/viewmodel/search/search_bloc.dart';
import 'package:cinemania/utils/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await dotenv.load();

  configureDependencies();

  await Hive.initFlutter();
  await Hive.openBox('user_box');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<AccountBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        BlocProvider(create: (context) => getIt<PaginationBloc>()),
        BlocProvider(create: (context) => getIt<DetailsBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: getIt<AuthBloc>().isUserLogged()
            ? const MainScreen()
            : const AuthScreen(),
      ),
    ),
  );
}
