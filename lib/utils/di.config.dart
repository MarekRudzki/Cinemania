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
import '../features/account/viewmodel/bloc/account_bloc.dart' as _i13;
import '../features/auth/model/auth_repository.dart' as _i10;
import '../features/auth/model/datasources/local/auth_hive.dart' as _i9;
import '../features/auth/model/datasources/remote/auth_auth.dart' as _i7;
import '../features/auth/model/datasources/remote/auth_firestore.dart' as _i8;
import '../features/auth/viewmodel/bloc/auth_bloc.dart' as _i14;
import '../features/details/model/datasources/remote/details_tmdb.dart' as _i11;
import '../features/details/model/details_repository.dart' as _i15;
import '../features/details/viewmodel/bloc/details_bloc.dart' as _i17;
import '../features/search/model/datasources/remote/search_tmdb.dart' as _i12;
import '../features/search/model/search_repository.dart' as _i16;
import '../features/search/viewmodel/pagination/pagination_bloc.dart' as _i18;
import '../features/search/viewmodel/search/search_bloc.dart' as _i19;

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
    gh.lazySingleton<_i12.SearchTMDB>(() => _i12.SearchTMDB());
    gh.factory<_i13.AccountBloc>(
        () => _i13.AccountBloc(accountRepository: gh<_i6.AccountRepository>()));
    gh.factory<_i14.AuthBloc>(
        () => _i14.AuthBloc(authRepository: gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i15.DetailsRepository>(
        () => _i15.DetailsRepository(detailsTMDB: gh<_i11.DetailsTMDB>()));
    gh.lazySingleton<_i16.SearchRepository>(
        () => _i16.SearchRepository(searchTMDB: gh<_i12.SearchTMDB>()));
    gh.factory<_i17.DetailsBloc>(
        () => _i17.DetailsBloc(gh<_i15.DetailsRepository>()));
    gh.factory<_i18.PaginationBloc>(
        () => _i18.PaginationBloc(gh<_i16.SearchRepository>()));
    gh.factory<_i19.SearchBloc>(
        () => _i19.SearchBloc(gh<_i16.SearchRepository>()));
    return this;
  }
}
