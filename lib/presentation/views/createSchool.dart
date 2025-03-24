import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ralpher/core/services/auth_service.dart';
import 'package:ralpher/data/models/user_model.dart';
import 'package:ralpher/data/repositories/user_repository.dart';
import 'package:ralpher/presentation/views/class_page.dart';
import 'package:ralpher/presentation/views/schedule_page.dart';
import 'package:ralpher/presentation/views/release_page.dart';
import 'package:ralpher/presentation/views/fouls_page.dart';
import 'package:ralpher/presentation/views/incidents_page.dart';
import 'package:ralpher/presentation/views/schoolGrades_page.dart';
import 'package:ralpher/presentation/views/courses_page.dart';
import 'package:ralpher/presentation/views/information_page.dart';
import 'package:ralpher/presentation/views/users_page.dart';

class CreateSchool extends StatefulWidget {
  final UserRepository userRepository;
  const CreateSchool({super.key, required this.userRepository});

  @override
  State<CreateSchool> createState() => _CreateSchoolState();
}

class _CreateSchoolState extends State<CreateSchool> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final authService = AuthService();
  UserModel? currentUser;
  String? userRole;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await widget.userRepository.getCurrentUserData();
      if (user != null) {
        final role = await widget.userRepository.getUserRole(user.id);
        setState(() {
          currentUser = user;
          userRole = role;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  void _navigateToPage(String pageName) {
    switch (pageName.toLowerCase()) {
      case 'class':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClassPage()),
        );
        break;
      case 'schedule':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchedulePage()),
        );
        break;
      case 'release':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReleasePage()),
        );
        break;
      case 'fouls':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoulsPage()),
        );
        break;
      case 'incidents':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IncidentsPage()),
        );
        break;
      case 'school grades':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchoolGradesPage()),
        );
        break;
      case 'courses':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoursesPage()),
        );
        break;
      case 'information':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationPage()),
        );
        break;
      case 'users':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UsersPage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("School")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth <= 300;
          final minHeight = 500.0;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Usuario: ${currentUser?.name ?? "Cargando..."}",
                      style: TextStyle(
                        fontSize:
                            isSmallScreen
                                ? constraints.maxWidth * 0.06
                                : constraints.maxWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rol: ${userRole?.toUpperCase() ?? "Cargando..."}",
                      style: TextStyle(
                        fontSize:
                            isSmallScreen
                                ? constraints.maxWidth * 0.055
                                : constraints.maxWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (currentUser == null)
                      Center(
                        child: Text("No se encontraron datos del usuario."),
                      )
                    else
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: isSmallScreen ? 1 : 2,
                        crossAxisSpacing:
                            isSmallScreen ? 0 : constraints.maxWidth * 0.05,
                        mainAxisSpacing: constraints.maxHeight * 0.03,
                        childAspectRatio: isSmallScreen ? 3.0 : 2.5,
                        children: [
                          _buildMenuItem(
                            "Class",
                            Icons.school,
                            constraints,
                            () => _navigateToPage('class'),
                          ),
                          _buildMenuItem(
                            "Schedule",
                            Icons.calendar_today,
                            constraints,
                            () => _navigateToPage('schedule'),
                          ),
                          _buildMenuItem(
                            "Release",
                            Icons.exit_to_app,
                            constraints,
                            () => _navigateToPage('release'),
                          ),
                          _buildMenuItem(
                            "Fouls",
                            Icons.warning,
                            constraints,
                            () => _navigateToPage('fouls'),
                          ),
                          _buildMenuItem(
                            "Incidents",
                            Icons.report_problem,
                            constraints,
                            () => _navigateToPage('incidents'),
                          ),
                          _buildMenuItem(
                            "School Grades",
                            Icons.grade,
                            constraints,
                            () => _navigateToPage('school grades'),
                          ),
                          _buildMenuItem(
                            "Courses",
                            Icons.menu_book,
                            constraints,
                            () => _navigateToPage('courses'),
                          ),
                          _buildMenuItem(
                            "Information",
                            Icons.info,
                            constraints,
                            () => _navigateToPage('information'),
                          ),
                          _buildMenuItem(
                            "Users",
                            Icons.people,
                            constraints,
                            () => _navigateToPage('users'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    IconData icon,
    BoxConstraints constraints,
    VoidCallback onTap,
  ) {
    final isSmallScreen = constraints.maxWidth <= 300;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size:
                      isSmallScreen
                          ? constraints.maxWidth * 0.08
                          : constraints.maxWidth * 0.06,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          isSmallScreen
                              ? constraints.maxWidth * 0.04
                              : constraints.maxWidth * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
