import 'package:intl/intl.dart';

class AppDateFormatter {
  AppDateFormatter._();

  /// Memformat tanggal menjadi "dd-MM-yyyy".
  /// Contoh: 02-04-2025
  static String formatWithHyphen(DateTime? date) {
    if (date == null) return '';
    final localDate = date.toLocal();
    return DateFormat('dd-MM-yyyy').format(localDate);
  }

  /// Memformat tanggal menjadi "dd/MM/yyyy".
  /// Contoh: 02/04/2025
  static String formatWithSlash(DateTime? date) {
    if (date == null) return '';
    final localDate = date.toLocal();
    return DateFormat('dd/MM/yyyy').format(localDate);
  }

  /// Memformat tanggal menjadi format "Bulan Hari, Tahun".
  /// Contoh: April 02, 2025
  static String formatFullDate(DateTime? date) {
    if (date == null) return '';
    final localDate = date.toLocal();
    return DateFormat('MMMM d, yyyy').format(localDate);
  }

  /// Mengonversi tanggal menjadi format waktu relatif (time ago).
  /// Contoh: "3 days ago", "1 year ago", "just now"
  static String formatTimeAgo(DateTime? date) {
    if (date == null) {
      return 'Unknown time';
    }

    final localDate = date.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localDate);

    if (difference.inSeconds < 5) {
      return 'just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}
