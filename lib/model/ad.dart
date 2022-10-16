
import 'package:cloud_firestore/cloud_firestore.dart';

class AD {

  String _image;
  String _url;
  String _country;
  int _priority;

  AD.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.country = documentSnapshot['country'];
    this.image = documentSnapshot['image'];
    this.url = documentSnapshot['url'];
    this.priority = documentSnapshot['priority'];
  }

  AD();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "url" : this.url,
      "image" : this.image,
      "country" : this.country,
      "priority" : this.priority,
    };

    return map;

  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }
  
  String get country => _country;

  set country(String value) {
    _country = value;
  }

  int get priority => _priority;

  set priority(int value) {
    _priority = value;
  }

}