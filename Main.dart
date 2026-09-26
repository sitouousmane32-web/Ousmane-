import 'package:flutter/material.dart';

void main() {
  runApp(const NigerAideApp());
}

class NigerAideApp extends StatelessWidget {
  const NigerAideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIGER AIDE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVip = false;
  final TextEditingController _transactionController = TextEditingController();

  void _showVipDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kunnawa da Biyan VIP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tura kudin VIP zuwa lambar Airtel Money Niger:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const SelectableText(
              '+227 90 00 00 00',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _transactionController,
              decoration: const InputDecoration(
                labelText: 'Saka Code / Shaida na Airtel Money',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Soke'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              if (_transactionController.text.isNotEmpty) {
                setState(() {
                  isVip = true;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('An aika saƙon tabbatarwa! VIP dinka yana nan ta kunna.'),
                  ),
                );
              }
            },
            child: const Text('Tabbatar da Biyaya', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('NIGER AIDE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Chip(
              label: Text(
                isVip ? 'VIP' : 'KYAUTA',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: isVip ? Colors.orange : Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Welcome
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.health_and_safety, size: 60, color: Colors.green),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Barka da zuwa NIGER AIDE',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Manhajarku ta tallafi da ayyukan gida Niger.',
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Vip Activation Section
            if (!isVip)
              Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.orange),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Buɗe Damar VIP!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Samu cikakken tallafi da duk ayyukan NIGER AIDE ta hanyar biya da Airtel Money.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: _showVipDialog,
                        icon: const Icon(Icons.star, color: Colors.white),
                        label: const Text('Kunna VIP Yanzu', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),
            const Text(
              'Ayyuka da Tallafi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // List of Services
            _buildServiceItem(
              icon: Icons.support_agent,
              title: 'Cibiyar Tallafi',
              subtitle: 'Nemi taimako ko shawara cikin sauƙi.',
            ),
            _buildServiceItem(
              icon: Icons.medical_services,
              title: 'Ayyukan Kula da Lafiya',
              subtitle: 'Hanyoyin samun agaji da sakonni na gaggawa.',
            ),
            _buildServiceItem(
              icon: Icons.verified_user,
              title: isVip ? 'Ayyukan VIP na Musamman' : 'Ayyukan VIP (An Rufe)',
              subtitle: isVip ? 'Kuna amfana da cikakken tsarin VIP.' : 'Biya VIP don buɗe wannan sashe.',
              isLocked: !isVip,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLocked = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(icon, color: isLocked ? Colors.grey : Colors.green, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: isLocked
            ? const Icon(Icons.lock, color: Colors.red)
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (isLocked) {
            _showVipDialog();
          }
        },
      ),
    );
  }
}
