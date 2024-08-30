import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:magic/src/domain/utils/Resources.dart';
import 'package:magic/src/presentation/bloc/magic_bloc.dart';
import 'package:magic/src/presentation/bloc/magic_event.dart';
import 'package:magic/src/presentation/bloc/magic_state.dart';
import 'package:magic/src/presentation/utils/colors.dart';
import 'package:magic/src/presentation/widgets/custom_button.dart';
import 'package:magic/src/presentation/widgets/info_card.dart';
import 'package:magic/src/routes/routes_constants.dart';

class MeContent extends StatelessWidget {
  const MeContent({this.state, super.key});

  final MagicState? state;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 150,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(
                  'assets/images/profile.png',
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            InfoCard(
                width: 300.w,
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _insertText('Full Name', fontSize: 15, color: Colors.black),
                    _insertText('Alfredo Junior Paez Nuñez'),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    _insertText('Email', fontSize: 15, color: Colors.black),
                    _insertText('alfredo.paezn@gmail.com'),
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            BlocListener<MagicBloc, MagicState>(
              listener: (context, state) {
                if (state.cards != []) {
                  context.goNamed(Routes.cards);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Errorss: ${state.cards}')),
                  );
                }
                if (state.cards is Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.cards}')),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: 'Let\'s Start!',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<MagicBloc>().add(FormSubmit());
                  },
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            _insertText('Thu, 29 Aug 2024'),
          ],
        ),
      ),
    );
  }

  Widget _insertText(String text,
      {double? fontSize = 22,
      Color? color = const Color(MagicColors.primary)}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
