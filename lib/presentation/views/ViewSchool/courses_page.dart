import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. WIDGET PRINCIPAL DE LA APLICACIÓN
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Cursos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const CoursesPage(),
    );
  }
}

// 2. PÁGINA PRINCIPAL CON LA LISTA DE CURSOS
class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) return 3;
    if (screenWidth > 400) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Cursos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Listado de Cursos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: _calculateCrossAxisCount(context),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: const [
                  _CourseCard(courseName: '1º SMR'),
                  _CourseCard(courseName: '2º SMR'),
                  _CourseCard(courseName: '1º DAM'),
                  _CourseCard(courseName: '2º DAM'),
                  _CourseCard(courseName: '1º DAW'),
                  _CourseCard(courseName: '2º DAW'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. TARJETA INDIVIDUAL DE CADA CURSO (ESTILO IDÉNTICO A LOS BOTONES USER/CLASS)
class _CourseCard extends StatelessWidget {
  final String courseName;

  const _CourseCard({required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Espaciado similar al de los botones
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder:
                  (_, __, ___) => ViewCoursesPage(courseName: courseName),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.25),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutQuart,
                      ),
                    ),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
        child: Text(
          courseName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// 4. PÁGINA DE DETALLE DEL CURSO
class ViewCoursesPage extends StatefulWidget {
  final String courseName;

  const ViewCoursesPage({super.key, required this.courseName});

  @override
  State<ViewCoursesPage> createState() => _ViewCoursesPageState();
}

class _ViewCoursesPageState extends State<ViewCoursesPage> {
  int _selectedIndex = 0;
  final List<String> _teachers = ['Profesor 1', 'Profesor 2', 'Profesor 3'];
  List<String> _subjects = [];

  @override
  void initState() {
    super.initState();
    _subjects = _getInitialSubjects();
  }

  List<String> _getInitialSubjects() {
    switch (widget.courseName) {
      case '1º SMR':
        return [
          'Sistemas Operativos monopuesto',
          'Ofimática',
          'Montaje y mantenimiento de equipos',
          'Redes locales',
          'Itinerario personal',
        ];
      case '2º SMR':
        return [
          'Sistemas Operativos en red',
          'Servicios en red',
          'Aplicaciones web',
          'Seguridad informática',
          'Itinerario personal',
        ];
      case '1º DAM':
        return [
          'Programación',
          'Bases de datos',
          'Lenguajes de marcas',
          'Entornos de desarrollo',
          'Sistemas informáticos',
        ];
      case '2º DAM':
        return [
          'Acceso a datos',
          'Desarrollo de interfaces',
          'Programación multimedia',
          'Programación de servicios',
          'Sistemas de gestión empresarial',
        ];
      case '1º DAW':
        return [
          'Programación',
          'Bases de datos',
          'Lenguajes de marcas',
          'Entornos de desarrollo',
          'Sistemas informáticos',
        ];
      case '2º DAW':
        return [
          'Desarrollo web en entorno cliente',
          'Desarrollo web en entorno servidor',
          'Despliegue de aplicaciones web',
          'Diseño de interfaces web',
          'Proyecto de desarrollo de aplicaciones web',
        ];
      default:
        return [];
    }
  }

  // 5. BOTONES DE PESTAÑA (ESTILO ORIGINAL)
  Widget _buildTabButton(String text, int index) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _selectedIndex == index ? Colors.blue : Colors.grey[300],
          foregroundColor:
              _selectedIndex == index ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => setState(() => _selectedIndex = index),
        child: Text(text),
      ),
    );
  }

  // 6. MENÚ DESLIZABLE CON CHECKBOXES CIRCULARES Y ACTUALIZACIÓN INMEDIATA
  void _showAddSubjectMenu() {
    final allSubjects = [
      'Sistemas Operativos monopuesto',
      'Ofimática',
      'Montaje y mantenimiento de equipos',
      'Redes locales',
      'Itinerario personal',
      'Sistemas Operativos en red',
      'Servicios en red',
      'Aplicaciones web',
      'Seguridad informática',
      'Programación',
      'Bases de datos',
      'Lenguajes de marcas',
      'Entornos de desarrollo',
      'Sistemas informáticos',
      'Acceso a datos',
      'Desarrollo de interfaces',
      'Programación multimedia',
      'Programación de servicios',
      'Sistemas de gestión empresarial',
      'Desarrollo web en entorno cliente',
      'Desarrollo web en entorno servidor',
      'Despliegue de aplicaciones web',
      'Diseño de interfaces web',
      'Proyecto de desarrollo de aplicaciones web',
    ];

    final selectedSubjects = <String>[];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Barra de arrastre
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    // Encabezado con botón AÑADIR a la derecha
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Añadir asignaturas',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            onPressed: () {
                              final newSubjects =
                                  selectedSubjects
                                      .where(
                                        (subject) =>
                                            !_subjects.contains(subject),
                                      )
                                      .toList();

                              if (newSubjects.isNotEmpty) {
                                // Actualizamos el estado principal
                                setState(() {
                                  _subjects.addAll(newSubjects);
                                });

                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${newSubjects.length} asignatura(s) añadida(s)',
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'No hay asignaturas nuevas para añadir',
                                    ),
                                    backgroundColor: Colors.orange,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'AÑADIR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Lista con checkboxes circulares
                    Expanded(
                      child: ListView.builder(
                        itemCount: allSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = allSubjects[index];
                          final alreadyAdded = _subjects.contains(subject);

                          return ListTile(
                            leading: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: selectedSubjects.contains(subject),
                                onChanged:
                                    alreadyAdded
                                        ? null
                                        : (bool? value) {
                                          setModalState(() {
                                            if (value == true) {
                                              selectedSubjects.add(subject);
                                            } else {
                                              selectedSubjects.remove(subject);
                                            }
                                          });
                                        },
                                shape: const CircleBorder(),
                                activeColor: Colors.blue,
                              ),
                            ),
                            title: Text(
                              subject,
                              style: TextStyle(
                                color:
                                    alreadyAdded ? Colors.grey : Colors.black,
                              ),
                            ),
                            subtitle:
                                alreadyAdded
                                    ? const Text(
                                      'Ya añadida',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                    : null,
                            onTap:
                                alreadyAdded
                                    ? null
                                    : () {
                                      setModalState(() {
                                        if (selectedSubjects.contains(
                                          subject,
                                        )) {
                                          selectedSubjects.remove(subject);
                                        } else {
                                          selectedSubjects.add(subject);
                                        }
                                      });
                                    },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddSubjectMenu,
          ),
        ],
      ),
      body: Column(
        children: [
          // Selector de pestañas (estilo original)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildTabButton('User', 0),
                const SizedBox(width: 16),
                _buildTabButton('Class', 1),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Contenido de la pestaña seleccionada
          Expanded(
            child:
                _selectedIndex == 0
                    ? _buildTeachersList()
                    : _buildSubjectsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachersList() {
    return ListView.builder(
      itemCount: _teachers.length,
      itemBuilder:
          (context, index) => ListTile(
            title: Text(_teachers[index]),
            leading: const Icon(Icons.person),
          ),
    );
  }

  Widget _buildSubjectsList() {
    return ListView.builder(
      itemCount: _subjects.length,
      itemBuilder:
          (context, index) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(_subjects[index]),
              leading: const Icon(Icons.book),
            ),
          ),
    );
  }
}
