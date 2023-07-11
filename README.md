# EEL480 - Relatório do Projeto de Laboratório de Sistemas Digitais - 2023.1

## Integrantes
> Aline Capucho

> Afonso Mateus Pinto

> Juliana Dal Piaz

> Renan Carvalho Gomes

## Conteúdo
1. [Requisitos](#requisitos)
1. [Primeiros Testes](#primeiros-testes)
1. [Projeto](#projeto)
1. [Modularização](#modularização)
1. [Simulação](#simulação)
1. [Anexo A - Quartus passo a passo](#anexo-a)

## Requisitos
Nessa seção está resumido os requisitos levantados pelo professor. [Nesse arquivo](https://drive.google.com/file/d/10McyMFGa_nt-QEZUU1d6XBJOWCV4qwds/view) está tudo bem descrito e organizado.

### Objetivo do trabalho:
Os alunos devem desenvolver uma ULA (Unidade Lógica e Aritmética) de 4 bits e 8 operações, das quais 4 são obrigatórias e 4 escolhidas pelo trio.

### Especificações:
- As operações a serem executadas na ULA devem selecionada por entradas de controle. O
trabalho deve ter 3 chaves externas (switchers) para controlar tais operações.
- Operações obrigatórias: soma, subtração em complemento de 2, incremento +1, troca de
sinal.
- Os alunos deverão de desenvolver um módulo auxiliar que vai servir para variar os operandos
de entrada que testarão a ALU.
- Os dados de entrada e o resultado da operação devem ser exibidos nos LEDs disponíveis na
placa FPGA.
- As saídas da ALU deve ser o resultado e as quatro flags (Zero, negativo, carry out, overflow)
que deverão ser mostrados no LEDs.

### Funcionamento:
1. Os operandos de entrada são gerados por um módulo auxiliar que conterá um contator que percorrerá todos os binários representados por 4 bits. As entradas são mostradas simultaneamente nos LEDs. Em seguida, a ALU recebe os operandos e produz o resultado também mostrado no display de 7 segmentos. Além disso, a ALU gera 4 flags que são mostradas nos LEDs.
1. As entradas da ULA são geradas por um módulo auxiliar, um contador, parte integrante do projeto. As duas entradas são mostradas, juntamente com o resultado, nos displays de 7 segmentos disponíveis. Os LEDs são utilizados para mostrar as quatro “flags”. Os operandos vão mudando, em ordem crescente, a cada 2 segundos.


## Primeiros Testes
Nessa seção apresentaremos os passos necessários para configurar os ambientes de desenvolvimento, compilação e testes, tanto em casa quanto no laboratório.

### Configuração de Ambiente no Laboratório

**Nome do Simulador: ISE Simulator (ISim)**
[Link para site Xilinx](https://www.xilinx.com/products/design-tools/isim.html)

> Abrir um projeto novo
- Criar projeto sem template adicionando as características da placa;
    - Family: Spartan3AN 
    - Device: XC3S700AN
    - Package: FGG484
    - Preferred Language: VHDL
- Criar novo arquivo COM MESMO NOME DO PROJETO com extensão .vhd;
- Todos os módulos que serão chamados no arquivo principal, que tem o mesmo nome do projeto, devem estar em "Sub arquivos" daquele;

> Após escrever o código:
- No menu lateral esquerdo clicar em 'Check Synthesis';
- Para prosseguir é necessário que esse processo seja executado sem erros;

> Mapeamento das portas (Pre-synthesis)
- No Clicar em: Menu superior -> Tools -> Plan Ahead -> I/O Pin Planning (PlanAhead) - Pre-Synthesis -> Apertar YES -> Abre a telinha para mapear as portas de input/output com as da placa
- Na coluna SITE, mapear os códigos dos itens na placa com os input / output Depois de mapear, volta pra tela normal;

> Compilação
- Voltar pra tela do código -> Configure Target Device -> (iMPACT)
- Tela que abre -> Boundary Scan -> Initialize Chain na barra superior (verde)
- No primeiro, selecionar arquivo do código, no segundo bypass
- Depois, em Enviar para a placa com 'Send to FPGA'

### Configuração de Ambiente em Casa
**Nome do Simulador: Quartus II Prime Lite**
[Link para site Intel](https://fpgasoftware.intel.com/?edition=lite)

Para o passo a passo da configuração do simulador de FPGA Quartus Prime, ir para o [ANEXO A](#anexo-a), que contém as figuras com explicação do processo de instalação desse software.

### Teste de Sanidade

Uma vez que ficou estabelecido o passo a passo de como ligar a placa e realizar checagem de sintaxe, compilação, atrelamento de pinagem e testes, tentamos rodar um código simples de uma estrutura básica de ALU, sem sucesso.

Após várias tentativas de refazer esse código, pensamos em um teste de sanidade para testar a conexão da placa com o programa e nossa capacidade de escrever códigos funcionais em VHDL, seguimos com o projeto.

[Link do vídeo indicando o sucesso do teste](https://raw.githubusercontent.com/umjourje/EEL480-Laboratorio_de_Sistemas_Digitais-2023.1/main/images/working_sanity_test.mp4)

Abaixo o código que foi testado com sucesso. Seu objetivo era replicar nos LEDs as entradas dos 4 switches.

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU is
    Port ( x : in BIT_VECTOR(3 DOWNTO 0);
           z : out BIT_VECTOR(3 DOWNTO 0)
	  );
end ALU;

architecture Behavioral of ALU is

begin

z(0) <= x(0);
z(1) <= x(1);
z(2) <= x(2);
z(3) <= x(3);

end Behavioral;
```

## Projeto
Nessa seção apresentaremos o que é uma ALU, os conceitos básicos para compreendê-la e, a artir disso, como organizamos esse projeto. Descrevendo Entradas, Saídas, Operações e Módulos construídos.

Escolhemos implementar operações que utilizassem em sua maioria um único múdulo *FullAdder* dado ue uma das principais otimizações da ALU é o uso de pouycos módulos para várias operações, uma vez que essa solução economiza espaço físico de circuito integrado.

### O que é uma ALU?
ALU é um acrônimo para *Arithmetic Logic Unit*, um módulo que realiza diversos tipos de operações matemáticas e lógicas dentro de uma CPU (Central Processing Unit).

Para o desenvolvimento de uma CPU como a conhecemos, as operações mais básicas e essenciais para a estrutura funcional se materializar são realizadas pela ALU. E num pipeline ótimo, em 1 ciclo de clock.


> MELHORAR AQUI

### Códigos das Operações

**Mapeamento de cada operação para seu respectivo código binário**
- Soma: **000**
- Incremento de 1: **001**
- Subtração de Complemento de 2: **010**
- Troca de Sinal: **011**
- Decremento de 1: **100**
- OPERACAO AQUI: (XOR?) **101**
- Multiplicar por 2: **110**
- OPERACAO AQUI: (CLEAR?) **111**

### Quais são nossas entradas e saídas?
**Entradas:**
- X := Número binário de 4 bits
- Y := Número binário de 4 bits
- Cin := Número binário de 1 bit

**Saídas:**
- Z := Número binário de 4 bits
- Zero (flag) := 1bit
- Negativo (flag) := 1bit
- Overflow (flag) := 1bit
- Cout (flag) := 1bit


## Modularização

Estrutura Interna e do módulo Somador Completo (Full Adder):
![HA](./images/half_adders-full_adder.jpeg)

Estrutura do módulo Incremento de 1:
![incremento1](./images/incremento_1.jpeg)

Estrutura dos módulos Somador e Subtrator de 4 bits:
![somador_subtrator](./images/mod_subtrator_somador.jpeg)

### Unindo tudo
como juntamos todos os modelos necessarios para o funcionamento de acordo com o projeto
[codigo-full-adder](./modulos/FullAdder.vhd)

## Simulação
Logisim para gerar imagens de projeto
Quartus prime em casa para rodar os codigos VHDL e checar a sintaxe.


# Anexo A
1. Página inicial a partir do [link](https://fpgasoftware.intel.com/?edition=lite) fornecido.
![landing-page](./images/Quartus Prime Tutorial/1-pagina_inicial.png)
1. Clique na versão 20.1.1, como indicado na figura
![version-choice](./images/Quartus Prime Tutorial/2-filtrar_versao.png)
1. Escolha o link de acordo com seu sistema operacional
![os-choice](./images/Quartus Prime Tutorial/3-escolher_so.png)
1. Selecione a aba indicada na imagem para encontrar todos os arquivos que devem ser baixados
![list-downloads](./images/Quartus Prime Tutorial/4-aba_individual.png)
1. Faça o download dos arquivos indicados na figura
![select-files](./images/Quartus Prime Tutorial/5-seleciona_programas.png)
