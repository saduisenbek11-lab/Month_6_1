import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/meal_bloc.dart';
import '../bloc/meal_event.dart';
import '../bloc/meal_state.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeContentView(),
    const _FavoritesView(),
    const _SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFFFF7D31),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}

class _HomeContentView extends StatelessWidget {
  const _HomeContentView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 25),
          _buildSearchBar(),
          const SizedBox(height: 30),
          _buildSectionTitle('Категории'),
          const SizedBox(height: 15),
          const _CategoryFilters(),
          const SizedBox(height: 30),
          _buildSectionTitle('Популярные рецепты 🔥'),
          const SizedBox(height: 15),
          const _PopularMeals(),
          const SizedBox(height: 30),
          _buildExploreBanner(),
          const SizedBox(height: 30),
          _buildSectionTitle('Новые рецепты'),
          const SizedBox(height: 15),
          const _MealList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Добро пожаловать! 👨‍🍳',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Найдите лучшие рецепты со всего мира',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        _CircleButton(icon: Icons.notifications_none, onTap: () {}),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Поиск рецептов...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.tune, color: Colors.grey),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text('Смотреть все', style: TextStyle(color: Colors.orange, fontSize: 12)),
      ],
    );
  }

  Widget _buildExploreBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.public, size: 50, color: Colors.green),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Рецепты со всего мира 🌏',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'Откройте для себя блюда разных стран',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Исследовать'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное'), centerTitle: true),
      body: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          final favorites = state.meals.where((m) => m.isFavorite).toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('У вас пока нет избранных рецептов', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final meal = favorites[index];
              return MealCard(
                meal: meal,
                onFavoriteToggle: () => context.read<MealBloc>().add(ToggleMealFavoriteEvent(meal.id)),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MealDetailPage(mealId: meal.id)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки'), centerTitle: true),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Профиль'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications_none),
            title: const Text('Уведомления'),
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Язык'),
            trailing: const Text('Русский', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Помощь'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Выйти', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: IconButton(icon: Icon(icon), onPressed: onTap),
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        final categories = [
          {'name': 'Все', 'icon': Icons.restaurant_menu},
          {'name': 'Завтраки', 'icon': Icons.egg_outlined},
          {'name': 'Основные', 'icon': Icons.lunch_dining_outlined},
          {'name': 'Супы', 'icon': Icons.soup_kitchen_outlined},
          {'name': 'Десерты', 'icon': Icons.cake_outlined},
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final name = cat['name'] as String;
              final isAll = name == 'Все';
              final isSelected = isAll ? state.selectedCategory == null : state.selectedCategory == name;

              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () => context.read<MealBloc>().add(SelectCategoryEvent(isAll ? null : name)),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                          ],
                        ),
                        child: Icon(cat['icon'] as IconData, color: isSelected ? Colors.white : Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(name, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _PopularMeals extends StatelessWidget {
  const _PopularMeals();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        final meals = state.visibleMeals.take(5).toList();
        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 15),
                child: MealCard(
                  meal: meal,
                  compact: true,
                  onFavoriteToggle: () => context.read<MealBloc>().add(ToggleMealFavoriteEvent(meal.id)),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MealDetailPage(mealId: meal.id)),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _MealList extends StatelessWidget {
  const _MealList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        final meals = state.visibleMeals.skip(5).toList();
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(
              meal: meal,
              onFavoriteToggle: () => context.read<MealBloc>().add(ToggleMealFavoriteEvent(meal.id)),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MealDetailPage(mealId: meal.id)),
              ),
            );
          },
        );
      },
    );
  }
}
