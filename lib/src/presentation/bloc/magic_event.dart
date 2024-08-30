import 'package:magic/src/domain/models/magic_card.dart';

abstract class MagicEvent {}

class FormSubmit extends MagicEvent {}

class LoadMoreCards extends MagicEvent {
  final int page;
  final int pageSize;

  LoadMoreCards(this.page, this.pageSize);
}

class CardSelected extends MagicEvent {
  final MagicCard card;

  CardSelected(this.card);
}
