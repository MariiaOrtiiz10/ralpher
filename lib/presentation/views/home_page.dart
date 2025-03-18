import 'dart:io';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:ralpher/data/models/school.dart';
import 'package:ralpher/data/repositories/school_repository.dart';
import 'package:ralpher/widgets/popover_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController inputTextName = TextEditingController();
  List<Map<String, dynamic>> schools = [];
  final SchoolRepository _schoolRepository = SchoolRepository();
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
            content: TextField(
              controller: inputTextName,
              decoration: InputDecoration(hintText: "Nombre de la escuela"),
            ),
            actions: [
              MaterialButton(
                child: Text("Cancel"),
                onPressed: () async {
                  inputTextName.clear();
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text("Create"),
                onPressed: () async {
                  try {
                    _schoolRepository.createSchool(
                      inputTextName.text,
                      'Color',
                      'Imagen',
                    );
                    inputTextName.clear();
                    getSchools();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print(e);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
    );
  }

  getSchools() async {
    var result = await _schoolRepository.getSchoolFromUser();
    setState(() {
      schools = result ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    getSchools();
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
            schools.isEmpty
                ? Text("There are no Schools")
                : ListView.builder(
                  itemCount: schools.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      padding: EdgeInsets.all(10),
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Text(
                              schools[index]['name'] ?? 'Sin nombre',
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
                                        bodyBuilder: (context) => PopoverItem(),
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
