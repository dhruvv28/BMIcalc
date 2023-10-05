import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calc/BMIScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? bmi;
  Color? color;

  void _computeBmi() {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty) {
      setState(() {
        bmi = null;
        color = null;
      });
      return;
    }

    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight == null || height == null) {
      setState(() {
        bmi = null;
        color = null;
      });
      return;
    }

    final bmiValue = weight / ((height / 100) * (height / 100));

    setState(() {
      bmi = bmiValue;
      if (bmiValue < 17.5) {
        color = Colors.red;
      } else if (bmiValue >= 17.5 && bmiValue < 25) {
        color = Colors.black;
      } else if (bmiValue >= 25 && bmiValue < 30) {
        color = Colors.orange;
      } else {
        color = Colors.red;
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIScreen(bmiValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 103, 181, 232),
      appBar: AppBar(
        title: Text(
          "BMI",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 220,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 12, 139, 198),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Weight (in kg)",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    color: Colors.white.withOpacity(0.8),
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter Weight",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 220,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 12, 139, 198),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Height (in cm)",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    color: Colors.white.withOpacity(0.8),
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Enter Height",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _computeBmi,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  "Compute",
                ),
              ),
            ),
            SizedBox(
                height: 20
            ),

          ],
        ),
      ),
    );
  }
}