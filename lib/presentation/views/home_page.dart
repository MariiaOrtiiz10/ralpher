import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:popover/popover.dart';
import 'package:ralpher/widgets/popover_item.dart';
import 'package:ralpher/data/repositories/school_repository.dart';
import 'package:ralpher/presentation/viewmodels/viewmodels.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputTextName = TextEditingController();
  List<Map<String, dynamic>> dataSchools = [];
  final SchoolRepository _schoolRepository = SchoolRepository();
  final ViewModels _viewModels = ViewModels();
  // Map<String, dynamic>? schedule;
  // Map<String, dynamic>? calendarSettings;

  Color? selectedColor;
  String? imgurl;
  String? imgname;
  File? selectedImage;

  void handleColorChanged(Color? color) {
    setState(() {
      selectedColor = color;
    });
  }
  void handleImageChanged(String? imageurl){
    setState(() {
      imgurl = imageurl;
    });
  }
  void handleImageFileChanged(File? image){
    setState(() {
      selectedImage = image;
    });

  }

  void createSchool() {
    var user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      print("Usuario no autenticado. No se puede crear una escuela.");
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(255, 235, 235, 247),
      builder:
          (context) => Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Create New School",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: inputTextName,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            side: BorderSide(color: Colors.black),
                            backgroundColor: selectedColor ?? Colors.teal,
                            minimumSize: Size(30, 30),
                          ),
                          onPressed: () {
                            openColorBottomSheet(
                              context,
                              selectedColor ?? Colors.blue,
                              handleColorChanged,
                            );
                          },
                          child: Text(""),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: () async {
                      final image = await _viewModels.pickImage();
                      if (image != null) {
                        handleImageFileChanged(image);
                       }
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Selecciona una foto",
                        style: TextStyle( 
                          fontSize: 15,
                          color: Color.fromARGB(255, 10, 65, 184),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: selectedImage != null
                        ? Image.file(selectedImage!, fit: BoxFit.cover) // Muestra la imagen seleccionada
                        : Container(
                            color: Colors.grey[300], // Fondo gris si no hay imagen
                            child: const Center(child: Text("No image")),
                          ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 40),
                    ),
                    onPressed: () async {
                      if (inputTextName.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Ingresa un nombre para la escuela.")),
                        );
                        return;
                      }

                      try {
                        String colorHex = "#${selectedColor!.value.toRadixString(16).substring(2)}";

                        String? imgname;
                        String? imgurl;

                        if (selectedImage != null) {
                          final uploadResult = await _viewModels.uploadImage(selectedImage!);
                          if (uploadResult != null) {
                            imgname = uploadResult['imgname'];
                            imgurl = uploadResult['imgurl'];
                          }
                        }

                        await _schoolRepository.createSchool(
                          inputTextName.text,
                          colorHex,
                          imgname,
                          imgurl,
                          null,
                          null,
                        );

                        inputTextName.clear();
                        getSchools();
                        selectedColor = null;
                        selectedImage = null; 

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        print(e);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void openColorBottomSheet(
    BuildContext context,
    Color selectedColor,
    Function(Color) onColorSelected,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(12),
            child: DefaultTabController(
              length: 2,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Color",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    const TabBar(
                      tabs: [
                        Tab(text: "Block Picker"),
                        Tab(text: "Material Picker"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          //Tab 1: BlockPicker (Colores Básicos)
                          BlockPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (Color color) {
                              onColorSelected(color);
                              Navigator.pop(context); // Cierra el BottomSheet
                            },
                          ),
                          //Tab2
                          // ColorPicker(
                          //   pickerColor: selectedColor,
                          //   onColorChanged: (Color color){
                          //       onColorSelected(color);
                          //       print(color);
                          //   },
                          // )
                          // Tab 3: MaterialPicker (Drag & Drop)
                          MaterialPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (Color color) {
                              onColorSelected(color);
                              Navigator.pop(context);
                            },
                          ),

                          //Tab3
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  getSchools() async {
    var result = await _schoolRepository.getSchoolFromUser();
    setState(() {
      dataSchools = result ?? [];
      print("DataSchools $dataSchools");
    });
  }

  deleteSchool(int id) async {
    await _schoolRepository.deleteSchool(id);
    Future.delayed(Duration(milliseconds: 150), () {
      getSchools();
    });
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    super.initState();
    getSchools();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schools"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              createSchool();
            },
            icon: Icon(Icons.add),
            color: const Color.fromARGB(255, 39, 133, 211),
            iconSize: 30,
          ),
        ],
      ),
      body: Center(
        child:
            dataSchools.isEmpty
                ? Text("There are no Schools")
                : ListView.builder(
                  itemCount: dataSchools.length,
                  itemBuilder: (context, index) {
                    Color backgroundColor = hexToColor(
                      dataSchools[index]['color'],
                    );
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      padding: EdgeInsets.all(10),
                      height: 150,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () {
                                print("clicado");
                              },
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              dataSchools[index]['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Builder(
                              builder:
                                  (context) => IconButton(
                                    onPressed: () async {
                                      showPopover(
                                        height: 40,
                                        width: 300,
                                        direction: PopoverDirection.top,
                                        arrowHeight: 0,
                                        context: context,
                                        bodyBuilder:
                                            (context) => PopoverItem(
                                              deleteTab:
                                                  () => deleteSchool(
                                                    dataSchools[index]['id'],
                                                  ),
                                            ),
                                      );
                                    },
                                    icon: Icon(Icons.more_horiz),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
