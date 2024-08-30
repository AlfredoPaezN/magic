import 'package:magic/src/data/repository/MagicRepositoryImpl.dart';
import 'package:magic/src/domain/repository/MagicRepository.dart';

class GetCardsUseCase {
  MagicRepository authRepository;

  GetCardsUseCase(this.authRepository);
  run() {
    return authRepository.getCards();
  }
}
