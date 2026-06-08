import 'package:flutter/material.dart';

import '../viewmodels/hemocentro_viewmodel.dart';
import 'formulario_view.dart';
import 'login_view.dart';

class MenuView extends StatefulWidget {
  final String regiao;

  const MenuView({
    super.key,
    required this.regiao,
  });

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late String cidadeAtual;

  final List<String> cidades = [
    'Salvador',
    'Feira de Santana',
  ];

  final List<String> bloodTypes = [
    'O-',
    'O+',
    'A-',
    'A+',
    'AB-',
    'AB+',
    'B-',
    'B+',
  ];

  final vm = HemocentroViewModel();

  late Future<Map<String, int>> estoqueFuture;

  @override
  void initState() {
    super.initState();
    cidadeAtual = widget.regiao;
    carregarEstoque();
  }

  void carregarEstoque() {
    estoqueFuture = vm.buscarEstoqueRegional(cidadeAtual);
  }

  void mudarCidade() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecionar cidade',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE13D3D),
              ),
            ),
            const SizedBox(height: 16),
            ...cidades.map(
              (cidade) => ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: cidade == cidadeAtual
                      ? const Color(0xFFE13D3D)
                      : Colors.grey,
                ),
                title: Text(
                  cidade,
                  style: TextStyle(
                    fontWeight: cidade == cidadeAtual
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: cidade == cidadeAtual
                        ? const Color(0xFFE13D3D)
                        : Colors.black87,
                  ),
                ),
                trailing: cidade == cidadeAtual
                    ? const Icon(
                        Icons.check,
                        color: Color(0xFFE13D3D),
                      )
                    : null,
                onTap: () {
                  setState(() {
                    cidadeAtual = cidade;
                    carregarEstoque();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color corEstoque(int bolsas) {
    if (bolsas > 500) return const Color(0xFFE13D3D);
    if (bolsas >= 201) return const Color(0xFF8B0000);
    return Colors.black;
  }

  String labelEstoque(int bolsas) {
    if (bolsas > 500) return 'Boa Quantidade';
    if (bolsas >= 201) return 'Média Quantidade';
    return 'Urgente';
  }

  void confirmarLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sair da conta'),
        content: const Text('Deseja realmente sair?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginPage(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE13D3D),
              foregroundColor: Colors.white,
            ),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE13D3D),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'DOA.ME',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                carregarEstoque();
              });
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: confirmarLogout,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, int>>(
        future: estoqueFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar estoque:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final estoque = snapshot.data ?? {};

          return Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: mudarCidade,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE13D3D).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFE13D3D).withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Color(0xFFE13D3D),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        cidadeAtual,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE13D3D),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.edit,
                        color: Color(0xFFE13D3D),
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Estoque de Sangue\nda sua região:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.9,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                  ),
                  itemCount: bloodTypes.length,
                  itemBuilder: (context, index) {
                    final tipo = bloodTypes[index];
                    final bolsas = estoque[tipo] ?? 0;
                    final cor = corEstoque(bolsas);
                    final label = labelEstoque(bolsas);

                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: cor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tipo,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$bolsas bolsas',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 40,
                  top: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FormularioDoacaoPage(
                          regiao: cidadeAtual,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE13D3D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 18,
                    ),
                  ),
                  child: const Text(
                    'Quero Doar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}