import 'package:eye_ia_detection/core/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFile extends StatefulWidget {
  CustomTextFile({
    super.key,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.keyboardType,
    this.validation,
    this.isSecret = false,
  });

  String labelText;
  String hintText;
  String? validation;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  int? maxLines = 1;
  TextEditingController? controller;
  Function(String)? onChanged;

  bool isSecret;

  @override
  State<CustomTextFile> createState() => _CustomTextFileState();
}

class _CustomTextFileState extends State<CustomTextFile> {
  bool _obscureText =
      true; // Variable para controlar la visibilidad del texto de la contraseña

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.validation ?? null,
        labelStyle:
            TextStyle(color: CustomColors.primary), // Color del texto del label
        hintText: widget
            .hintText, // Texto que se muestra cuando el TextField está vacío
        hintStyle: TextStyle(
            color: CustomColors.grey), // Color del texto de sugerencia
        prefixIcon:
            widget.prefixIcon, // Icono que se muestra antes del texto del input
        suffixIcon: widget.isSecret
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText =
                        !_obscureText; // Cambia el estado de la visibilidad del texto
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: CustomColors.grey,
                ),
              )
            : null,
        filled: true, // Indica si el TextField debe ser lleno de color
        fillColor: CustomColors.white, // Color del fondo del TextField
        enabledBorder: OutlineInputBorder(
          // Bordes cuando el TextField no tiene foco
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: CustomColors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          // Bordes cuando el TextField tiene foco
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: CustomColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          // Bordes cuando hay un error
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // Bordes cuando hay un error y el TextField tiene foco
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      obscureText: widget.isSecret
          ? _obscureText
          : false, // Indica si el texto debe mostrarse como texto oculto o no
    );
  }
}
