import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tlaloc/src/models/ad_mob_service.dart';

BannerAd? _banner;

class GoogleAddWidget extends StatelessWidget {
  const GoogleAddWidget({Key? key}) : super(key: key);

  void initState() {
    _createBannerAd();
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _banner == null
        ? Container()
        : Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 50,
            child: AdWidget(ad: _banner!),
          );
  }
}
