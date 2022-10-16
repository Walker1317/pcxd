import 'package:flutter/material.dart';

class DialogServices{

  DialogServices.showLoading(BuildContext context){
    showDialog(
      context: context,
      builder: (context){
        return WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Center(
            child: Card(
              color: const Color.fromARGB(255, 24, 0, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      }
    );
  }

}