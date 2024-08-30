import 'package:equatable/equatable.dart';
import 'package:magic/src/domain/models/magic_card.dart';

class MagicState extends Equatable {
  final MagicCard? selectedCard;
  final List<MagicCard>? cards;

  const MagicState({
    this.selectedCard,
    this.cards = const [],
  });

  MagicState copyWith({
    MagicCard? selectedCard,
    List<MagicCard>? cards,
  }) {
    return MagicState(
      selectedCard: selectedCard,
      cards: cards ?? this.cards,
    );
  }

  @override
  List<Object?> get props => [
        selectedCard,
        cards,
      ];
}
