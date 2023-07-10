# EEL480-Laboratorio_de_Sistemas_Digitais-2023.1

## Integrantes
> Aline Capucho, Afonso Mateus Pinto, Juliana Dal Piaz e Renan Carvalho Gomes

## Conteudo
1. [Requisitos](#requisitos)
1. [Primeiros Testes](#primeiros-testes)
1. [Projeto](#projeto)
1. [Modularizacao](#modularizacao)
1. [Unindo Tudo](#unindo-tudo)
1. [Simulacao](#simulacao)

## Requisitos
### Objetivo do trabalho:
Os alunos devem desenvolver uma ULA (Unidade Lógica e Aritmética) de 4 bits e 8 operações,
das quais 4 são obrigatórias e 4 escolhidas pelo trio.

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

### Configuração de Ambiente no Laboratório

**Nome do Simulador: ISE Simulator (ISim)**
[Link para site Xilinx](https://www.xilinx.com/products/design-tools/isim.html)
> Abrir um porjeto novo
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
- Depois, em Enviar para a placa

### Configuração de Ambiente em Casa
Para o passo a passo da configuração do simulador de FPGA Quartus Prime, ir para o [ANEXO A](#anexo-a), que contém as figuras do processo de instalação desse software.

### Teste de Sanidade
Uma vez que ficou estabelecido o passo a passo de como ligar a placa e realizar checagem de sintaxe, compilação, atrelamento de pinagem e testes, tentamos rodar um código simples de uma estrutura básica de ALU, sem sucesso.

Após várias tentativas de refazer esse código, pensamos em um teste de sanidade para testar a conexão da placa com o programa e nossa capacidade de escrever códigos funcionais em VHDL, seguimos com o projeto.

> Abaixo um GIF indicando o sucesso do teste
<video src='https://raw.githubusercontent.com/umjourje/EEL480-Laboratorio_de_Sistemas_Digitais-2023.1/main/images/WhatsApp%20Video%202023-07-04%20at%204.11.45%20PM.mp4' width=180/>

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
Ideia geral de projeto
### O que é uma ALU?


### Quais operações?


### Quais são nossas entradas e saídas?
### Mapeamento de cada operação para o código binário de cada operação


## Modularização
separacao logica de componentes a serem reutilizados

## Unindo tudo
como juntamos todos os modelos necessarios para o funcionamento de acordo com o projeto

## Simulação
Quartus prime em casa para rodar os codigod VHDL e checar a sintaxe.


## Anexo A