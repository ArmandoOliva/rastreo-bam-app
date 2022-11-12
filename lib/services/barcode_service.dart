import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeService {
  static String _barcodeScanRes = '';

  static Future<String?> scanBarcode() async {
    try {
      // _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      // '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
      _barcodeScanRes = 'S164764';
      Future.delayed(const Duration(seconds: 2));
      return _barcodeScanRes;
    } catch (e) {
      return '';
    }
  }

  static Future<String?> scanQr() async {
    try {
      _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 'Cancelar', false, ScanMode.QR);
      return _barcodeScanRes;
    } catch (e) {
      return '';
    }
  }
}
