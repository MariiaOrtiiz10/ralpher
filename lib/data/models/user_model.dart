class UserModel {
  String id;
  String? name;
  String? surnaname;
  String? imgname;
  String? imgurl;
  

  UserModel({required this.id, this.name, this.surnaname,this.imgname,this.imgurl});

  //Para guaradrlo en la bbdd. (obj --> mapa json)
  Map<String, dynamic> toJson(){
    return{
      'name':name,
      'surname': surnaname,
      'imgname':imgname,
      'imgurl':imgurl,
    };
  }
  //Para la app. (mapa json --> obj)
  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      surnaname: json['surname'],
      imgname: json['imgname'],
      imgurl: json['imgurl'],
     );
  }


}