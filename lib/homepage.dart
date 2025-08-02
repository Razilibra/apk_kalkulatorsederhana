import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _output = "0"; // Tampilan output di layar kalkulator
  String _input = ""; // Teks yang sedang dimasukkan pengguna
  double _num1 = 0; // Angka pertama
  double _num2 = 0; // Angka kedua
  String _operand = ""; // Operator yang dipilih

  // Fungsi untuk menangani penekanan tombol
  void _onButtonPressed(String buttonText) {
    setState(() {
      // Tombol 'C' untuk Clear
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      }
      // Tombol operator (+, -, *, /)
      else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        if (_input.isNotEmpty) {
          _num1 = double.parse(_input);
          _operand = buttonText;
          _input = ""; // Reset input untuk angka kedua
        }
      }
      // Tombol '=' untuk hasil
      else if (buttonText == "=") {
        if (_operand.isNotEmpty && _input.isNotEmpty) {
          _num2 = double.parse(_input);

          if (_operand == "+") {
            _num1 = _num1 + _num2;
          }
          if (_operand == "-") {
            _num1 = _num1 - _num2;
          }
          if (_operand == "×") {
            _num1 = _num1 * _num2;
          }
          if (_operand == "÷") {
            _num1 = _num1 / _num2;
          }
          _output = _num1.toString();
          _input = _num1.toString();
          _operand = "";
        }
      }
      // Tombol '.' untuk desimal
      else if (buttonText == ".") {
        if (!_input.contains(".")) {
          _input += buttonText;
        }
      }
      // Tombol Backspace
      else if (buttonText == "←") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          if (_input.isEmpty) {
            _input = "0";
          }
        }
        _output = _input;
      }
      // Tombol angka lainnya
      else {
        if (_input == "0" || _input.isEmpty) {
          _input = buttonText;
        } else {
          _input += buttonText;
        }
        _output = _input;
      }

      // Memastikan output tidak memiliki .0 di akhir jika bilangan bulat
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  // Widget untuk membuat tombol kalkulator
  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Sederhana'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey.shade800,
        child: Column(
          children: [
            // Area tampilan hasil
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Text(
                  _output,
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Tombol-tombol kalkulator
            Column(
              children: [
                Row(
                  children: [
                    _buildButton("C", Colors.red.shade700),
                    _buildButton("÷", Colors.orange.shade800),
                    _buildButton("×", Colors.orange.shade800),
                    _buildButton("←", Colors.blueGrey.shade600),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7", Colors.blueGrey.shade600),
                    _buildButton("8", Colors.blueGrey.shade600),
                    _buildButton("9", Colors.blueGrey.shade600),
                    _buildButton("-", Colors.orange.shade800),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4", Colors.blueGrey.shade600),
                    _buildButton("5", Colors.blueGrey.shade600),
                    _buildButton("6", Colors.blueGrey.shade600),
                    _buildButton("+", Colors.orange.shade800),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1", Colors.blueGrey.shade600),
                    _buildButton("2", Colors.blueGrey.shade600),
                    _buildButton("3", Colors.blueGrey.shade600),
                    _buildButton(".", Colors.blueGrey.shade600),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("0", Colors.blueGrey.shade600),
                    _buildButton("=", Colors.indigo.shade800),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
