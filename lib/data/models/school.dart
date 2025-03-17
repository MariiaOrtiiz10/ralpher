class School {
   int? id;
   String name;
   String? color;
   String? image;

  School({ this.id, required this.name, this.color, this.image });

  Map<String, dynamic> toJson(){
    return{
      'name':name,
      'color': color?? '',
      'image':image?? '',
    };
  }
  factory School.fromJson(Map<String, dynamic> data){
    return School(
      id: data['id'] as int,
      name: data['name'] as String,
      color: data['color'] as String?,
      image: data['image'] as String?,
     );
  }


}