import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  // static String get appOpenAdUnitId => Platform.isAndroid
  //   ? 'ca-app-pub-3940256099942544/3419835294'
  //   : 'ca-app-pub-3940256099942544/5662855259';
  static String get appOpenAdUnitId => 'ca-app-pub-5988017258715205/7447999199';
  //   static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/7049598008';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/3964253750';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/8673189370';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/7552160883';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5988017258715205/5655215030';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5988017258715205/5627294872';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3964253750';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8673189370';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/7552160883';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => log('Ad loaded'),
    onAdFailedToLoad: (ad, error) => log('Ad failed to load $error'),
    onAdOpened: (ad) => log('Ad opened'),
    onAdClosed: (ad) => log('Ad closed'),
  );
}

InterstitialAd? interstitialAd;
BannerAd? bannerAd;

void createInterstitialAd() {
  InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (LoadAdError error) => interstitialAd = null,
      ));
}

void showInterstitialAd() {
  if (interstitialAd != null) {
    interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      createInterstitialAd();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      log('$error');
      ad.dispose();
      createInterstitialAd();
    });
    interstitialAd!.show();
    interstitialAd = null;
  }
}

void createBannerAd() {
  bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: AdHelper.bannerListener,
      request: const AdRequest())
    ..load();
}
