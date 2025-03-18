import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:popover/popover.dart';
import 'package:ralpher/data/repositories/school_repository.dart';
import 'package:ralpher/widgets/colorPicker_item.dart';
import 'package:ralpher/widgets/popover_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputTextName = TextEditingController();
  //Map<String, dynamic> dataSchools = {};
  List<Map<String, dynamic>> dataSchools = [];

  final SchoolRepository _schoolRepository = SchoolRepository();
  Color? selectedColor;
  // File ? _selectedImage;
  // Uint8List? _webImage;

  void createSchool() {
    var user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      print("Usuario no autenticado. No se puede crear una escuela.");
      return;
    }
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Crear nueva escuela"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: inputTextName,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Color"),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                      final color = await showModalBottomSheet<Color>(
                      context: context,
                      isDismissible: true,
                      enableDrag: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => ColorPickerItem(
                        initialColor: selectedColor ?? const Color.fromARGB(255, 0, 23, 230),
                        onColorChanged: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                    );
                    if (color != null) {
                      setState(() {
                        selectedColor = color;
                      });
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: selectedColor ?? const Color.fromARGB(255, 0, 23, 230),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  inputTextName.clear();
                  selectedColor = null;
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              // Botón para crear la escuela
              TextButton(
                onPressed: () async {
                  if (inputTextName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ingresa un nombre para la escuela."),
                      ),
                    );
                    return;
                  }

                  try {
                    String colorHex =
                        "#${selectedColor!.value.toRadixString(16).substring(2)}";
                    await _schoolRepository.createSchool(
                      inputTextName.text,
                      colorHex,
                      null,
                    );

                    inputTextName.clear();
                    selectedColor = null;
                    getSchools();

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
                child: const Text("Crear"),
              ),
            ],
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
    getSchools();
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    super.initState();
    getSchools();
    selectedColor;
    print("DataSchools $dataSchools");
  }

  @override
  Widget build(BuildContext context) {
    //get usermail
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.add),
        onPressed: () async {
          createSchool();
        },
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
                                        height: 35,
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
