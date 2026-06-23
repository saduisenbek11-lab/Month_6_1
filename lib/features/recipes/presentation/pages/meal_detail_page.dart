import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/meal_model.dart';
import '../bloc/meal_bloc.dart';
import '../bloc/meal_event.dart';
import '../bloc/meal_state.dart';

class MealDetailPage extends StatefulWidget {
  final String mealId;
  const MealDetailPage({super.key, required this.mealId});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  late final Future<MealDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = context.read<MealBloc>().repository.getMealById(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<MealDetail>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Ошибка загрузки рецепта'));
          }

          final mealDetail = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.45,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(mealDetail.thumbnail, fit: BoxFit.cover),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CircleButton(
                                icon: Icons.arrow_back,
                                onTap: () => Navigator.pop(context),
                              ),
                              BlocBuilder<MealBloc, MealState>(
                                builder: (context, state) {
                                  // Проверяем статус избранного из состояния BLoC
                                  final isFavorite = state.meals.any((m) => m.id == widget.mealId && m.isFavorite);
                                  return _CircleButton(
                                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                                    iconColor: const Color(0xFFFF7D31),
                                    onTap: () {
                                      context.read<MealBloc>().add(ToggleMealFavoriteEvent(widget.mealId));
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  transform: Matrix4.translationValues(0, -40, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        mealDetail.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1F1F1F),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _InfoItem(icon: Icons.access_time, label: '30 мин.'),
                          const _InfoItem(icon: Icons.bar_chart, label: 'Средняя'),
                          const _InfoItem(icon: Icons.person_outline, label: '2 порции'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const _SectionHeader(icon: Icons.restaurant_menu, title: 'Ингредиенты'),
                      const SizedBox(height: 15),
                      _buildIngredientsList(mealDetail),
                      const SizedBox(height: 30),
                      const _SectionHeader(icon: Icons.menu_book, title: 'Рецепт'),
                      const SizedBox(height: 15),
                      _buildRecipeSteps(mealDetail),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIngredientsList(MealDetail meal) {
    return Column(
      children: List.generate(meal.ingredients.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 6, color: Color(0xFFFF7D31)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  meal.ingredients[index],
                  style: const TextStyle(fontSize: 15, color: Color(0xFF4A4A4A)),
                ),
              ),
              if (index < meal.measures.length)
                Text(
                  meal.measures[index],
                  style: const TextStyle(
                    color: Color(0xFFFF7D31),
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRecipeSteps(MealDetail meal) {
    final steps = meal.instructions
        .split('.')
        .map((s) => s.trim())
        .where((s) => s.length > 3)
        .toList();

    return Column(
      children: steps.asMap().entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF9F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7D31),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${entry.key + 1}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  entry.value.endsWith('.') ? entry.value : '${entry.value}.',
                  style: const TextStyle(height: 1.5, fontSize: 14, color: Color(0xFF2D2D2D)),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF7D31), size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Icon(icon, color: iconColor ?? Colors.black, size: 22),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[400]),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ],
    );
  }
}
