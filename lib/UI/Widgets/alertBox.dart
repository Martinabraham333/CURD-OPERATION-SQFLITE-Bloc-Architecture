import 'package:flutter/material.dart';

alertBox(BuildContext context,msg){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Warning!!",style: TextStyle(color: Colors.red),),
          content: Container(
           child: Text(msg,style: TextStyle(fontSize: 20),),
          ),
          actions: [
        
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"))
          ],
        );
      });
}