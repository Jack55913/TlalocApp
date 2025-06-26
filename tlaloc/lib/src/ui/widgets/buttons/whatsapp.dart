import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/src/models/constants.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({
    super.key,
    required this.title,
    required this.message,
    required this.title2,
    required this.phoneNumber,
  });

  final String title;
  final String message;
  final String title2;
  final String phoneNumber;

  @override
  State<ContactUs> createState() => _ContactUsListTileState();
}

class _ContactUsListTileState extends State<ContactUs> {
  bool _isLoading = false;

  Future<void> _takeAndSendPhoto() async {
    if (!mounted) return;

    _setLoading(true);

    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (!mounted || image == null) {
        _setLoading(false);
        return;
      }

      await Share.shareXFiles([
        XFile(image.path),
      ], text: '${widget.message}\n\nContacto: ${widget.phoneNumber}');
    } catch (e) {
      _showError('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    if (!mounted) return;
    setState(() => _isLoading = value);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _isLoading ? null : _takeAndSendPhoto,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: CircleAvatar(
          backgroundColor: AppColors.whatsappGreen,
          child:
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                    size: 24,
                  ),
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(fontSize: 18, fontFamily: 'FredokaOne'),
        textAlign: TextAlign.left,
      ),
      subtitle: Text(
        widget.title2,
        style: const TextStyle(fontFamily: 'poppins'),
      ),
    );
  }
}
