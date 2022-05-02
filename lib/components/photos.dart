class Photo {
  String? imgUrl;
  String? imgAuthor;
  String? imgName;
  String? imgUrlBigSize;

  Photo({this.imgUrl, this.imgAuthor, this.imgUrlBigSize, this.imgName});//without {}
  Photo.fromJson(Map<String, dynamic> json){
    imgUrl = json['urls']['thumb'];
    imgAuthor = json['user']['name'];
    imgName = json['user']['username'];
    imgUrlBigSize = json['urls']['full'];
  }
}
