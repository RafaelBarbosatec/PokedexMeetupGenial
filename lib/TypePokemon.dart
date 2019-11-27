class TypePokemon {
  String thumbnailImage;
  String name;

  TypePokemon({this.thumbnailImage, this.name});

  TypePokemon.fromJson(Map<String, dynamic> json) {
    thumbnailImage = json['thumbnailImage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnailImage'] = this.thumbnailImage;
    data['name'] = this.name;
    return data;
  }
}
