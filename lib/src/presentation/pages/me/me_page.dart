import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:magic/src/presentation/pages/me/me_content.dart';
import 'package:magic/src/presentation/utils/colors.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(MagicColors.backgroundColor),
      body: BlocBuilder<MagicBloc, MagicState>(
        builder: (context, state) {
          return MeContent(
            state: state,
          );
        },
      ),
    );
  }
}
