import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeService {
  static String _barcodeScanRes = '';

  static Future<String?> scanBarcode() async {
    try {
      _barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
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

  // static get barcodeRes async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       '#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
  //   return barcodeScanRes;
  // }

  // static get scanQr async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //       '#3D8BEF', 'Cancelar', false, ScanMode.QR);
  //   return barcodeScanRes;
  // }
}
