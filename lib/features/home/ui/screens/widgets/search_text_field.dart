import 'package:ecommerce_app_huma_volve/core/utils/theme.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String>? onSearchChanged;
  const SearchTextField({super.key, this.onSearchChanged});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.grey.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search clothes...',
          hintStyle: TextStyle(color: AppTheme.grey.withValues(alpha: 0.4)),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),

          border: InputBorder.none,
          isDense: true,
          suffixIcon: searchController.text.isEmpty
              ? null
              : IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    searchController.clear();
                    widget.onSearchChanged?.call('');
                    setState(() {});
                  },
                  icon: Icon(Icons.close, color: AppTheme.grey, size: 18),
                ),
        ),
        onChanged: (value) {
          widget.onSearchChanged?.call(value);
          setState(() {});
        },
      ),
    );
  }
}
