import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final String title;
  final String buttonLabel;
  final bool showNameField;
  final bool isLoading;

  final void Function({
    required String email,
    required String password,
    String? name,
  })
  onSubmit;

  final VoidCallback onNavigate;

  const AuthForm({
    super.key,
    required this.title,
    required this.buttonLabel,
    required this.onSubmit,
    required this.onNavigate,
    this.showNameField = false,
    this.isLoading = false,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 40),

        Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.showNameField) ...[
                _buildField(
                  controller: name,
                  label: "Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 26),
              ],

              _buildField(controller: email, label: "Email", icon: Icons.email),
              const SizedBox(height: 26),

              _buildField(
                controller: password,
                label: "Password",
                icon: Icons.lock,
                obscure: true,
              ),

              const SizedBox(height: 26),

              _buildSubmitButton(),

              const SizedBox(height: 16),

              Text(
                widget.showNameField
                    ? "Already have an account?"
                    : "Don't have an account?",
                style: TextStyle(color: Colors.grey.shade400),
              ),

              TextButton(
                onPressed: widget.onNavigate,
                child: Text(
                  widget.showNameField ? "Sign In" : "Sign Up",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade900,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => value!.isEmpty ? "$label is required" : null,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: widget.isLoading
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    email: email.text.trim(),
                    password: password.text.trim(),
                    name: widget.showNameField ? name.text.trim() : null,
                  );
                }
              },
        child: widget.isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: Colors.white,
                ),
              )
            : Text(
                widget.buttonLabel,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
