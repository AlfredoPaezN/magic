import 'package:bloc_test/bloc_test.dart';
import 'package:magic/src/di/AppModule.dart';
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:mocktail/mocktail.dart';

class MockMagicBloc extends Mock implements MagicBloc {}

class MockGetCardsUseCase extends Mock implements GetCardsUseCase {}

class MockMagicState extends Fake implements MagicState {}

class TestAppModule extends AppModule {}
