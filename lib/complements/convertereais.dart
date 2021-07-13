import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

  //Todo Converte o valor informado em formato de Reais
converteReais(valor){
  //Todo: Se o valor.runtimeType for igual a 'String', sera Convertido para double.
    if(valor == '' || valor == null){
      return 0.000;
    }

   if(valor != null){

     if(valor.runtimeType.toString() == 'String'){
       valor = double.parse(valor);
     }
    //Todo Definindo dois valore depois da virgula
    var valorComVirgulaEInvertido = valor.toStringAsFixed(2).replaceAll('.',',').split('').reversed.join();
    //Todo Invertendo todo o calor
    var maskValorMoney = new MaskTextInputFormatter(mask: '##,###.###.###.###.###.###.###.###', filter:  { "#": RegExp(r'[0-9]') });
    //Todo Criando a mascara
    var valorComVirgulaEInvertidoComMascara = '${maskValorMoney.maskText(valorComVirgulaEInvertido.toString())}';
    //Todo Aplicando a mascara
    var valorComVirgulaEInvertidoComMascaraInvertidoNovamente = valorComVirgulaEInvertidoComMascara.split('').reversed.join();
    //Todo Invertendo novamente para voltar a ficar normal
    return valorComVirgulaEInvertidoComMascaraInvertidoNovamente;
   }else{
     return 0;
   }
}