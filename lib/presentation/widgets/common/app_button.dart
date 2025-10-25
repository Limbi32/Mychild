import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bouton réutilisable style My Child
class AppButton extends StatelessWidget {
  final String label;
  final String? icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;
  final bool isEnabled;
  final double? height;
  final double? fontSize;
  final bool isLoading;
  
  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.color,
    this.textColor,
    this.isEnabled = true,
    this.height,
    this.fontSize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled && !isLoading ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          height: height ?? 70,
          decoration: BoxDecoration(
            color: color ?? AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isEnabled ? [AppColors.defaultShadow] : null,
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.accentBlue,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Text(icon!, style: GoogleFonts.bubblegumSans(fontSize: 24)),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        label,
                        style: GoogleFonts.bubblegumSans(
                          color: textColor ?? AppColors.accentBlue,
                          fontSize: fontSize ?? 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Bouton avec gradient
class AppGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final bool isEnabled;
  final bool isLoading;
  
  const AppGradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.gradient,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled && !isLoading ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: gradient ?? AppColors.orangeGradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: GoogleFonts.bubblegumSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
