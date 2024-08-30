import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart';
import 'package:magic/src/domain/utils/Resources.dart';
import 'package:magic/src/presentation/bloc/magic_event.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';

class MagicBloc extends Bloc<MagicEvent, MagicState> {
  final formKey = GlobalKey<FormState>();
  GetCardsUseCase getCardsUseCases;

  MagicBloc(
    this.getCardsUseCases,
  ) : super(const MagicState()) {
    on<FormSubmit>((event, emit) async {
      Resource<List<MagicCard>> response = await getCardsUseCases.run();
      if (response is Success<List<MagicCard>>) {
        emit(state.copyWith(
          cards: response.data,
        ));
      } else if (response is Error<List<MagicCard>>) {
        emit(state.copyWith(
          cards: state.cards,
        ));
      }
    });

    on<CardSelected>((event, emit) {
      emit(state.copyWith(
        selectedCard: event.card,
        cards: state.cards,
      ));
    });
  }

  void setSelectedCard(MagicCard card) {
    add(CardSelected(card));
  }

  void submitForm() {
    add(FormSubmit());
  }
}
