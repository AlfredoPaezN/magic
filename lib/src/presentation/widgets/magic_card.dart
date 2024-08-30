import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magic/src/domain/models/magic_card.dart';
import 'package:magic/src/presentation/utils/colors.dart';

class MagicCardWidget extends StatelessWidget {
  const MagicCardWidget({
    required this.card,
    super.key,
  });
  final MagicCard card;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(MagicColors.secondary),
      elevation: 8,
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Hero(
              tag: 'image-${card.id}',
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: card.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: card.imageUrl!,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/card_placeholder.png',
                                fit: BoxFit.cover,
                                height: 300,
                                width: double.infinity,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/card_placeholder.png',
                              fit: BoxFit.cover,
                              height: 300,
                              width: double.infinity,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            card.types?[0] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    card.name ?? "",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(MagicColors.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      card.text ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(MagicColors.yellow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
