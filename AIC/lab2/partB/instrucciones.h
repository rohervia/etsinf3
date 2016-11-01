/*********************************************************************
 *
 * Arquitectura de Computadores.
 * Departamento de Informática de Sistemas y Computadores (DISCA)
 * Universidad Politécnica de Valencia.                         
 *
 * Autor: Sergio Sáez (ssaez@disca.upv.es)
 *	  Pedro López (plopez@gap.upv.es)
 *
 * Fichero: instrucciones.h
 * 
 * Descripción: 
 *   Contiene los códigos de las instrucciones implementadas
 *
 ***********************************************************************/

#ifndef instrucciones_H
#define instrucciones_H

/*** Includes **************************************************************/

#include "tipos.h"

/*** Defines ***************************************************************/

#define OP_NOP           0

#define OP_ADD 		 1
#define OP_ADDI 	 2 
#define OP_ADDU 	 3 
#define OP_ADDUI 	 4 
#define OP_AND 		 5 
#define OP_ANDI 	 6 
#define OP_BEQZ 	 7 
#define OP_BNEZ 	 8
#define OP_J 		 9
#define OP_JAL 		 10 
#define OP_JALR 	 11 
#define OP_JR 		 12 
#define OP_LB 		 13 
#define OP_LBU 		 14 
#define OP_LH 		 15 
#define OP_LHI 		 16 
#define OP_LHU 		 17 
#define OP_LW 		 18 
#define OP_OR 		 19 
#define OP_ORI 		 20 
#define OP_SB 		 21 
#define OP_SEQ 		 22 
#define OP_SEQI 	 23 
#define OP_SEQU 	 24 
#define OP_SEQUI 	 25 
#define OP_SGE 		 26 
#define OP_SGEI 	 27 
#define OP_SGEU 	 28 
#define OP_SGEUI 	 29 
#define OP_SGT 		 30 
#define OP_SGTI 	 31 
#define OP_SGTU 	 32 
#define OP_SGTUI 	 33 
#define OP_SH 		 34
#define OP_SLE 		 35 
#define OP_SLEI 	 36 
#define OP_SLEU 	 37 
#define OP_SLEUI 	 38 
#define OP_SLL 		 39 
#define OP_SLLI 	 40 
#define OP_SLT 		 41 
#define OP_SLTI 	 42 
#define OP_SLTU 	 43 
#define OP_SLTUI 	 44 
#define OP_SNE 		 45 
#define OP_SNEI 	 46 
#define OP_SNEU 	 47 
#define OP_SNEUI 	 48 
#define OP_SRA 		 49 
#define OP_SRAI 	 50 
#define OP_SRL 		 51 
#define OP_SRLI 	 52 
#define OP_SUB 		 53 
#define OP_SUBI 	 54 
#define OP_SUBU 	 55 
#define OP_SUBUI 	 56 
#define OP_SW 		 57 
#define OP_TRAP 	 58
#define OP_XOR 		 59 
#define OP_XORI 	 60 

#endif /* Include instrucciones.h */


