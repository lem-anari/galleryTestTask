import 'package:flutter/material.dart';


class FullImgPage extends StatelessWidget  {

  final String? imgUrlBigSize;
  final String? imgName;
  FullImgPage(this.imgUrlBigSize, this.imgName);

  @override
  Widget build(BuildContext context) {
    final fullSize = this.imgUrlBigSize;
    final name = this.imgName.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
        backgroundColor: Colors.black,//color
      ),
      body: Center(
        child: FlatButton(
          child: Image.network(
              fullSize.toString(),
              fit:BoxFit.fill
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
