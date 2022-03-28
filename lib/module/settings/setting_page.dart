import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/theme/cubit/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Dark theme",
              style: Theme.of(context).textTheme.headline4,
            ),
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Switch(
                  value: state.theme == ThemeMode.dark,
                  onChanged: (value) {
                    context
                        .read<ThemeCubit>()
                        .changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                  activeColor: Theme.of(context).primaryColor,
                );
              },
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
