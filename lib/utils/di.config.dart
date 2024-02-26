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
import '../features/account/viewmodel/bloc/account_bloc.dart' as _i11;
import '../features/auth/model/auth_repository.dart' as _i10;
import '../features/auth/model/datasources/local/auth_hive.dart' as _i9;
import '../features/auth/model/datasources/remote/auth_auth.dart' as _i7;
import '../features/auth/model/datasources/remote/auth_firestore.dart' as _i8;
import '../features/auth/viewmodel/bloc/auth_bloc.dart' as _i12;

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
    gh.factory<_i11.AccountBloc>(
        () => _i11.AccountBloc(accountRepository: gh<_i6.AccountRepository>()));
    gh.factory<_i12.AuthBloc>(
        () => _i12.AuthBloc(authRepository: gh<_i10.AuthRepository>()));
    return this;
  }
}
