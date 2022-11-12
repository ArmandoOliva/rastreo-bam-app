import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rastreo_bam/models/models.dart';

import 'package:rastreo_bam/providers/providers.dart';
import 'package:rastreo_bam/services/services.dart';
import 'package:rastreo_bam/themes/app_theme.dart';
import 'package:rastreo_bam/ui/inputs_decoration.dart';
import 'package:rastreo_bam/widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        ChangeNotifierProvider(
          create: (_) => LDFromProvider(),
          child: const LDForm(),
        ),
      ],
    );
  }
}

class LDForm extends StatelessWidget {
  const LDForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ldForm = Provider.of<LDFromProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: ldForm.formkey,
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputsDecorations.authInput(
                hintText: 'Mensajero', label: 'Mensajero'),
            items: const [
              DropdownMenuItem(value: 70, child: Text('Oliva tecnologia')),
              DropdownMenuItem(value: 71, child: Text('Edwin tecnologia')),
            ],
            onChanged: (value) =>
                ldForm.idMensajero = int.parse(value.toString()),
          ),
          const SizedBox(height: 25),
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  child: TextFormField(
                    autocorrect: false,
                    decoration: InputsDecorations.authInput(
                        hintText: 'Barra', label: 'Barra'),
                    onChanged: (value) => ldForm.barra = value,
                    validator: (value) {
                      return (value ?? '').isEmpty ? 'Barra inválida' : null;
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  onPressed: () async {
                    final String? barcodeRes =
                        await BarcodeService.scanBarcode();
                    if (barcodeRes == null) print('Ha ocurrido un error');

                    await EasyLoading.showInfo(barcodeRes ?? '');
                  },
                  icon: const Center(child: Icon(Icons.qr_code, size: 40)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppTheme.secondary,
                ),
              ),
              onPressed: () => _procesarLD(context, ldForm),
              child: Text(ldForm.isLoading ? 'Espere' : 'Iniciar sesión'),
            ),
          ),
        ],
      ),
    );
  }
}

void _procesarLD(BuildContext context, LDFromProvider ldForm) async {
  FocusScope.of(context).unfocus();
  if (!ldForm.isValidForm()) return;

  await EasyLoading.show(
    status: 'Procesando Salida a ruta...',
    maskType: EasyLoadingMaskType.black,
  );

  ldForm.isLoading = true;

  await ProcessesService.procesarLD(ldForm.idMensajero, ldForm.barra)
      .then((ProcesarLD data) {
    EasyLoading.dismiss();

    if (data.codigo == 200) {
      Alert(context, title: 'Salida a Ruta', text: data.mensaje);
    } else {
      Alert(context, title: 'Error', text: data.mensaje);
      ldForm.isLoading = false;
    }
  });
}
