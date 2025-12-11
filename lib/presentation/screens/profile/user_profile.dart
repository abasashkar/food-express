import 'package:ecomerce_bloc_new/logic/bloc/auth/auth_bloc_bloc.dart';
import 'package:ecomerce_bloc_new/presentation/screens/whitslist/whitslist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "User";
    final userEmail = user?.email ?? "No email";
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("Account"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // ✅ PREMIUM PROFILE HEADER WITH GLOW
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [Colors.orange.shade400, Colors.orange.shade600],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 34, color: Colors.orange),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          // ✅ QUICK ACTIONS (ICON BUTTON ROW)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _QuickIcon(icon: Icons.receipt_long, label: "Orders"),
              GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistScreen()),
                    );
                  },
                  child: _QuickIcon(icon: Icons.favorite, label: "Wishlist"),
                ),
              ),
              _QuickIcon(icon: Icons.location_on, label: "Address"),
            ],
          ),

          const SizedBox(height: 24),

          // ✅ MAIN OPTIONS CARD
          _card([
            _tile(Icons.notifications_none, "Notifications"),
            _divider(),
            _tile(Icons.dark_mode_outlined, "Dark Mode"),
            _divider(),
            _tile(Icons.settings_outlined, "Settings"),
          ]),

          const Spacer(),

          // ✅ ATTRACTIVE LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
              listener: (context, state) {
                if (state is AuthLogout) {
                  context.go('/signin');
                }

                if (state is AuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final isLoading = state is AuthLoading;

                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          context.read<AuthBlocBloc>().add(SignOutRequested());
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.red.shade400),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ✅ MODERN CARD
  static Widget _card(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ✅ MODERN TILE
  static Widget _tile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  static Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1),
    );
  }
}

// ✅ QUICK ICON BUTTON (TOP ROW)
class _QuickIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
            ],
          ),
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
