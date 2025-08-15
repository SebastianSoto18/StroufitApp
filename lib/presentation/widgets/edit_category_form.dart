import 'package:flutter/material.dart';
import 'package:stroufitapp/theme/custom_styles.dart';

import '../../domain/entities/category.dart';

class EditCategoryForm extends StatefulWidget {
  final CategoryEntity category;
  final Function(String newName) onSubmit;

  const EditCategoryForm({
    super.key,
    required this.category,
    required this.onSubmit,
  });

  @override
  State<EditCategoryForm> createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends State<EditCategoryForm> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.category.name);

    // Escuchar cambios del texto
    _controller.addListener(() {
      final text = _controller.text.trim();
      final changed = text != widget.category.name.trim();
      setState(() {
        _isValid = text.isNotEmpty && changed;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar categoría'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Nuevo nombre',
          ),
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Este campo no puede estar vacío';
            }
            if (value.trim() == widget.category.name.trim()) {
              return 'El nombre es el mismo que el actual';
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
          onPressed: _isValid
              ? () {
            final newName = _controller.text.trim();
            widget.onSubmit(newName);
            Navigator.of(context).pop();
          }
              : null,
          style: acceptButtonStyle,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
