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
import '../features/account/viewmodel/bloc/account_bloc.dart' as _i15;
import '../features/auth/model/auth_repository.dart' as _i10;
import '../features/auth/model/datasources/local/auth_hive.dart' as _i9;
import '../features/auth/model/datasources/remote/auth_auth.dart' as _i7;
import '../features/auth/model/datasources/remote/auth_firestore.dart' as _i8;
import '../features/auth/viewmodel/bloc/auth_bloc.dart' as _i16;
import '../features/category/model/category_repository.dart' as _i17;
import '../features/category/model/datasources/remote/category_tmdb.dart'
    as _i11;
import '../features/category/viewmodel/bloc/category_bloc.dart' as _i21;
import '../features/details/model/datasources/remote/details_tmdb.dart' as _i12;
import '../features/details/model/details_repository.dart' as _i18;
import '../features/details/viewmodel/bloc/details_bloc.dart' as _i22;
import '../features/home/model/datasources/remote/home_tmdb.dart' as _i13;
import '../features/home/model/home_repository.dart' as _i19;
import '../features/home/viewmodel/bloc/home_bloc.dart' as _i23;
import '../features/search/model/datasources/remote/search_tmdb.dart' as _i14;
import '../features/search/model/search_repository.dart' as _i20;
import '../features/search/viewmodel/pagination/pagination_bloc.dart' as _i24;
import '../features/search/viewmodel/search/search_bloc.dart' as _i25;

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
    gh.lazySingleton<_i11.CategoryTMDB>(() => _i11.CategoryTMDB());
    gh.lazySingleton<_i12.DetailsTMDB>(() => _i12.DetailsTMDB());
    gh.lazySingleton<_i13.HomeTMDB>(() => _i13.HomeTMDB());
    gh.lazySingleton<_i14.SearchTMDB>(() => _i14.SearchTMDB());
    gh.factory<_i15.AccountBloc>(
        () => _i15.AccountBloc(accountRepository: gh<_i6.AccountRepository>()));
    gh.factory<_i16.AuthBloc>(
        () => _i16.AuthBloc(authRepository: gh<_i10.AuthRepository>()));
    gh.lazySingleton<_i17.CategoryRepository>(
        () => _i17.CategoryRepository(categoryTMDB: gh<_i11.CategoryTMDB>()));
    gh.lazySingleton<_i18.DetailsRepository>(
        () => _i18.DetailsRepository(detailsTMDB: gh<_i12.DetailsTMDB>()));
    gh.lazySingleton<_i19.HomeRepository>(
        () => _i19.HomeRepository(homeTMDB: gh<_i13.HomeTMDB>()));
    gh.lazySingleton<_i20.SearchRepository>(
        () => _i20.SearchRepository(searchTMDB: gh<_i14.SearchTMDB>()));
    gh.factory<_i21.CategoryBloc>(
        () => _i21.CategoryBloc(gh<_i17.CategoryRepository>()));
    gh.factory<_i22.DetailsBloc>(
        () => _i22.DetailsBloc(gh<_i18.DetailsRepository>()));
    gh.factory<_i23.HomeBloc>(() => _i23.HomeBloc(gh<_i19.HomeRepository>()));
    gh.factory<_i24.PaginationBloc>(
        () => _i24.PaginationBloc(gh<_i20.SearchRepository>()));
    gh.factory<_i25.SearchBloc>(
        () => _i25.SearchBloc(gh<_i20.SearchRepository>()));
    return this;
  }
}
