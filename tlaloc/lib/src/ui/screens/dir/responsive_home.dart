import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/cards/phrase.dart';
import 'package:tlaloc/src/ui/widgets/cards/tlalocmap.dart';
import 'package:tlaloc/src/ui/widgets/cards/communitybutton.dart';
import 'package:tlaloc/src/ui/widgets/buttons/notebook.dart';
import 'package:tlaloc/src/ui/widgets/backgrounds/container.dart';
import 'package:tlaloc/src/ui/widgets/social/social_media.dart';

class ResponsivePhraseMapSection extends StatelessWidget {
  const ResponsivePhraseMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;

        if (isWide) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟩 IZQUIERDA: Phrase, Button, Community
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PhraseCard(),
                      SizedBox(height: 12),
                      TableButton(),
                      SizedBox(height: 12),
                      CommunityButton(),
                      GlassContainer(
                        child: Column(
                          children: [
                            Text(
                              'Redes sociales',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FredokaOne',
                              ),
                            ),

                            SocialLinksWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24), // Separación horizontal
                // 🟦 DERECHA: TlalocMapData
                Expanded(
                  flex: 2,
                  child: GlassContainer(child: TlalocMapData()),
                ),
              ],
            ),
          );
        } else {
          // 📱 MÓVIL: orden original en columna
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Phrase + Table button en fila
              Center(
                child: Row(
                  children: [
                    Expanded(child: PhraseCard()),
                    SizedBox(width: 10),
                    TableButton(),
              SizedBox(height: 20),
                  ],
                ),
              ),
              GlassContainer(child: TlalocMapData()),
              SizedBox(height: 10),
              CommunityButton(),
              SizedBox(height: 10),
              GlassContainer(
                child: Column(
                  children: [
                    Text(
                      'Redes sociales',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FredokaOne',
                      ),
                    ),

                    SocialLinksWidget(),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
