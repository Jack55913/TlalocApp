import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/kernel.dart';
import 'package:tlaloc/src/models/parallax.dart';

void _goHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return const HomePage();
      },
    ),
    (Route<dynamic> route) => false,
  );
}

class LocationListItem extends StatelessWidget {
  LocationListItem({
    super.key,
    required this.commonimage,
    required this.paraje,
    required this.ejido,
  });

  final String commonimage;
  final String paraje;
  final String ejido;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: InkWell(
          onTap: () async {
            _goHome(context);
            final state = Provider.of<AppState>(context, listen: false);
            state.changeParaje(paraje);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
                _buildTitleAndSubtitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Builder(
      builder: (context) {
        return Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: _backgroundImageKey,
          ),
          children: [
            Image.asset(
              commonimage,
              key: _backgroundImageKey,
              fit: BoxFit.cover,
            ),
          ],
        );
      },
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            paraje,
            style: const TextStyle(
              fontFamily: 'FredokaOne',
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ejido,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,

              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
