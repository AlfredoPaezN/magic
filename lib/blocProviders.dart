import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/injection.dart';
import 'package:magic/src/domain/useCases/auth/GetCardsUseCase.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_event.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<MagicBloc>(
    create: (context) => MagicBloc(locator<GetCardsUseCase>()),
  )
];
