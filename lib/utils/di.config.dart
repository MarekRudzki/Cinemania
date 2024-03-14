// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/account/model/account_repository.dart' as _i6;
import '../features/account/model/datasources/local/account_hive.dart' as _i5;
import '../features/account/model/datasources/remote/account_auth.dart' as _i3;
import '../features/account/model/datasources/remote/account_firestore.dart'
    as _i4;
import '../features/account/viewmodel/bloc/account_bloc.dart' as _i16;
import '../features/auth/model/auth_repository.dart' as _i10;
import '../features/auth/model/datasources/local/auth_hive.dart' as _i9;
import '../features/auth/model/datasources/remote/auth_auth.dart' as _i7;
import '../features/auth/model/datasources/remote/auth_firestore.dart' as _i8;
import '../features/auth/viewmodel/bloc/auth_bloc.dart' as _i17;
import '../features/details/model/datasources/remote/details_tmdb.dart' as _i11;
import '../features/details/model/details_repository.dart' as _i18;
import '../features/details/viewmodel/bloc/details_bloc.dart' as _i23;
import '../features/genre/model/datasources/remote/genre_tmdb.dart' as _i12;
import '../features/genre/model/genre_repository.dart' as _i19;
import '../features/genre/viewmodel/bloc/genre_bloc.dart' as _i24;
import '../features/home/model/datasources/remote/home_tmdb.dart' as _i13;
import '../features/home/model/home_repository.dart' as _i20;
import '../features/home/viewmodel/bloc/home_bloc.dart' as _i25;
import '../features/search/model/datasources/remote/search_tmdb.dart' as _i14;
import '../features/search/model/search_repository.dart' as _i21;
import '../features/search/viewmodel/pagination/pagination_bloc.dart' as _i26;
import '../features/search/viewmodel/search/search_bloc.dart' as _i27;
import '../features/tv_seasons/model/datasources/remote_datasources/tv_seasons_tmdb.dart'
    as _i15;
import '../features/tv_seasons/model/tv_seasons_repository.dart' as _i22;
import '../features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart' as _i28;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AccountAuth>(() => _i3.AccountAuth());
    gh.lazySingleton<_i4.AccountFirestore>(() => _i4.AccountFirestore());
    gh.lazySingleton<_i5.AccountHive>(() => _i5.AccountHive());
    gh.lazySingleton<_i6.AccountRepository>(() => _i6.AccountRepository(
          accountFirestore: gh<_i4.AccountFirestore>(),
          accountAuth: gh<_i3.AccountAuth>(),
          accountHive: gh<_i5.AccountHive>(),
        ));
    gh.lazySingleton<_i7.AuthAuth>(() => _i7.AuthAuth());
    gh.lazySingleton<_i8.AuthFirestore>(() => _i8.AuthFirestore());
    gh.lazySingleton<_i9.AuthHive>(() => _i9.AuthHive());
    gh.lazySingleton<_i10.AuthRepository>(() => _i10.AuthRepository(
          authFirestore: gh<_i8.AuthFirestore>(),
          authAuth: gh<_i7.AuthAuth>(),
          authHive: gh<_i9.AuthHive>(),
        ));
    gh.lazySingleton<_i11.DetailsTMDB>(() => _i11.DetailsTMDB());
    gh.lazySingleton<_i12.GenreTMDB>(() => _i12.GenreTMDB());
    gh.lazySingleton<_i13.HomeTMDB>(() => _i13.HomeTMDB());
    gh.lazySingleton<_i14.SearchTMDB>(() => _i14.SearchTMDB());
    gh.lazySingleton<_i15.TVSeasonsTMDB>(() => _i15.TVSeasonsTMDB());
    gh.factory<_i16.AccountBloc>(
        () => _i16.AccountBloc(accountRepository: gh<_i6.AccountRepository>()));
    gh.factory<_i17.AuthBloc>(
        () => _i17.AuthBloc(authRepository: gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i18.DetailsRepository>(
        () => _i18.DetailsRepository(detailsTMDB: gh<_i11.DetailsTMDB>()));
    gh.lazySingleton<_i19.GenreRepository>(
        () => _i19.GenreRepository(genreTMDB: gh<_i12.GenreTMDB>()));
    gh.lazySingleton<_i20.HomeRepository>(
        () => _i20.HomeRepository(homeTMDB: gh<_i13.HomeTMDB>()));
    gh.lazySingleton<_i21.SearchRepository>(
        () => _i21.SearchRepository(searchTMDB: gh<_i14.SearchTMDB>()));
    gh.lazySingleton<_i22.TVSeasonsRepository>(
        () => _i22.TVSeasonsRepository(tmdb: gh<_i15.TVSeasonsTMDB>()));
    gh.factory<_i23.DetailsBloc>(
        () => _i23.DetailsBloc(gh<_i18.DetailsRepository>()));
    gh.factory<_i24.GenreBloc>(
        () => _i24.GenreBloc(gh<_i19.GenreRepository>()));
    gh.factory<_i25.HomeBloc>(() => _i25.HomeBloc(gh<_i20.HomeRepository>()));
    gh.factory<_i26.PaginationBloc>(
        () => _i26.PaginationBloc(gh<_i21.SearchRepository>()));
    gh.factory<_i27.SearchBloc>(
        () => _i27.SearchBloc(gh<_i21.SearchRepository>()));
    gh.factory<_i28.TVSeasonsBloc>(
        () => _i28.TVSeasonsBloc(gh<_i22.TVSeasonsRepository>()));
    return this;
  }
}
