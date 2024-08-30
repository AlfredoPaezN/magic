import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:magic/src/presentation/utils/colors.dart';
import 'package:magic/src/presentation/widgets/magic_card.dart';
import 'package:magic/src/presentation/widgets/staggered_dual.dart';
import 'package:magic/src/routes/routes_constants.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(MagicColors.backgroundColor),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: const Text(
            'Magic: The Gathering',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(MagicColors.primary),
            ),
          ),
        ),
        body: BlocBuilder<MagicBloc, MagicState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StaggeredDualView(
                      spacing: 10,
                      aspectRatio: 0.7,
                      itemCount: state.cards!.length,
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () {
                          context
                              .read<MagicBloc>()
                              .setSelectedCard(state.cards![i]);
                        },
                        child: BlocListener<MagicBloc, MagicState>(
                          listener: (context, state) {
                            if (state.selectedCard != null) {
                              context.goNamed(Routes.detail);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Error: ${state.cards}')),
                              );
                            }
                          },
                          child: MagicCardWidget(
                            card: state.cards![i],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
