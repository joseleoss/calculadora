import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _num1 = 0;
  double _num2 = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _operator = "";
        _num1 = 0;
        _num2 = 0;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _num1 = double.tryParse(_currentInput) ?? 0;
        _operator = value;
        _currentInput = "";
      } else if (value == "=") {
        _num2 = double.tryParse(_currentInput) ?? 0;
        if (_operator == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operator == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operator == "*") {
          _output = (_num1 * _num2).toString();
        } else if (_operator == "/") {
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "Erro";
        }
        _currentInput = "";
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: ["7", "8", "9", "/"]
                    .map((value) => _buildButton(value))
                    .toList(),
              ),
              Row(
                children: ["4", "5", "6", "*"]
                    .map((value) => _buildButton(value))
                    .toList(),
              ),
              Row(
                children: ["1", "2", "3", "-"]
                    .map((value) => _buildButton(value))
                    .toList(),
              ),
              Row(
                children: ["C", "0", "=", "+"]
                    .map((value) => _buildButton(value))
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
