import 'package:crud_firebase/models/produto/familia.dart';
import 'package:crud_firebase/models/produto/grupo.dart';
import 'package:crud_firebase/models/produto/marca.dart';
import 'package:crud_firebase/models/produto/modelo.dart';
import 'package:crud_firebase/models/produto/subgrupo.dart';
import 'package:crud_firebase/models/produto/tabeladepreco.dart';
import 'package:crud_firebase/models/produto/unidadedemedida.dart';

class Produto{
  final String ABREVIACAO;
  final int ALTURA;
  final String ATIVO;
  final String CADASTRODATA;
  final String CATEGORIA;
  final int CODIGO;
  final int COMPLEMENTO;
  final double COMPRIMENTO;
  final double CUSTOLIQUIDO;
  final int ESTOQUE;
  final Familia FAMILIA;
  final Grupo GRUPO;
  final int LARGURA;
  final Marca MARCA;
  final Modelo MODELO;
  final String NCM;
  final String NOME;
  final int PESO;
  final String PROMOCAO_ATE;
  final String PROMOCAO_DE;
  final String REFERENCIA;
  final Subgrupo SUBGRUPO;
  final TabelaDePreco TABELASDEPRECO;
  final String TIPO;
  final Unidadedemedida UNIDADEDEMEDIDA;
  final String UNIDADEEMPESO;
  final String UTILIZAGRADE;

  Produto(
    this.ABREVIACAO,
    this.ALTURA,
    this.ATIVO,
    this.CADASTRODATA,
    this.CATEGORIA,
    this.CODIGO,
    this.COMPLEMENTO,
    this.COMPRIMENTO,
    this.CUSTOLIQUIDO,
    this.ESTOQUE,
    this.FAMILIA,
    this.GRUPO,
    this.LARGURA,
    this.MARCA,
    this.MODELO,
    this.NCM,
    this.NOME,
    this.PESO,
    this.PROMOCAO_ATE,
    this.PROMOCAO_DE,
    this.REFERENCIA,
    this.SUBGRUPO,
    this.TABELASDEPRECO,
    this.TIPO,
    this.UNIDADEDEMEDIDA,
    this.UNIDADEEMPESO,
    this.UTILIZAGRADE,
  );

  @override
  String toString(){
    return 'Produto = { ABREVIACAO :$ABREVIACAO,'
        'ALTURA: $ALTURA,'
        'ATIVO : $ATIVO,'
        'CADASTRODATA : $CADASTRODATA, '
        'CATEGORIA: $CATEGORIA,'
        'CODIGO: $CODIGO,'
        'COMPLEMENTO: $COMPLEMENTO, '
        'COMPRIMENTO: $COMPRIMENTO, '
        'CUSTOLIQUIDO: $CUSTOLIQUIDO, '
        'ESTOQUE: $ESTOQUE, '
        'FAMILIA: $FAMILIA, '
        'GRUPO: $GRUPO, '
        'LARGURA: $LARGURA, '
        'MARCA: $MARCA, '
        'MODELO: $MODELO,'
        'NCM: $NCM, '
        'NOME: $NOME,'
        'PESO: $PESO,'
        'PROMOCAO_ATE: $PROMOCAO_ATE, '
        'PROMOCAO_DE: $PROMOCAO_DE, '
        'REFERENCIA: $REFERENCIA, '
        'SUBGRUPO: $SUBGRUPO, '
        'TABELASDEPRECO: $TABELASDEPRECO, '
        'TIPO: $TIPO, '
        'UNIDADEDEMEDIDA: $UNIDADEDEMEDIDA, '
        'UNIDADEEMPESO: $UNIDADEEMPESO, '
        'UTILIZAGRADE: $UTILIZAGRADE}';
  }
}