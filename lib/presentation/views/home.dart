import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/presentation/views/pages/categories.dart';
import 'package:stroufitapp/presentation/views/pages/generate_oufit.dart';
import 'package:stroufitapp/presentation/views/pages/my_outfits.dart';

import '../../providers/navigation_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(selectedIndexProvider);

    final pages = [
      const Categories(),
      const MyOutfits(),
      const GenerateOufit(),
    ];

    // Ensure index is within bounds
    final safeIndex = currentIndex.clamp(0, pages.length - 1);

    return Scaffold(
      body: pages[safeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: safeIndex,
        onTap: (index) {
          if (index >= 0 && index < pages.length) {
            ref.read(selectedIndexProvider.notifier).state = index;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Tus outfits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'Generar outfit',
          ),
        ],
      ),
    );
  }
}
