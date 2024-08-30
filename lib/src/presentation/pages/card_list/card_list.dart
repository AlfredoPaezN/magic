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
  ScrollController scrollController = ScrollController();
  bool jumpToTop = false;
  int page = 1;

  @override
  void initState() {
    scrollController.addListener(scrollListener);

    super.initState();
  }

  void scrollListener() {
    if (scrollController.offset <= 300) {
      jumpToTop = false;
      setState(() {});
    }

    if (scrollController.offset >= 400 &&
        !scrollController.position.outOfRange) {
      jumpToTop = true;
      setState(() {});
    }
    if (scrollController.offset >=
            (scrollController.position.maxScrollExtent) &&
        !scrollController.position.outOfRange) {
      setState(() {});

      page++;
      context.read<MagicBloc>().loadMoreCards(page);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Loading more cards')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (jumpToTop)
              FloatingActionButton(
                onPressed: () {
                  if (jumpToTop) {
                    scrollController.animateTo(0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  }
                },
                backgroundColor: const Color(MagicColors.primary),
                child: const Icon(Icons.arrow_upward_outlined),
              ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                context.goNamed(Routes.me);
              },
              backgroundColor: const Color(MagicColors.primary),
              child: const Icon(Icons.person),
            ),
          ],
        ),
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
                      scrollController: scrollController,
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
