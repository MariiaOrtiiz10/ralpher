class School {
   String? id;
   String name;
   String? color;
   String? image;

  School({ this.id, required this.name, this.color, this.image });

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'color': color,
      'image':image,
    };
  }
  factory School.fromJson(Map<String, dynamic>json){
    return School(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      image: json['image'],
     );
  }


}