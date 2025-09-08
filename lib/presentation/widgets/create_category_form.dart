import 'package:flutter/material.dart';

import '../../theme/custom_styles.dart';

class CreateCategoryForm extends StatefulWidget {
  final void Function(String name, bool isFavorite) onSubmit;

  const CreateCategoryForm({super.key, required this.onSubmit});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _isFormValid = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_validateForm);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva categoría'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Form(
        key: _formKey,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // <-- valida mientras escribes
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa un nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Marcar como favorito'),
              value: _isFavorite,
              onChanged: (value) {
                setState(() {
                  _isFavorite = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: cancelButtonStyle,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isFormValid
              ? () {
                  widget.onSubmit(_controller.text.trim(), _isFavorite);
                  Navigator.of(context).pop(); // Cierra el popup
                }
              : null, // <-- deshabilita si el form no es válido
          style: acceptButtonStyle,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
