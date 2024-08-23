import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonWidth(BuildContext context) {
      const maxWidth = 120.0;
      const buttonCount = 3;

      final width = (MediaQuery.of(context).size.width - 100) / buttonCount;
      if (width < maxWidth) {
        return width;
      } else {
        return maxWidth;
      }
    }

    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        return Center(
          child: ToggleButtons(
            isSelected: [
              provider.currentTheme == 'light',
              provider.currentTheme == 'dark',
              provider.currentTheme == 'system',
            ],
            onPressed: (int index) {
              switch (index) {
                case 0:
                  provider.changeTheme('light');
                  break;
                case 1:
                  provider.changeTheme('dark');
                  break;
                case 2:
                  provider.changeTheme('system');
                  break;
              }
            },
            borderColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            fillColor: Colors.transparent,
            children: [
              Container(
                alignment: Alignment.center,
                width: buttonWidth(context),
                child: _buildToggleButton(const Icon(Icons.wb_sunny), 'Light'),
              ),
              Container(
                alignment: Alignment.center,
                width: buttonWidth(context),
                child: _buildToggleButton(
                    const Icon(Icons.nightlight_round), 'Dark'),
              ),
              Container(
                alignment: Alignment.center,
                width: buttonWidth(context),
                child: _buildToggleButton(
                    const Icon(Icons.phone_iphone), 'System'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton(Icon icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
