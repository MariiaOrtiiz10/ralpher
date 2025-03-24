class School {
   int? id;
   String name;
   String? color;
   String? imgname;
    String? imgurl;

  School({ this.id, required this.name, this.color, this.imgname, this.imgurl });

  Map<String, dynamic> toJson(){
    return{
      'name':name,
      'color': color?? '',
      'imgname':imgname?? '',
      'imgurl':imgurl?? '',
    };
  }
  factory School.fromJson(Map<String, dynamic> data){
    return School(
      id: data['id'] as int,
      name: data['name'] as String,
      color: data['color'] as String?,
      imgname: data['imgname'] as String?,
      imgurl: data['imgurl'] as String?,
     );
  }


}