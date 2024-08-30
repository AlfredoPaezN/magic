import 'package:magic/src/domain/repository/MagicRepository.dart';

class GetCardsUseCase {
  MagicRepository magicRepository;

  GetCardsUseCase(this.magicRepository);
  run({int page = 1, int pageSize = 8}) {
    return magicRepository.getCards(page: page, pageSize: pageSize);
  }
}
