import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:stroufitapp/domain/helpers/category_helpers.dart';
import 'package:stroufitapp/domain/use_cases/categories/createCategory.dart';

import '../../../domain/entities/category.dart';
import '../../../providers/category_provider.dart';
import '../../../theme/theme.dart';
import '../../widgets/category_bottom_sheet.dart';
import '../../widgets/create_category_form.dart';
import '../../widgets/edit_category_form.dart';
import '../../widgets/add_garment_form.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCategories = ref.watch(filteredCategoryListProvider);
    final insertCategory = ref.watch(insertCategoryUseCaseProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Texto superior
            Text('Tus categorías',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),

            /// Barra de búsqueda
            TextField(
              onChanged: (value) =>
                  ref.read(categorySearchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: Icon(Icons.search_outlined,
                    color: Theme.of(context).primaryColor),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.09),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Lista de categorías o mensaje vacío
            Expanded(
              child: Column(
                children: [
                  /// Botón fijo (sin animación)
                  if (filteredCategories.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => _showCreateCategoryDialog(
                            context, ref, insertCategory),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Agregar categoría',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins')),
                            SizedBox(width: 8),
                            Icon(Icons.add, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  /// Contenido que sí se anima
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 650),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: 0.0,
                          child: child,
                        ),
                      ),
                      child: filteredCategories.isEmpty
                          ? Center(
                              key: const ValueKey('empty'),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'vaya, parece que no tienes categorías aún, prueba crear una nueva :)',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => _showCreateCategoryDialog(
                                        context, ref, insertCategory),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text('Agregar categoría',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins')),
                                        SizedBox(width: 8),
                                        Icon(Icons.add, color: Colors.white),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : ListView.separated(
                              key: ValueKey(filteredCategories.length),
                              itemCount: filteredCategories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final category = filteredCategories[index];
                                return InkWell(
                                  onTap: () => _openCategoryBottomSheet(
                                      context, category), // ← Aquí va la línea
                                  borderRadius: BorderRadius.circular(12),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 2,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              Text(category.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ],
                                          ),
                                          PopupMenuButton<String>(
                                            color: Colors.white,
                                            icon: const Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                _showEditCategoryDialog(
                                                    context, ref, category);
                                              } else if (value == 'delete') {
                                                // tu diálogo de eliminar
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit,
                                                        color: Colors.blue),
                                                    SizedBox(width: 8),
                                                    Text('Editar',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins')),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete,
                                                        color: Colors.red),
                                                    SizedBox(width: 8),
                                                    Text('Eliminar',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins')),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCategoryDialog(
      BuildContext context, WidgetRef ref, CreateCategory insertCategory) {
    showDialog(
      context: context,
      builder: (context) {
        return CreateCategoryForm(
          onSubmit: (name) async {
            try {
              print('UI: Starting category creation for: $name');

              await insertCategory.execute(name);

              print(
                  'UI: Category created successfully, showing success message');

              Flushbar(
                message: 'Categoría "$name" creada exitosamente',
                icon: const Icon(Icons.check_circle, color: Colors.white),
                duration: const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: AppTheme.completeNotification,
                borderRadius: BorderRadius.circular(8),
                margin: const EdgeInsets.all(12),
                animationDuration: const Duration(milliseconds: 400),
                messageColor: Colors.white,
              ).show(context);

              print('UI: Invalidating category list provider');
              ref.invalidate(categoryListProvider);
            } catch (e, stackTrace) {
              print('UI: Error creating category: $e');
              print('UI: Stack trace: $stackTrace');

              Flushbar(
                message:
                    'Ocurrió un error al crear la categoría: ${e.toString()}',
                icon: const Icon(Icons.error_outline, color: Colors.white),
                duration: const Duration(seconds: 4),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: AppTheme.errorNotification,
                borderRadius: BorderRadius.circular(8),
                margin: const EdgeInsets.all(12),
                animationDuration: const Duration(milliseconds: 400),
                messageColor: Colors.white,
              ).show(context);
            }
          },
        );
      },
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, WidgetRef ref, CategoryEntity category) {
    final updateCategory = ref.read(updateCategoryUseCaseProvider);

    showDialog(
      context: context,
      builder: (context) {
        return EditCategoryForm(
          category: category,
          onSubmit: (newName) async {
            try {
              final updated =
                  category.copyWith(name: newName); // Asume que tienes copyWith
              await updateCategory.execute(updated);
              ref.invalidate(categoryListProvider);

              Flushbar(
                message: 'Categoría actualizada exitosamente',
                icon: const Icon(Icons.check_circle, color: Colors.white),
                duration: const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: AppTheme.completeNotification,
                borderRadius: BorderRadius.circular(8),
                margin: const EdgeInsets.all(12),
                animationDuration: const Duration(milliseconds: 400),
                messageColor: Colors.white,
              ).show(context);
            } catch (_) {
              Flushbar(
                message: 'Error al actualizar',
                icon: const Icon(Icons.error_outline, color: Colors.white),
                duration: const Duration(seconds: 4),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: AppTheme.errorNotification,
                borderRadius: BorderRadius.circular(8),
                margin: const EdgeInsets.all(12),
                animationDuration: const Duration(milliseconds: 400),
                messageColor: Colors.white,
              ).show(context);
            }
          },
        );
      },
    );
  }

  void _openCategoryBottomSheet(BuildContext context, CategoryEntity category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CategoryBottomSheet(
        category: category,
        onImageSelected: (String imagePath) {
          // Manejar la selección de imagen desde el contexto válido del modal
          _showAddGarmentForm(context, imagePath, category.categoryId);
        },
      ),
    );
  }

  void _showAddGarmentForm(BuildContext context, String imagePath, int categoryId) {
    // Mostrar AddGarmentForm usando el contexto válido del modal
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddGarmentForm(
          categoryId: categoryId,
          imagePath: imagePath,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        opaque: false,
      ),
    );
  }
}
