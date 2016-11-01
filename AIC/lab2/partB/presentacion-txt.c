/**************************************************************************
 * 
 * Departamento de Informática de Sistema y Computadores (DISCA)
 * Universidad Politecnica de Valencia.                         
 * 
 * Author: Sergio Sáez (ssaez@disca.upv.es)
 *	   Pedro López (plopez@gap.upv.es)
 * 
 * File: presentacion-txt.c
 *  
 * Description: Contiene las funciones necesarias para presentar la
 *    información sobre la ejecución del algoritmo
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *************************************************************************/

#define presentatxt_C

/***** Includes ***********************************************/

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/***** Definiciones Externas **********************************/

#include "tipos.h"
#include "main.h"
#include "instrucciones.h"

/***** Variables Globales *************************************/

/***** Variables Locales **************************************/

/***** Funciones Locales **************************************/

/***************************************************************
 *
 * Func: imprime_instruccion
 *
 * Parametros:
 *	instruc  (char *) ; 
 *
 * Descripción: 
 *   Imprime la intrucción localizada en el PC sobre la
 *   cadena de caracteres 'instruc'
 *
 **************************************************************/

void imprime_instruccion ( 
 word	PC,
 char *	instruc
 )

{
  /*************************************/
  /*  Cuerpo función                   */
  /*************************************/

  if (PC == -1)
    {
      strcpy(instruc, "-nop-");
      return ;
    } /* endif */

  switch (MI[PC].codop)
    {
    case OP_NOP:
      sprintf(instruc, "NOP");
      break;
    case OP_TRAP:
      sprintf(instruc, "TRAP %d", 
	      MI[PC].inmediato);
      break;
    case OP_LW:
      sprintf(instruc, "LW R%d,%d(R%d)", 
	      MI[PC].Rdestino,
	      MI[PC].inmediato,
	      MI[PC].Rfuente1
	      );
      break;
    case OP_SW:
      sprintf(instruc, "SW R%d, %d(R%d)", 
	      MI[PC].Rfuente2,
	      MI[PC].inmediato,
	      MI[PC].Rfuente1
	      );
      break;
    case OP_ADD:
      sprintf(instruc, "ADD R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SUB:
      sprintf(instruc, "SUB R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_AND:
      sprintf(instruc, "AND R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_OR:
      sprintf(instruc, "OR R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_XOR:
      sprintf(instruc, "XOR R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SRA:
      sprintf(instruc, "SRA R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SRL:
      sprintf(instruc, "SRL R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SLL:
      sprintf(instruc, "SLL R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SEQ:
      sprintf(instruc, "SEQ R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SNE:
      sprintf(instruc, "SNE R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SGT:
      sprintf(instruc, "SGT R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SGE:
      sprintf(instruc, "SGE R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SLT:
      sprintf(instruc, "SLT R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_SLE:
      sprintf(instruc, "SLE R%d,R%d,R%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2
	      );
      break;
    case OP_ADDI:
      sprintf(instruc, "ADD R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SUBI:
      sprintf(instruc, "SUB R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_ANDI:
      sprintf(instruc, "AND R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_ORI:
      sprintf(instruc, "OR R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_XORI:
      sprintf(instruc, "XOR R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SRAI:
      sprintf(instruc, "SRA R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SRLI:
      sprintf(instruc, "SRL R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SLLI:
      sprintf(instruc, "SLL R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SEQI:
      sprintf(instruc, "SEQ R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SNEI:
      sprintf(instruc, "SNE R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SGTI:
      sprintf(instruc, "SGT R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SGEI:
      sprintf(instruc, "SGE R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SLTI:
      sprintf(instruc, "SLT R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_SLEI:
      sprintf(instruc, "SLE R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].inmediato
	      );
      break;
    case OP_BNEZ:
      sprintf(instruc, "BNEZ R%d,%d", 
	      MI[PC].Rfuente1,
	      MI[PC].inmediato);
      break;
    case OP_BEQZ:
      sprintf(instruc, "BEQZ R%d,%d", 
	      MI[PC].Rfuente1,
	      MI[PC].inmediato);
      break;
    default:
      sprintf(instruc, "??? R%d,R%d,R%d,#%d", 
	      MI[PC].Rdestino,
	      MI[PC].Rfuente1,
	      MI[PC].Rfuente2,
	      MI[PC].inmediato
	      );
      break;
    } /* endswitch */

} /* end imprime_instruccion */


/***** Funciones Exportables **********************************/


/***************************************************************
 *
 * Func: imprime_etapas
 *
 * Descripción: 
 *   Imprime el estado de la maquina
 *
 **************************************************************/

void imprime_etapas (  
   )

{
  /*************************************/
  /*  Variables locales                */
  /*************************************/

  char		inst[80];

  /*************************************/
  /*  Cuerpo función                   */
  /*************************************/


  fprintf(stdout, "\n");

  fprintf(stdout, "\n*** Ciclo: %ld ***\n\n", Ciclo);

  fprintf(stdout, "PC: %ld \n\n", PC);

/*
    imprime_instruccion(PC, inst); 
    fprintf (stdout, "--/IF: %s \n",inst);

    imprime_instruccion(IF_ID.iPC, inst);
    fprintf (stdout, "IF/ID: %s \n",inst);
  
    imprime_instruccion(ID_EX.iPC, inst);
    fprintf (stdout, "ID/EX: %s \n",inst);
  
    imprime_instruccion(EX_MEM.iPC, inst);
    fprintf (stdout, "EX/MEM: %s \n",inst);

    imprime_instruccion(MEM_WB.iPC, inst);
    fprintf (stdout, "MEM/WB: %s \n",inst);

    fprintf (stdout, "\n");
*/
    fprintf (stdout, "IF              ID              EX              MEM             WB\n");
 
    imprime_instruccion(PC, inst); 
    fprintf (stdout, "%-16s",inst);

    imprime_instruccion(IF_ID.iPC, inst);
    fprintf (stdout, "%-16s",inst);
  
    imprime_instruccion(ID_EX.iPC, inst);
    fprintf (stdout, "%-16s",inst);
  
    imprime_instruccion(EX_MEM.iPC, inst);
    fprintf (stdout, "%-16s",inst);

    imprime_instruccion(MEM_WB.iPC, inst);
    fprintf (stdout, "%-16s \n",inst);

    fprintf (stdout, "Señales: ");
    if (IFstall == SI)  {fprintf (stdout, "IFstall ");};
    if (IDstall == SI)  {fprintf (stdout, "IDstall ");};
    if (IFnop == SI)  {fprintf (stdout, "IFnop ");};
    if (IDnop == SI)  {fprintf (stdout, "IDnop ");};
    if (EXnop == SI)  {fprintf (stdout, "EXnop ");};
    if (MEMaEXalu_s == SI)  {fprintf (stdout, "MEMaEXalu_i ");};
    if (MEMaEXalu_i == SI)  {fprintf (stdout, "MEMaEXalu_s ");};
    if (MEMaEXcomp == SI)  {fprintf (stdout, "MEMaEXcomp ");};
    if (WBaEXalu_s == SI)  {fprintf (stdout, "WBaEXalu_i ");};
    if (WBaEXalu_i == SI)  {fprintf (stdout, "WBaEXalu_s ");};
    if (WBaEXcomp == SI)  {fprintf (stdout, "WBaEXcomp ");};
    if (WBaMEM == SI)  {fprintf (stdout, "WBaMEM ");};
    if (MEMaID == SI)  {fprintf (stdout, "MEMaID ");};
    if (WBaID == SI)  {fprintf (stdout, "WBaID ");};
    fprintf (stdout, "\n");
    

} /* end imprime_etapas */

/***************************************************************
 *
 * Func: imprime_reg
 *
 * Descripción: 
 *   Imprime el estado de la maquina (i: Registros)
 *
 **************************************************************/

void imprime_reg (  
   )

{
  /*************************************/
  /*  Variables locales                */
  /*************************************/

  int		i,j;

  /*************************************/
  /*  Cuerpo función                   */
  /*************************************/

  fprintf(stdout, "\n");

  j = 1;
  for (i=0; i<TAM_REGISTROS; i++)
    {
      /*** Registros enteros */
      fprintf (stdout, "Regs[%d]: %4d ",i, Rint[i].valor); 
      if ((j % 4) == 0) fprintf (stdout, "\n");
      j++;
    } /* endfor */
 
} /* end imprime_reg */


/***************************************************************
 *
 * Func: imprime_memdatosq
 *
 * Descripción: 
 *   Imprime el estado de la maquina (ii: memoria de datos)
 *
 **************************************************************/

void imprime_memdatos (  
   )

{
  /*************************************/
  /*  Variables locales                */
  /*************************************/

  int		i,j;

  /*************************************/
  /*  Cuerpo función                   */
  /*************************************/


  fprintf(stdout, "\n");

  j = 1;
  for (i= SegDatos.inicio; i< SegDatos.final; i+= sizeof(word))
    {
      fprintf(stdout, "Mem[%4d]: ", i); 
      fprintf(stdout, "%4d ", MD.mword[dir_word(i)]);
      if ((j % 4) == 0) fprintf (stdout, "\n");
      j++;
    } /* endfor */
  fprintf(stdout, "\n"); 

 
} /* end imprime_mem */


