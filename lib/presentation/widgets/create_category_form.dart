import 'package:flutter/material.dart';

import '../../theme/custom_styles.dart';

class CreateCategoryForm extends StatefulWidget {
  final void Function(String name) onSubmit;

  const CreateCategoryForm({super.key, required this.onSubmit});

  @override
  State<CreateCategoryForm> createState() => _CreateCategoryFormState();
}

class _CreateCategoryFormState extends State<CreateCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva categoría'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(labelText: 'Nombre'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor ingresa un nombre';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: cancelButtonStyle,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(_controller.text.trim());
              Navigator.of(context).pop(); // Cierra el popup
            }
          },
          style: acceptButtonStyle,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
