import 'package:flutter/material.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person_add_alt_1, size: 64, color: Colors.indigo),
                  const SizedBox(height: 12),
                  const Text(
                    'Daftar Akun',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(controller: nameController, label: 'Nama Lengkap'),
                  const SizedBox(height: 16),
                  CustomTextField(controller: emailController, label: 'Email'),
                  const SizedBox(height: 16),
                  CustomTextField(controller: passwordController, label: 'Password', isObscure: true),
                  const SizedBox(height: 16),
                  CustomTextField(controller: confirmController, label: 'Konfirmasi Password', isObscure: true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Panggil AuthService register
                        Navigator.pop(context); // Balik ke login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Daftar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Sudah punya akun? Login'),
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
