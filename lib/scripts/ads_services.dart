import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsServices {

  Future showIntersitalAd() async {

    _showAds(String id){
      InterstitialAd.load(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad){
            ad.show().then((value){
            }).catchError((e){
            });
          },
          onAdFailedToLoad: (LoadAdError error){
          }
        ),
      );
    }

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('settings')
    .doc('ads').get();

    if(snapshot['active'] == true){
      String id;
      if(snapshot['activeId'] != null){
        id = snapshot['activeId'];
      } else {
        id = snapshot['testId'];
      }
      _showAds(id);
    }

  }

}