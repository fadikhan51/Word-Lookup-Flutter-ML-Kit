import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'text_detector.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Lookup'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                children: [
                  Image.asset("images/logo.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: Colors.green, width: 1.0),
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Word to search',
                      prefixIcon: Icon(Icons.search, color: Colors.green),
                    ),
                    onChanged: (val) {
                      setState(() {
                        text = val.trim();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 22)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.black.withOpacity(0.1); // Gray color when pressed
                        }
                        return Colors.transparent;
                      }),
                      side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const BorderSide(color: Colors.black, width: 1.5); // Black color when pressed
                        }
                        return const BorderSide(color: Colors.grey, width: 1); // Gray color when not pressed
                      }),
                    ),
                    onPressed: text.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TextRecognizerView(text: text)));
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
