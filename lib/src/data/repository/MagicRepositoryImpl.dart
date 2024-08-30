import 'package:magic/src/data/dataSource/remote/services/MagicService.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/repository/MagicRepository.dart';
import 'package:magic/src/domain/utils/Resources.dart';

class MagicRepositoryImpl implements MagicRepository {
  MagicService magicService;
  MagicRepositoryImpl(this.magicService);

  @override
  Future<Resource<List<MagicCard>>> getCards({int page = 1, int pageSize = 8}) {
    return magicService.getCards(page: page, pageSize: pageSize);
  }
}
