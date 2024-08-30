import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/presentation/pages/card_detail/card_detail.dart';
import 'package:magic/src/presentation/utils/colors.dart';
import 'package:magic/src/presentation/widgets/info_card.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({required this.card, super.key});

  final MagicCard card;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoCard(
              description: Text(card.name ?? '', style: subTextStyle()),
              data: Text(
                'Name',
                style: boldTextStyle(),
              ),
            ),
            InfoCard(
              description: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(card.types?[0] ?? "", style: subTextStyle()),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
              data: Text(
                'Type',
                style: boldTextStyle(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        InfoCard(
          description: Text(card.text!, style: subTextStyle()),
          data: Text(
            'Description',
            style: boldTextStyle(),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoCard(
              description: Text('${card.subtypes} ', style: subTextStyle()),
              data: Text(
                'Subtypes',
                style: boldTextStyle(),
              ),
            ),
            InfoCard(
              description: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (card.power == null)
                    const Text('Unknown')
                  else
                    ...generateCalificationAction(int.parse(card.power!)),
                ],
              ),
              data: Text(
                'Power',
                style: boldTextStyle(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        InfoCard(
          description: Text(card.setName ?? '', style: subTextStyle()),
          data: Text(
            'Set Name',
            style: boldTextStyle(),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoCard(
              description: Text('${card.foreignNames?.length} languages',
                  style: subTextStyle()),
              data: Text(
                'Languajes',
                style: boldTextStyle(),
              ),
            ),
            InfoCard(
              description: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (card.toughness == null)
                    const Text('Unknown')
                  else
                    ...generateCalificationAction(int.parse(card.toughness!)),
                ],
              ),
              data: Text(
                'Toughness',
                style: boldTextStyle(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.cardImage,
    required this.cardId,
  });
  final String cardImage;
  final String cardId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Center(
        child: AspectRatio(
          aspectRatio: 12 / 16,
          child: Hero(
            tag: 'image-$cardId',
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image.network(
                  cardImage,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/card_placeholder.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
