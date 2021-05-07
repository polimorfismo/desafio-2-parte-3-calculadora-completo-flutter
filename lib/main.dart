import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatefulWidget {
  @override
  _MeuAppState createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  String mensagemVisor = '0';

  //Método para receber os valores e os operadores e criar a expressão que será repassada para a lib
  void setarValor(String valor) {
    setState(() {
      if (mensagemVisor == '0') {
        mensagemVisor = valor;
      } else {
        mensagemVisor += valor;
      }
    });
  }

  //Limpa o visor da calculadora
  void resetar() {
    setState(() {
      mensagemVisor = '0';
    });
  }

  //Realizar cálculo com equação repassada
  void realizarCalculo() {
    //Se houver divisão trocar o caractere ÷ pelo da barra que é reconhecido pela instrução
    mensagemVisor = mensagemVisor.replaceAll('÷', '/');

    Parser p = Parser();
    //Nesta linha a expressão matemática será criada de acordo com o que for passado na string
    Expression expressao = p.parse(mensagemVisor);
    ContextModel cm = new ContextModel(); //Obtem o contexto da expressão
    //Nesta linha será realisado de fato o cálculo
    double resolucaoDaExpressao = expressao.evaluate(EvaluationType.REAL, cm);
    setState(() {
      mensagemVisor = resolucaoDaExpressao.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: Text('Calculadora'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            //Definição do visor da calculadora
            Container(
              alignment: Alignment.bottomRight,
              color: Colors.white,
              margin: EdgeInsets.all(15),
              width: 400,
              height: 120,
              child: Text(
                mensagemVisor,
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            Container(
              //margin: EdgeInsets.all(15),
              child: Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          constroiBotoesCalculadora(
                              caracterDaTecla: 'C',
                              corTecla: Colors.blue,
                              onPress: () => {resetar()}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: 'DEL',
                              corTecla: Colors.blue,
                              onPress: () => {resetar()}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '%',
                              corTecla: Colors.blue,
                              onPress: () => {setarValor('%')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '÷',
                              corTecla: Colors.blue,
                              onPress: () => {setarValor('÷')}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          constroiBotoesCalculadora(
                              caracterDaTecla: '7',
                              onPress: () => {setarValor('7')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '8',
                              onPress: () => {setarValor('8')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '9',
                              onPress: () => {setarValor('9')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '*',
                              corTecla: Colors.blue,
                              onPress: () => {setarValor('*')}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          constroiBotoesCalculadora(
                              caracterDaTecla: '4',
                              onPress: () => {setarValor('4')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '5',
                              onPress: () => {setarValor('5')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '6',
                              onPress: () => {setarValor('6')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '+',
                              corTecla: Colors.blue,
                              onPress: () => {setarValor('+')}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          constroiBotoesCalculadora(
                              caracterDaTecla: '1',
                              onPress: () => {setarValor('1')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '2',
                              onPress: () => {setarValor('2')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '3',
                              onPress: () => {setarValor('3')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '-',
                              corTecla: Colors.blue,
                              onPress: () => {setarValor('-')}),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          constroiBotoesCalculadora(
                              caracterDaTecla: '0',
                              onPress: () => {setarValor('0')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '.',
                              onPress: () => {setarValor('.')}),
                          constroiBotoesCalculadora(
                              caracterDaTecla: '=',
                              corTecla: Colors.blue,
                              onPress: () => realizarCalculo()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded constroiBotoesCalculadora(
      {String caracterDaTecla,
      Color corTecla = Colors.white,
      Function onPress}) {
    return Expanded(
      child: RaisedButton(
        color: Colors.black12,
        textColor: corTecla,
        onPressed: onPress,
        child: Text(
          caracterDaTecla,
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
