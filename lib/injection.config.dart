// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:magic/src/data/dataSource/remote/services/MagicService.dart'
    as _i3;
import 'package:magic/src/di/AppModule.dart' as _i6;
import 'package:magic/src/domain/repository/MagicRepository.dart' as _i4;
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart' as _i5;

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
    final appModule = _$AppModule();
    gh.factory<_i3.MagicService>(() => appModule.exampleService);
    gh.factory<_i4.MagicRepository>(() => appModule.magicRepository);
    gh.factory<_i5.GetCardsUseCase>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i6.AppModule {}
