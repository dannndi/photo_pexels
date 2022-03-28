import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_pexels/data/repository/pexel_repository.dart';
import 'package:photo_pexels/dependency_injection.dart';
import 'package:photo_pexels/module/search/cubit/search_cubit.dart';
import 'package:photo_pexels/module/search/view/search_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        inject.get<PexelRepository>(),
      ),
      child: const SearchView(),
    );
  }
}
