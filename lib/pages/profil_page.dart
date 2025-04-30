import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/auth/login_screen.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  File? _imageFile;
  String namaPengguna = 'Ardi Alfatih';
  final TextEditingController _nameController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  void _ubahNama() {
    _nameController.text = namaPengguna;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ubah Nama'),
        content: TextField(controller: _nameController),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => namaPengguna = _nameController.text);
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const namaToko = 'Gudangku Mart';
    const role = 'Admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
                backgroundColor: Colors.indigo.shade300,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Ketuk untuk mengubah foto',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nama Toko', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                const Text(namaToko,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Nama Pengguna', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(namaPengguna, style: const TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: _ubahNama,
                      icon: const Icon(Icons.edit, size: 20),
                      tooltip: 'Ubah Nama',
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Role', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                const Text(role, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Keluar', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
