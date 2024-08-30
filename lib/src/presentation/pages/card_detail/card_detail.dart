import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/presentation/pages/card_detail/card_detail_content.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:magic/src/presentation/utils/colors.dart';
import 'package:magic/src/routes/routes_constants.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({super.key});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color(MagicColors.primary),
          onPressed: () {
            if (Navigator.canPop(context)) {
              context.pop();
            } else {
              context.goNamed(Routes.cards);
            }
          },
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'CARD DETAIL',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(MagicColors.primary),
          ),
        ),
      ),
      backgroundColor: const Color(MagicColors.backgroundColor),
      body: BlocBuilder<MagicBloc, MagicState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: DetailHeader(
                  cardImage: state.selectedCard?.imageUrl ?? '',
                  cardId: state.selectedCard?.id ?? '',
                ),
              ),
              Expanded(
                flex: 9,
                child: DetailBody(card: state.selectedCard!),
              ),
            ],
          );
        },
      ),
    );
  }
}

TextStyle? boldTextStyle() {
  return TextStyle(
    color: const Color(MagicColors.primary),
    fontWeight: FontWeight.bold,
    fontSize: 13.sp,
  );
}

TextStyle? subTextStyle() {
  return const TextStyle(
    color: Color(MagicColors.yellow),
    fontWeight: FontWeight.bold,
  );
}

Color evaluateCalificationColor(int calification) {
  switch (calification) {
    case < 3:
      return const Color(MagicColors.red);
    case < 5:
      return const Color(MagicColors.yellow);
    case 5:
      return const Color(MagicColors.green);
    default:
      return const Color(MagicColors.red);
  }
}

List<Icon> generateCalificationAction(int calification) {
  final iconsList = List<Icon>.generate(calification, (index) {
    return Icon(
      Icons.circle_rounded,
      size: 20,
      color: evaluateCalificationColor(calification),
    );
  });

  iconsList.addAll(
    List.generate(5 - calification, (index) {
      return Icon(
        Icons.circle_outlined,
        size: 20,
        color: evaluateCalificationColor(calification),
      );
    }),
  );

  return iconsList;
}
