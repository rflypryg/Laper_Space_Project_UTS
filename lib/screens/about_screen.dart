import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'), 
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              'Get in touch with us for reservations, inquiries, or feedback',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),

            _buildInfoSection(context),
            const SizedBox(height: 30),

            _buildOperatingHours(),
            const SizedBox(height: 30),

            _buildSendMessageForm(context),
            const SizedBox(height: 30),

            _buildFollowUs(),
            const SizedBox(height: 30),

            _buildFindUs(context),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Icon(Icons.location_on, color: Colors.orange.shade700, size: 30),
            title: const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('123 Culinary Street\nDowntown District\nNew York, NY 10001'),
            isThreeLine: true,
          ),
        ),
        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(
              child: _buildSmallInfoCard(
                icon: Icons.phone,
                title: 'Phone',
                value: '(021) 1234 5678',
                onTap: () => launchUrl(Uri.parse('tel:+622112345678')),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildSmallInfoCard(
                icon: Icons.email,
                title: 'Email',
                value: 'halo@laperspace.com',
                onTap: () => launchUrl(Uri.parse('mailto:halo@laperspace.com')),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallInfoCard({
    required IconData icon, 
    required String title, 
    required String value, 
    VoidCallback? onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.orange.shade700, size: 24),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperatingHours() {
    final bool isClosedToday = DateTime.now().weekday == DateTime.tuesday; 

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, color: Colors.orange.shade700, size: 24),
                const SizedBox(width: 10),
                const Text('Operating Hours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 20),
            
            _buildHourRow('Monday - Sunday', '10.00 - 22.00 WIB', isClosed: false),
          ],
        ),
      ),
    );
  }

  Widget _buildHourRow(String day, String hours, {required bool isClosed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(color: Colors.black87)),
          Text(
            hours,
            style: TextStyle(
              color: isClosed ? Colors.red : Colors.green.shade700,
              fontWeight: isClosed ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendMessageForm(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Send us a Message', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildFormTextField('Name', required: true)),
                      const SizedBox(width: 15),
                      Expanded(child: _buildFormTextField('Email', required: true, keyboardType: TextInputType.emailAddress)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildFormTextField('Subject', hint: 'What can we help you with?'),
                  const SizedBox(height: 15),
                  _buildFormTextField(
                    'Message', 
                    hint: 'Tell us about your inquiry, feedback, or special requests...', 
                    maxLines: 4,
                    required: true,
                  ),
                  const SizedBox(height: 20),
                  
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pesan terkirim. Kami akan menghubungi Anda segera!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Send Message', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormTextField(String label, {String? hint, TextInputType keyboardType = TextInputType.text, int maxLines = 1, bool required = false}) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return '$label wajib diisi';
        }
        return null;
      },
    );
  }

  Widget _buildFollowUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Follow Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10.0, 
                  runSpacing: 10.0, 
                  children: [
                    _buildSocialButton('Instagram', Icons.camera_alt, 'https://instagram.com/laparspace'),
                    _buildSocialButton('Facebook', Icons.facebook, 'https://facebook.com/laparspace'),
                    _buildSocialButton('Twitter', Icons.ac_unit, 'https://twitter.com/laparspace', icon: Icons.person), 
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Stay updated with our latest dishes, events, and special offers',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String label, IconData defaultIcon, String url, {IconData? icon}) {
    return OutlinedButton.icon(
      icon: Icon(icon ?? defaultIcon, size: 18),
      label: Text(label),
      onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }
  Widget _buildFindUs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Find Us', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [ 
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined, size: 40, color: Colors.grey),
                        SizedBox(height: 5),
                        Text('Interactive Map (123 Culinary Street)', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Jl. Jendral Sudirman No. 123, Jakarta Pusat',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
