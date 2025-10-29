import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/constants/colors.dart';
import 'package:my_app/providers/auth/auth_provider.dart';
import 'package:my_app/state_management/theme_mode_listener.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final brightness = ref.watch(themeModeProvider);
    final isLoading = ref.watch(authLoadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Profile Picture Section
                  _buildProfileSection(user, brightness, context),

                  const SizedBox(height: 40),

                  // User Details Section
                  _buildUserDetailsSection(user, brightness),

                  const SizedBox(height: 40),

                  // Settings Options
                  _buildSettingsOptions(ref, brightness, context),

                  const SizedBox(height: 40),

                  // Logout Button
                  _buildLogoutButton(ref, context),

                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileSection(
    dynamic user,
    Brightness brightness,
    BuildContext context,
  ) {
    return Column(
      children: [
        // Profile Picture
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
            backgroundImage: user?.profilePictureUrl != null
                ? NetworkImage(user!.profilePictureUrl!)
                : null,
            child: user?.profilePictureUrl == null
                ? Icon(
                    Icons.person,
                    size: 60,
                    color: brightness == Brightness.dark
                        ? Colors.grey[400]
                        : Colors.grey[600],
                  )
                : null,
          ),
        ),

        const SizedBox(height: 16),

        // Username
        Text(
          user?.username ?? 'User',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // Email
        Text(
          user?.email ?? 'No email',
          style: TextStyle(fontSize: 14, color: AppColors.greyText(brightness)),
        ),

        const SizedBox(height: 16),

        // Edit Profile Button
        TextButton.icon(
          onPressed: () {
            // TODO: Navigate to edit profile screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit profile coming soon!')),
            );
          },
          icon: const Icon(Icons.edit, size: 16),
          label: const Text('Edit Profile'),
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildUserDetailsSection(dynamic user, Brightness brightness) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteWidgetBg(brightness),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _buildDetailRow(
            Icons.person_outline,
            'Username',
            user?.username ?? 'N/A',
            brightness,
          ),

          const Divider(height: 24),

          _buildDetailRow(
            Icons.email_outlined,
            'Email',
            user?.email ?? 'N/A',
            brightness,
          ),

          const Divider(height: 24),

          _buildDetailRow(
            Icons.phone_outlined,
            'Phone',
            user?.phoneNumber ?? 'Not set',
            brightness,
          ),

          const Divider(height: 24),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Brightness brightness, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: AppColors.greyText(brightness)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.greyText(brightness),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsOptions(
    WidgetRef ref,
    Brightness brightness,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.whiteWidgetBg(brightness),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change password coming soon!')),
              );
            },
            brightness: brightness,
          ),

          Divider(height: 1, indent: 60),

          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications settings coming soon!'),
                ),
              );
            },
            brightness: brightness,
          ),

          Divider(height: 1, indent: 60),

          _buildSettingsTile(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language settings coming soon!')),
              );
            },
            brightness: brightness,
          ),

          Divider(height: 1, indent: 60),

          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Support coming soon!')),
              );
            },
            brightness: brightness,
          ),

          Divider(height: 1, indent: 60),

          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              _showAboutDialog(context);
            },
            brightness: brightness,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    required Brightness brightness,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 24, color: AppColors.greyText(brightness)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.greyText(brightness),
              ),
            )
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.greyText(brightness),
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            // Show confirmation dialog
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );

            if (shouldLogout == true) {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Successfully logged out'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Solar Energy Management System',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            const Text(
              'Monitor your solar panels, track energy consumption, and get weather forecasts all in one app.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
