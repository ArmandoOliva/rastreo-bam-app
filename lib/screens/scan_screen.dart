import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rastreo_bam/services/services.dart' show BarcodeService;

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          onPressed: () async {
            final String? barcodeRes = await BarcodeService.scanBarcode();
            if (barcodeRes == null) print('Ha ocurrido un error');

            await EasyLoading.showInfo('barcodeRes');
          },
          icon: const Icon(Icons.qr_code)),
    );
  }
}
