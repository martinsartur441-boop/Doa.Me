import 'package:flutter/material.dart';

import '../widgets/hexagon_painter.dart';
import '../widgets/input_decoration.dart';

import 'triagem_page.dart';

class FormularioDoacaoPage extends StatefulWidget {
  final String regiao;

  const FormularioDoacaoPage({
    super.key,
    required this.regiao,
  });

  @override
  State<FormularioDoacaoPage> createState() => _FormularioDoacaoPageState();
}

class _FormularioDoacaoPageState extends State<FormularioDoacaoPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final phoneController = TextEditingController();

  void continuar() {
    final peso = double.tryParse(weightController.text);
    final idade = int.tryParse(ageController.text);

    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        peso == null ||
        idade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos corretamente.'),
          backgroundColor: Color(0xFFE13D3D),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TriagemPage(
          regiao: widget.regiao,
          idade: idade,
          peso: peso,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    weightController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE13D3D),
        foregroundColor: Colors.white,
        title: Text(widget.regiao),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: HexagonPainter(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Formulário de\nDoação de Sangue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE13D3D),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    decoration: inputDecoration('Nome Completo'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('Idade (Ex: 25)'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration('Peso em kg (Ex: 70)'),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration('N° Telefone'),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: continuar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE13D3D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Continuar para Triagem',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}