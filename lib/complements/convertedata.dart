import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

converteData(valor){
  var maskDataDiaMesAno = new MaskTextInputFormatter(mask: '##/##/####', filter:  { "#": RegExp(r'[0-9]') });
  var valorFinal = maskDataDiaMesAno.maskText(valor);
  return valorFinal;
}