import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/utils/Resources.dart';

abstract class MagicRepository {
  Future<Resource<List<MagicCard>>> getCards();
}
