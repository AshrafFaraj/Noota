import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_color.dart';
import '../../manager/notes_cubit/notes_cubit.dart';

class UISwitcherButton extends StatelessWidget {
  const UISwitcherButton({
    super.key,
    required this.isGrid,
  });

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<NotesCubit>().setIsGrid();
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == const ValueKey('dark')
              ? Tween<double>(begin: 0.75, end: 1).animate(anim)
              : Tween<double>(begin: 0.25, end: 1).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(
          size: 30,
          isGrid ? Icons.grid_view : Icons.view_list_rounded,
          key: ValueKey(isGrid ? 'grid' : 'list'),
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
