import 'package:flutter/material.dart';

import '../widgets/hexagon_painter.dart';
import 'resultado_doacao_view.dart';

class TriagemPergunta {
  final String pergunta;
  final String? info;
  final bool simInabilita;

  const TriagemPergunta({
    required this.pergunta,
    this.info,
    required this.simInabilita,
  });
}

class TriagemMetadeMotivacaoPage extends StatelessWidget {
  final VoidCallback onContinuar;

  const TriagemMetadeMotivacaoPage({
    super.key,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: HexagonPainter(),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFE13D3D),
                      size: 80,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Você já está na\nmetade! 🎉',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE13D3D),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Cada resposta importa. Continue, você está quase lá!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 36),
                    ElevatedButton(
                      onPressed: onContinuar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE13D3D),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Continuar a triagem'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TriagemPage extends StatefulWidget {
  final String regiao;
  final int idade;
  final double peso;

  const TriagemPage({
    super.key,
    required this.regiao,
    required this.idade,
    required this.peso,
  });

  @override
  State<TriagemPage> createState() => _TriagemPageState();
}

class _TriagemPageState extends State<TriagemPage> {
  int paginaAtual = 0;
  bool mostrandoMetade = false;
  bool processando = false;

  final List<TriagemPergunta> perguntas = const [
    TriagemPergunta(
      pergunta: 'Você dormiu pelo menos 6 horas nas últimas 24 horas?',
      simInabilita: false,
    ),
    TriagemPergunta(
      pergunta: 'Você está se sentindo bem e saudável hoje?',
      info: 'Sem febre, gripe, resfriado ou mal-estar.',
      simInabilita: false,
    ),
    TriagemPergunta(
      pergunta: 'Você tomou algum medicamento nas últimas 72 horas?',
      info: 'Inclui antibióticos, anti-inflamatórios, aspirina etc.',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você fez alguma cirurgia ou procedimento odontológico nos últimos 30 dias?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você recebeu alguma vacina nos últimos 30 dias?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você teve febre ou infecção nas últimas 2 semanas?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você esteve em área com risco de malária nos últimos 12 meses?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você teve alguma tatuagem ou piercing nos últimos 12 meses?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você fez endoscopia, colonoscopia ou procedimento cirúrgico nos últimos 6 meses?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você recebeu transfusão de sangue nos últimos 12 meses?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você teve hepatite após os 10 anos de idade?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você tem ou já teve alguma doença cardíaca, pulmonar ou renal crônica?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você tem diabetes tratado com insulina?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você já teve câncer?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você fez uso de drogas ilícitas injetáveis em algum momento da vida?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você consumiu bebida alcoólica nas últimas 12 horas?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você está grávida ou amamentando?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você teve sintomas de gripe ou resfriado nos últimos 7 dias?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você realizou alguma viagem internacional nos últimos 30 dias?',
      simInabilita: true,
    ),
    TriagemPergunta(
      pergunta: 'Você está em jejum há mais de 4 horas?',
      simInabilita: true,
    ),
  ];

  late List<bool?> respostas;

  @override
  void initState() {
    super.initState();
    respostas = List<bool?>.filled(perguntas.length, null);
  }

  bool get ultimaPagina => paginaAtual == perguntas.length - 1;

  void responder(bool valor) {
    if (processando) return;

    setState(() {
      respostas[paginaAtual] = valor;
      processando = true;
    });

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) return;

      if (ultimaPagina) {
        calcularResultado();
        return;
      }

      if (paginaAtual == 9 && !mostrandoMetade) {
        setState(() {
          mostrandoMetade = true;
          processando = false;
        });
        return;
      }

      setState(() {
        paginaAtual++;
        processando = false;
      });
    });
  }

  void continuarAposMotivacao() {
    setState(() {
      mostrandoMetade = false;
      paginaAtual++;
    });
  }

  void voltar() {
    if (paginaAtual > 0) {
      setState(() {
        paginaAtual--;
      });
    }
  }

  void calcularResultado() {
    bool apto = widget.peso >= 50 && widget.idade >= 16 && widget.idade <= 69;

    if (apto) {
      for (int i = 0; i < perguntas.length; i++) {
        final pergunta = perguntas[i];
        final resposta = respostas[i];

        if (pergunta.simInabilita && resposta == true) {
          apto = false;
          break;
        }

        if (!pergunta.simInabilita && resposta == false) {
          apto = false;
          break;
        }
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultadoDoacaoPage(
          isApto: apto,
          regiao: widget.regiao,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mostrandoMetade) {
      return TriagemMetadeMotivacaoPage(
        onContinuar: continuarAposMotivacao,
      );
    }

    final pergunta = perguntas[paginaAtual];
    final progresso = (paginaAtual + 1) / perguntas.length;

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Triagem de Aptidão',
                    style: TextStyle(
                      color: Color(0xFFE13D3D),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progresso,
                          minHeight: 8,
                          backgroundColor: Colors.white,
                          color: const Color(0xFFE13D3D),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${paginaAtual + 1}/${perguntas.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE13D3D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pergunta.pergunta,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        if (pergunta.info != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            pergunta.info!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF5A1A1A),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: buildOpcaoBtn(
                          label: 'Sim',
                          selecionado: respostas[paginaAtual] == true,
                          onTap: () => responder(true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: buildOpcaoBtn(
                          label: 'Não',
                          selecionado: respostas[paginaAtual] == false,
                          onTap: () => responder(false),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (paginaAtual > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: OutlinedButton.icon(
                        onPressed: voltar,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Anterior'),
                      ),
                    )
                  else
                    const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpcaoBtn({
    required String label,
    required bool selecionado,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selecionado ? const Color(0xFFE13D3D) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selecionado ? const Color(0xFFE13D3D) : Colors.black38,
            width: selecionado ? 2 : 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selecionado ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}