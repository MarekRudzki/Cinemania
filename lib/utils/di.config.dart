// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Package imports:
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

// Project imports:
import '../features/account/model/account_repository.dart' as _i113;
import '../features/account/model/datasources/local/account_hive.dart' as _i12;
import '../features/account/viewmodel/bloc/account_bloc.dart' as _i91;
import '../features/auth/model/auth_repository.dart' as _i70;
import '../features/auth/model/datasources/local/auth_hive.dart' as _i425;
import '../features/auth/model/datasources/remote/auth_auth.dart' as _i586;
import '../features/auth/model/datasources/remote/auth_firestore.dart' as _i723;
import '../features/auth/viewmodel/bloc/auth_bloc.dart' as _i627;
import '../features/details/model/details_repository.dart' as _i84;
import '../features/details/viewmodel/bloc/details_bloc.dart' as _i65;
import '../features/genre/model/datasources/remote/genre_tmdb.dart' as _i1072;
import '../features/genre/model/genre_repository.dart' as _i256;
import '../features/genre/viewmodel/bloc/genre_bloc.dart' as _i1073;
import '../features/home/model/datasources/remote/home_auth.dart' as _i556;
import '../features/home/model/datasources/remote/home_firestore.dart' as _i124;
import '../features/home/model/datasources/remote/home_tmdb.dart' as _i604;
import '../features/home/model/home_repository.dart' as _i207;
import '../features/home/viewmodel/bloc/home_bloc.dart' as _i55;
import '../features/search/model/datasources/remote/search_tmdb.dart' as _i553;
import '../features/search/model/search_repository.dart' as _i365;
import '../features/search/viewmodel/pagination/pagination_bloc.dart' as _i567;
import '../features/search/viewmodel/search/search_bloc.dart' as _i233;
import '../features/tv_seasons/model/tv_seasons_repository.dart' as _i1072;
import '../features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart' as _i95;

import '../features/account/model/datasources/remote/account_auth.dart'
    as _i649;
import '../features/account/model/datasources/remote/account_firestore.dart'
    as _i375;
import '../features/details/model/datasources/remote/details_tmdb.dart'
    as _i572;
import '../features/search/model/datasources/remote/search_firestore.dart'
    as _i569;
import '../features/tv_seasons/model/datasources/remote_datasources/tv_seasons_tmdb.dart'
    as _i539;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i12.AccountHive>(() => _i12.AccountHive());
    gh.lazySingleton<_i649.AccountAuth>(() => _i649.AccountAuth());
    gh.lazySingleton<_i375.AccountFirestore>(() => _i375.AccountFirestore());
    gh.lazySingleton<_i425.AuthHive>(() => _i425.AuthHive());
    gh.lazySingleton<_i586.AuthAuth>(() => _i586.AuthAuth());
    gh.lazySingleton<_i723.AuthFirestore>(() => _i723.AuthFirestore());
    gh.lazySingleton<_i572.DetailsTMDB>(() => _i572.DetailsTMDB());
    gh.lazySingleton<_i1072.GenreTMDB>(() => _i1072.GenreTMDB());
    gh.lazySingleton<_i556.HomeAuth>(() => _i556.HomeAuth());
    gh.lazySingleton<_i124.HomeFirestore>(() => _i124.HomeFirestore());
    gh.lazySingleton<_i604.HomeTMDB>(() => _i604.HomeTMDB());
    gh.lazySingleton<_i553.SearchTMDB>(() => _i553.SearchTMDB());
    gh.lazySingleton<_i539.TVSeasonsTMDB>(() => _i539.TVSeasonsTMDB());
    gh.lazySingleton<_i569.SearchFirestore>(() => _i569.SearchFirestore());
    gh.lazySingleton<_i113.AccountRepository>(() => _i113.AccountRepository(
          accountFirestore: gh<_i375.AccountFirestore>(),
          accountAuth: gh<_i649.AccountAuth>(),
          accountHive: gh<_i12.AccountHive>(),
        ));
    gh.lazySingleton<_i1072.TVSeasonsRepository>(
        () => _i1072.TVSeasonsRepository(tmdb: gh<_i539.TVSeasonsTMDB>()));
    gh.factory<_i91.AccountBloc>(() =>
        _i91.AccountBloc(accountRepository: gh<_i113.AccountRepository>()));
    gh.lazySingleton<_i256.GenreRepository>(
        () => _i256.GenreRepository(genreTMDB: gh<_i1072.GenreTMDB>()));
    gh.lazySingleton<_i207.HomeRepository>(() => _i207.HomeRepository(
          homeTMDB: gh<_i604.HomeTMDB>(),
          homeFirestore: gh<_i124.HomeFirestore>(),
          homeAuth: gh<_i556.HomeAuth>(),
        ));
    gh.lazySingleton<_i70.AuthRepository>(() => _i70.AuthRepository(
          authFirestore: gh<_i723.AuthFirestore>(),
          authAuth: gh<_i586.AuthAuth>(),
          authHive: gh<_i425.AuthHive>(),
        ));
    gh.lazySingleton<_i365.SearchRepository>(() => _i365.SearchRepository(
          searchTMDB: gh<_i553.SearchTMDB>(),
          accountAuth: gh<_i649.AccountAuth>(),
          searchFirestore: gh<_i569.SearchFirestore>(),
        ));
    gh.factory<_i627.AuthBloc>(
        () => _i627.AuthBloc(authRepository: gh<_i70.AuthRepository>()));
    gh.factory<_i1073.GenreBloc>(
        () => _i1073.GenreBloc(gh<_i256.GenreRepository>()));
    gh.lazySingleton<_i84.DetailsRepository>(
        () => _i84.DetailsRepository(detailsTMDB: gh<_i572.DetailsTMDB>()));
    gh.factory<_i95.TVSeasonsBloc>(
        () => _i95.TVSeasonsBloc(gh<_i1072.TVSeasonsRepository>()));
    gh.factory<_i567.PaginationBloc>(
        () => _i567.PaginationBloc(gh<_i365.SearchRepository>()));
    gh.factory<_i233.SearchBloc>(
        () => _i233.SearchBloc(gh<_i365.SearchRepository>()));
    gh.factory<_i55.HomeBloc>(() => _i55.HomeBloc(gh<_i207.HomeRepository>()));
    gh.factory<_i65.DetailsBloc>(
        () => _i65.DetailsBloc(gh<_i84.DetailsRepository>()));
    return this;
  }
}
