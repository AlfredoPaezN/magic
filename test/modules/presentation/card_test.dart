import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:magic/injection.config.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart';
import 'package:magic/src/domain/utils/Resources.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:magic/src/presentation/widgets/info_card.dart';
import 'package:magic/src/routes/routes_constants.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';
import '../../helpers/pump_app.dart';
import '../../mocks/card_mock.dart';

void main() {
  final locator = GetIt.instance;
  late MockMagicBloc magicBloc;
  late MockGetCardsUseCase getCardsUseCase;

  final cardJson = fixtureReader('card.json');
  final card =
      MagicCard.fromJson(json.decode(cardJson) as Map<String, dynamic>);

  setUpAll(() async {
    registerFallbackValue(MockMagicState());
    getCardsUseCase = MockGetCardsUseCase();
    magicBloc = MockMagicBloc();

    locator.reset();

    await locator.unregister<GetCardsUseCase>();
    await locator.unregister<MagicBloc>();
    locator
      ..registerFactory<GetCardsUseCase>(() => getCardsUseCase)
      ..registerFactory<MagicBloc>(() => magicBloc);

    when(() => getCardsUseCase.run()).thenAnswer((_) async => Success([card]));
    when(() => magicBloc.submitForm()).thenAnswer(
      (_) async => when(() => magicBloc.state).thenReturn(
        MagicState(cards: [card]),
      ),
    );

    HttpOverrides.global = null;
  });

  group('Card testing', () {
    testWidgets('Renders at least a Card', (tester) async {
      await tester.pumpRealRouterApp(
        Routes.cards,
        (child) => child,
        isConnected: false,
      );

      await tester.pumpAndSettle();

      expect(find.byType(MagicCard), findsOneWidget);
    });

    testWidgets('Renders selected bread in detail view', (tester) async {
      when(() => magicBloc.setSelectedCard(card)).thenAnswer(
        (_) async => when(() => magicBloc.state).thenReturn(
          MagicState(
            selectedCard: card,
            cards: [card],
          ),
        ),
      );

      await tester.pumpRealRouterApp(
        Routes.detail,
        (child) => child,
        isConnected: false,
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(MagicCard));

      await tester.pumpAndSettle();

      expect(find.byType(Image), findsAtLeast(1));
      expect(find.byType(InfoCard), findsAtLeast(5));
    });
  });
}
