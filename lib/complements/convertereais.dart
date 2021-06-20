import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

ConverteReais(valor){
  var valorComVirgulaEInvertido = valor.toStringAsFixed(2).replaceAll('.',',').split('').reversed.join();
  //Todo Definindo dois valore depois da virgula
  //Todo Invertendo todo o calor
  var maskValorMoney = new MaskTextInputFormatter(mask: '##,###.###.###.###.###.###.###.###', filter:  { "#": RegExp(r'[0-9]') });
  //Todo Criando a mascara
  var valorComVirgulaEInvertidoComMascara = '${maskValorMoney.maskText(valorComVirgulaEInvertido.toString())}';
  //Todo Aplicando a mascara
  var valorComVirgulaEInvertidoComMascaraInvertidoNovamente = valorComVirgulaEInvertidoComMascara.split('').reversed.join();
  //Todo Invertendo novamente para voltar a ficar normal
  return valorComVirgulaEInvertidoComMascaraInvertidoNovamente;
}