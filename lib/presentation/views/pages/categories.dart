import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database.dart';
import '../../../providers/category_provider.dart';
import '../../widgets/create_category_form.dart';

class Categories extends ConsumerWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsyncValue = ref.watch(categoryListProvider);
    final insertCategory = ref.watch(insertCategoryUseCaseProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Texto superior
            Text(
              'Tus categorías',
              style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 20),

            /// Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: Icon(Icons.search_outlined, color: Theme.of(context).primaryColor),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.09),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
            ),
            ),
        const SizedBox(height: 20),

        /// Lista de categorías o mensaje vacío
        Expanded(
            child: categoriesAsyncValue.when(
              data: (categories) {
                if (categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'vaya, parece que no tienes categorías aún, prueba crear una nueva :)',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: ()  {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CreateCategoryForm(
                                  onSubmit: (name) {
                                Future(() async {
    try{
    await insertCategory.execute(name);
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Categoría "$name" creada exitosamente')),
    );
    ref.invalidate(categoryListProvider);
    }catch(e) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error al crear la categoría: $e')),
    );
    }

    });


                                  },
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Agregar categoría', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: Colors.white,),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CreateCategoryForm(
                                onSubmit: (name) {
                                  Future(() async {
                                    try{
                                      await insertCategory.execute(name);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Categoría "$name" creada exitosamente')),
                                      );
                                      ref.invalidate(categoryListProvider);
                                    }catch(e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error al crear la categoría: $e')),
                                      );
                                    }
                                  });
                                },
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Agregar categoría', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                            SizedBox(width: 8),
                            Icon(Icons.add, color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ListTile(
                            title: Text(category.name),
                            leading: const Icon(Icons.category_outlined),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
        ),
        ]
        ),
      ),
    );
  }
}
