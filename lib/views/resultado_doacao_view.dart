import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/hexagon_painter.dart';
import 'regiao_view.dart';

class Hemocentro {
  final String nome;
  final String endereco;
  final String horario;
  final String telefone;
  final String mapsUrl;
  final String imagemUrl;

  const Hemocentro({
    required this.nome,
    required this.endereco,
    required this.horario,
    required this.telefone,
    required this.mapsUrl,
    required this.imagemUrl,
  });
}

const Map<String, List<Hemocentro>> hemocentrosPorCidade = {
  'Salvador': [
    Hemocentro(
      nome: 'Hemocentro Coordenador – Salvador (HGE)',
      endereco: 'Ladeira do Hospital Geral, s/n – Brotas\nSalvador – BA',
      horario: 'Seg–Sex: 7h30 às 18h30 | Sáb: 7h30 às 16h30',
      telefone: '(71) 3194-7864',
      mapsUrl:
          'https://maps.google.com/?q=Hemocentro+Coordenador+HEMOBA+Salvador+BA',
      imagemUrl: 'assets/images/salvador_hge.jpg',
    ),
    Hemocentro(
      nome: 'UC Hemoba – Hospital Ana Nery',
      endereco: 'Rua Saldanha Marinho, s/n – Caixa D\'Água\nSalvador – BA',
      horario: 'Ter–Sex: 7h30 às 12h',
      telefone: '(71) 3117-2059',
      mapsUrl:
          'https://maps.google.com/?q=Hospital+Ana+Nery+Salvador+BA',
      imagemUrl: 'assets/images/salvador_ana_nery.jpg',
    ),
  ],
  'Feira de Santana': [
    Hemocentro(
      nome: 'UCT Hemoba – Feira de Santana',
      endereco:
          'Av. Pres. Dutra, s/n – Centro\nFeira de Santana – BA',
      horario: 'Seg–Sex: 8h às 12h e 13h às 17h',
      telefone: '(75) 3614-1556',
      mapsUrl:
          'https://maps.google.com/?q=HEMOBA+Feira+de+Santana+Avenida+Presidente+Dutra',
      imagemUrl: 'assets/images/feira_de_santana.jpg',
    ),
  ],
};

class ResultadoDoacaoPage extends StatelessWidget {
  final bool isApto;
  final String regiao;

  const ResultadoDoacaoPage({
    super.key,
    required this.isApto,
    required this.regiao,
  });

  Future<void> abrirUrl(String url) async {

  final uri = Uri.parse(url);

  await launchUrl(uri);

}

  Future<void> ligar(String telefone) async {
    final numero = telefone.replaceAll(RegExp(r'[^\d]'), '');

    final uri = Uri.parse('tel:+55$numero');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lista = hemocentrosPorCidade[regiao] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE13D3D),
        foregroundColor: Colors.white,
        title: Text(regiao),
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  Icon(
                    isApto ? Icons.favorite : Icons.cancel_outlined,
                    color: const Color(0xFFE13D3D),
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isApto
                        ? 'Você está apto\npara doar sangue!'
                        : 'No momento você não\nestá apto para doação.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE13D3D),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    isApto
                        ? 'Parabéns! Sua triagem preliminar indica que você pode ser um doador. Dirija-se a um dos hemocentros abaixo para a avaliação final.'
                        : 'Com base nas suas respostas, identificamos um critério que impede a doação no momento. Consulte o hemocentro para mais informações.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  if (isApto && lista.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_hospital,
                          color: Color(0xFFE13D3D),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lista.length == 1
                              ? 'Hemocentro disponível:'
                              : 'Hemocentros disponíveis:',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE13D3D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ...lista.map(
                      (hemo) => HemocentroCard(
                        hemo: hemo,
                        onMaps: () => abrirUrl(hemo.mapsUrl),
                        onLigar: () => ligar(hemo.telefone),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegiaoView(),
                        ),
                        (_) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE13D3D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Voltar ao Início',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HemocentroCard extends StatelessWidget {
  final Hemocentro hemo;
  final VoidCallback onMaps;
  final VoidCallback onLigar;

  const HemocentroCard({
    super.key,
    required this.hemo,
    required this.onMaps,
    required this.onLigar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE13D3D).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            hemo.imagemUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 160,
                color: const Color(0xFFE13D3D).withOpacity(0.1),
                child: const Center(
                  child: Icon(
                    Icons.local_hospital,
                    color: Color(0xFFE13D3D),
                    size: 50,
                  ),
                ),
              );
            },
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFE13D3D),
            child: Text(
              hemo.nome,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                infoRow(Icons.location_on_outlined, hemo.endereco),
                const SizedBox(height: 10),
                infoRow(Icons.access_time, hemo.horario),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onLigar,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        color: Color(0xFFE13D3D),
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        hemo.telefone,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE13D3D),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onMaps,
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Ver no Google Maps'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE13D3D),
                      side: const BorderSide(
                        color: Color(0xFFE13D3D),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRow(IconData icon, String texto) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black45, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
