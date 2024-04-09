import 'package:flutter/material.dart';
import 'package:prototipo_v2/screens/home_screen.dart';
import 'package:prototipo_v2/screens/profile.dart';
import 'package:prototipo_v2/screens/status.dart';

void main() {
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 90, 194, 231), // Color del fondo de la AppBar
        ),
      ),
      home: const ParkingScreen(),
    );
  }
}

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  ParkingScreenState createState() => ParkingScreenState();
}

class ParkingScreenState extends State<ParkingScreen> {
  List<bool> parkingSpaces = List.generate(10, (index) => false);
  int selectedIndex = 0; // Agrega esta línea

  void toggleParkingSpace(int index) {
    setState(() {
      parkingSpaces[index] = !parkingSpaces[index];
    });
  }

  openScreen(int index) {
    setState(() {
      MaterialPageRoute ruta = MaterialPageRoute(builder: (context) => const ParkingScreen());
      switch (index) {
        case 0:
          ruta = MaterialPageRoute(builder: (context) => const ProfileApp());
          break;
        case 1:
          ruta = MaterialPageRoute(builder: (context) => const StatusScreen());
          break;
      }
      selectedIndex = index;
      Navigator.push(context, ruta);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Lot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final ruta = MaterialPageRoute(builder: (context){
              return const HomeScreen();
            });
            Navigator.push(context, ruta);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Estado del parking:',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: List.generate(
                    5,
                    (index) => ParkingSpace(
                      index: index,
                      occupied: parkingSpaces[index],
                      onPressed: () => toggleParkingSpace(index),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    5,
                    (index) => ParkingSpace(
                      index: index + 5,
                      occupied: parkingSpaces[index + 5],
                      onPressed: () => toggleParkingSpace(index + 5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => openScreen(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(221, 2, 0, 0),
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.watch_later_outlined,
              color: Colors.black87,
            ),
            label: "Estatus",
          ),
        ],
      ),
    );
  }
}

class ParkingSpace extends StatelessWidget {
  final int index;
  final bool occupied;
  final VoidCallback onPressed;

  const ParkingSpace({
    Key? key,
    required this.index,
    required this.occupied,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          occupied ? Icons.car_rental : Icons.local_parking,
          size: 50.0,
          color: occupied ? Colors.red : Colors.green,
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(occupied ? 'Ocupado' : 'Libre'),
        ),
      ],
    );
  }
}
