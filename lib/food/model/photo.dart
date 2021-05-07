class Photo {
  final String height;
  final String html_attribution;
  final String photo_reference;

  Photo(this.height, this.html_attribution, this.photo_reference);

  Map<String,dynamic> toMap()=>
      { "height": this.height,
        "html_attribution": this.html_attribution,
        "photo_reference": this.photo_reference,

      };
}