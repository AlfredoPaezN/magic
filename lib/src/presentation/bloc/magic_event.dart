import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/presentation/utils/bloc_form_item.dart';

abstract class MagicEvent {}

class FormSubmit extends MagicEvent {}

class CardSelected extends MagicEvent {
  final MagicCard card;

  CardSelected(this.card);
}
