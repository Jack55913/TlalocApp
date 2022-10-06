// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMobService {
//   static String? get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/6300978111';
//     }
//     return null;
//   }

//   static String? get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/1033173712';
//     }
//     return null;
//   }

//   static String? get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/5224354917';
//     }
//     return null;
//   }

//   static final BannerAdListener bannerListener = BannerAdListener(
//       onAdLoaded: (ad) => debugPrint('Ad loaded'),
//       onAdFailedToLoad: (ad, error) {
//         ad.dispose();
//         debugPrint('Ad failed to load: $error');
//       },
//       onAdOpened: (ad) => debugPrint('Ad opened'),
//       onAdClosed: (ad) => debugPrint('Ad closed'),
//       );
// }
