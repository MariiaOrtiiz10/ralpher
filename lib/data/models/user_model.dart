class UserModel {
  String id;
  String? name;
  String? surname;
  String? imgname;
  String? imgurl;
  

  UserModel({required this.id, this.name, this.surname,this.imgname,this.imgurl});

  //Para guaradrlo en la bbdd. (obj --> mapa json)
  Map<String, dynamic> toJson(){
    return{
      'name':name,
      'surname': surname,
      'imgname':imgname,
      'imgurl':imgurl,
    };
  }
  //Para la app. (mapa json --> obj)
  factory UserModel.fromJson(Map<String, dynamic>json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      imgname: json['imgname'],
      imgurl: json['imgurl'],
     );
  }


}