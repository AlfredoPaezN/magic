import 'package:magic/src/data/dataSource/remote/services/MagicService.dart';
import 'package:magic/src/data/repository/MagicRepositoryImpl.dart';
import 'package:magic/src/domain/repository/MagicRepository.dart';
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @injectable
  MagicService get exampleService => MagicService();

  @injectable
  MagicRepository get magicRepository => MagicRepositoryImpl(exampleService);

  @injectable
  GetCardsUseCase get authUseCases => GetCardsUseCase(magicRepository);
}
