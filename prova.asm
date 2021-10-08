#DESAFIO ASSEMBLY : LEIA OS 3 LADOS DE UM TRIANGULO E CLASSIFIQUE-O
# ALUNO :  .asciiz  "JOÃO PAULO FERREIRA NETO"

.data 
ladoA:   .asciiz "Informe o lado A do triangulo :"

ladoB:   .asciiz "Informe o lado B do triangulo :"

ladoC:   .asciiz "Informe o lado C do triangulo :"

msg1:      .asciiz "Triangulo é equilatero"

msg2:       .asciiz  "Triangulo é isósceles"

msg3:       .asciiz  "Triangulo é escaleno"

#MACROS

.macro print( %msg)
      .data
           msg:  .asciiz  %msg
           
      .text
          li $v0,4
          la $a0,msg
          syscall
.end_macro

.macro fimPrograma
    li $v0,10
    syscall
.end_macro

.text
.globl main 
#BLT - desvia se menor
#BGE- desvia se maior ou igual
#BGT- desvia se maior 
#BEQ - desvia se igual
main:

#LER O LADO A E ATRIBUIR PARA O REGISTRADO T0
li $v0,4
la $a0,ladoA
syscall
 
li $v0,5
syscall
move $t0,$v0

#LER O LADO B E ATRIBUIR PARA O REGISTRADO T1
li $v0,4
la $a0,ladoB
syscall

li $v0,5
syscall
move $t1,$v0


#LER O LADO C E ATRIBUIR PARA O REGISTRADO T2
li $v0,4
la $a0,ladoC
syscall

li $v0,5
syscall
move $t2,$v0

#VERIFICAÇOES 

 #BLOCOS PARA O TRIANGULO EQUILATERO- TODOS OS LADOS IGUAIS
beq  $t0,$t1,verificaEquilatero 
jal verificaIsoceles
 
verificaEquilatero: 
beq $t1,$t2,printEquilatero #SE O LAD0 B FOR IGUAL AO C ENTAO A=B=C
 
printEquilatero : 
li $v0,4
la $a0,msg1
syscall
fimPrograma

 #BLOCOS PARA O TRIANGULO ISOCELES - PELO MENOS 2 LADOS IGUAIS
 #VAI VERIFICAR SE A=B OU A=C OU B=C ,COM ISSO TODAS VERIFICAÇÕES DE LADOS SAO FEITAS 
 
 verificaIsoceles:
 beq $t0,$t1,printIsoceles      #VERIFICA SE A=B , SE FOR JA PRINTA
 jal verificaIsoceles2          #CASO PASSE ,VAI PULAR PRA LINHA DE VERIFICAÇÃO 2

verificaIsoceles2:
beq $t0,$t2,printIsoceles       #VERIFICA SE A=C
jal verificaIsoceles3   

verificaIsoceles3:
beq $t1,$t2,printIsoceles            #VERIFICA SE B=C
jal  printEscaleno                   #SE CHEGOU AQUI PASSOU POR TODAS AS VERIFICAÇÕES ENTAO OS LADOS SAO DIFERENTES

printIsoceles:
li $v0,4
la $a0,msg2
syscall
fimPrograma

#BLOCO PARA O TRIANGULO ESCALENO
printEscaleno:
li $v0,4
la $a0,msg3
syscall
fimPrograma
