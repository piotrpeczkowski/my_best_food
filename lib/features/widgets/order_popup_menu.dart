import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_best_food/features/home_page/cubit/home_cubit.dart';
import 'package:my_best_food/features/styles/styles.dart';

class OrderPopupMenu extends StatefulWidget {
  const OrderPopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderPopupMenu> createState() => _OrderPopupMenuState();
}

class _OrderPopupMenuState extends State<OrderPopupMenu> {
  var _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return PopupMenuButton(
          initialValue: _selectedItem,
          onSelected: (value) {
            setState(() {
              _selectedItem = value;
            });
            context.read<HomeCubit>().orderBy(_selectedItem);
          },
          child: Row(
            children: [
              Text(
                'SORTUJ',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: ItemColor.itemWhite,
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: ItemColor.itemWhite,
              )
            ],
          ),
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                enabled: false,
                child: Text(
                  'SORTUJ:',
                  style: GoogleFonts.lato(),
                ),
              ),
              PopupMenuItem(
                value: 0,
                child: Text(
                  'Od najnowszych',
                  style: GoogleFonts.lato(),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  'Od najstarszych',
                  style: GoogleFonts.lato(),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  'Alfabetycznie A-Z',
                  style: GoogleFonts.lato(),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  'Alfabetycznie Z-A',
                  style: GoogleFonts.lato(),
                ),
              ),
            ];
          },
        );
      },
    );
  }
}
