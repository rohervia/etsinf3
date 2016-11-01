/**************************************************************************
 * 
 * Departamento de Informática de Sistema y Computadores (DISCA)
 * Universidad Politecnica de Valencia.                         
 * 
 * Author: Sergio Sáez (ssaez@disca.upv.es)
 *	   Pedro López (plopez@gap.upv.es)
 * 
 * File: presentacion-html.c
 *  
 * Description: Contiene las funciones necesarias para presentar la
 *    información sobre la ejecución del algoritmo
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 *************************************************************************/

#define presentacion_C

/***** Includes ***********************************************/

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/***** Definiciones Externas **********************************/

#include "tipos.h"
#include "main.h"
#include "instrucciones.h"
#include "presentacion-html.h"

#ifdef MAX
#undef MAX
#endif
#define MAX(x,y) (((x)>(y)) ? (x) : (y))

/***** Variables Globales *************************************/

/***** Variables Locales **************************************/

static FILE *	f_salida;

static ulong	primera_instruccion= 1;
static ulong	primer_ciclo= 1;
static short    maxima_columna_visible= MAX_CICLOS_INIC;

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

static void imprime_instruccion (  
    char *	instruc,
    word	PC
    )
{
    /*************************************/
    /*  Cuerpo función                   */
    /*************************************/

    if (PC == -1) {
        strcpy(instruc, "-nop-");
        return ;
    } /* endif */

    switch (MI[PC].codop) {
    case OP_NOP:
        sprintf(instruc, "NOP");
        break;
    case OP_TRAP:
        sprintf(instruc, "TRAP %d", 
                MI[PC].inmediato);
        break;
    case OP_LW:
        sprintf(instruc, "LW R%d, %d(R%d)", 
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
        sprintf(instruc, "ADD R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SUB:
        sprintf(instruc, "SUB R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_AND:
        sprintf(instruc, "AND R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_OR:
        sprintf(instruc, "OR R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_XOR:
        sprintf(instruc, "XOR R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SRA:
        sprintf(instruc, "SRA R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SRL:
        sprintf(instruc, "SRL R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SLL:
        sprintf(instruc, "SLL R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SEQ:
        sprintf(instruc, "SEQ R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SNE:
        sprintf(instruc, "SNE R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SGT:
        sprintf(instruc, "SGT R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SGE:
        sprintf(instruc, "SGE R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SLT:
        sprintf(instruc, "SLT R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_SLE:
        sprintf(instruc, "SLE R%d, R%d, R%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2
            );
        break;
    case OP_ADDI:
        sprintf(instruc, "ADD R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SUBI:
        sprintf(instruc, "SUB R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_ANDI:
        sprintf(instruc, "AND R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_ORI:
        sprintf(instruc, "OR R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_XORI:
        sprintf(instruc, "XOR R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SRAI:
        sprintf(instruc, "SRA R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SRLI:
        sprintf(instruc, "SRL R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SLLI:
        sprintf(instruc, "SLL R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SEQI:
        sprintf(instruc, "SEQ R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SNEI:
        sprintf(instruc, "SNE R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SGTI:
        sprintf(instruc, "SGT R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SGEI:
        sprintf(instruc, "SGE R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SLTI:
        sprintf(instruc, "SLT R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_SLEI:
        sprintf(instruc, "SLE R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].inmediato
            );
        break;
    case OP_BNEZ:
        sprintf(instruc, "BNEZ R%d, %d", 
                MI[PC].Rfuente1,
                MI[PC].inmediato);
        break;
    case OP_BEQZ:
        sprintf(instruc, "BEQZ R%d, %d", 
                MI[PC].Rfuente1,
                MI[PC].inmediato);
        break;
    default:
        sprintf(instruc, "Inst desconocida R%d, R%d, R%d, #%d", 
                MI[PC].Rdestino,
                MI[PC].Rfuente1,
                MI[PC].Rfuente2,
                MI[PC].inmediato
            );
        break;
    } /* endswitch */

} /* end imprime_instruccion */

/***************************************************************
 *
 * Func: desplazamiento_horizontal
 *
 * Description: 
 *   Desplaza la zona visible un ciclo hacia la izquierda
 *
 **************************************************************/

static void desplazamiento_horizontal ()
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    short i, j;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    for (i= 0; i<MAX_INSTRUC; i++) {
        for (j= 0; j<MAX_CICLOS-1; j++)
            strcpy(crono[i].fase[j], crono[i].fase[j+1]);
      
        /* Borra la Última columna */
        strcpy(crono[i].fase[j], ""); 
    } /* endfor */

    /*** Actualiza los desplazamientos iniciales ***/

    primer_ciclo++;
  
} /* end desplazamiento_horizontal */

/***************************************************************
 *
 * Func: desplazamiento_vertical
 *
 * Description: 
 *   Desplaza la zona visible un ciclo hacia la izquierda
 *
 **************************************************************/

static void desplazamiento_vertical ()
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    short i, j, desp;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    /* Averigua si la línea se va a quedar vacia al principio */
    for (desp= 0; 
         desp < MAX_CICLOS && 
             !strlen(crono[1].fase[desp]); desp++);
    if (desp == MAX_CICLOS)
        desp= 1;                /* La línea está completamente vacia. Avanzamos sólo un
                                 * ciclo */
    
	
    for (i= 0; i<MAX_INSTRUC-1; i++) {
        strcpy(crono[i].inst, crono[i+1].inst);
      
        for (j= 0; j<MAX_CICLOS-desp; j++)
            strcpy(crono[i].fase[j], crono[i+1].fase[j+desp]);
      
        /* Borra las últimas columnas */
        for (j= MAX_CICLOS-desp; j<MAX_CICLOS; j++) 
            strcpy(crono[i].fase[j], "");
    } /* endfor */
  
    /* Borra la última fila */
    crono[MAX_INSTRUC-1].inst[0]= '\0';
    for (j= 0; j<MAX_CICLOS; j++)
        crono[MAX_INSTRUC-1].fase[j][0]= '\0';

    /*** Actualiza los desplazamientos iniciales ***/
  
    primer_ciclo+= desp;
    primera_instruccion++;
    maxima_columna_visible-= desp;

} /* end desplazamiento_vertical */


/***** Funciones Exportables **********************************/

/***************************************************************
 *
 * Func: init_instruc
 *
 * Description: 
 *   Inicializa una instrucción en el cronograma
 *
 **************************************************************/

void init_instruc (
    word	PC,
    ulong	orden
    )
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    int	o;
    char		aux[128];

    /*************************************/
    /*  Function body                    */
    /*************************************/

    if (orden == primera_instruccion + MAX_INSTRUC)
        desplazamiento_vertical();

    o= orden - primera_instruccion;

    imprime_instruccion(aux, PC);
    sprintf(crono[o].inst, "%2ld: %s", PC, aux);

} /* end init_instruc */

/***************************************************************
 *
 * Func: muestra_fase
 *
 * Description: 
 *   Muestra la fase de cada instrucción en el cronograma
 *
 **************************************************************/

void muestra_fase (
    char *	fase,
    ulong	orden
    )
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    int	o, c;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    if (Ciclo >= primer_ciclo + MAX_CICLOS)
        desplazamiento_horizontal();
    
    o= orden - primera_instruccion;
    c= Ciclo - primer_ciclo;
    
    if (o >= 0 && c >= 0) {
        strcpy(crono[o].fase[c], fase);
        if (c + 1 > maxima_columna_visible)
            maxima_columna_visible= c + 1;
    } /* endif */
    
} /* end muestra_fase */

/***************************************************************
 *
 * Func: actualiza_crono
 *
 * Description: 
 *   Actualiza el cronograma con el estado de las fases
 *
 **************************************************************/

void actualiza_crono ( )
{
    /*************************************/
    /*  Function body                    */
    /*************************************/

    if (!IFstall && !IFnop)
        muestra_fase("IF", orden);
    else if (IFstall)           /* IFstall */
        muestra_fase("<i>if</i>", orden);
    else                        /* IFnop */
        muestra_fase("<font color=\"red\">if</font>", orden);

    if (IF_ID.orden != -1)
        if (!IDstall && !IDnop)
            muestra_fase("ID", IF_ID.orden);
        else if (IDstall)       /* IDstall */
            muestra_fase("<i>id</i>", IF_ID.orden);
        else                        /* IDnop */
            muestra_fase("<font color=\"red\">id</font>", IF_ID.orden);

    if (ID_EX.orden != -1)
        if (!EXstall && !EXnop)
            muestra_fase("EX", ID_EX.orden);
        else if (EXstall)       /* EXstall */
            muestra_fase("<i>ex</i>", ID_EX.orden);
        else                    /* EXnop */
            muestra_fase("<font color=\"red\">ex</font>", ID_EX.orden);

    if (EX_MEM.orden != -1)
        muestra_fase("ME", EX_MEM.orden);

    if (MEM_WB.orden != -1)
        muestra_fase("WB", MEM_WB.orden);

} /* end actualiza_crono */

/***************************************************************
 *
 * Func: imprime_estado
 *
 * Desc: Imprime el estado de las estructuras de coma flotante
 *
 **************************************************************/

void imprime_estado ()
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    short		i= 0;

    char		aux[128];

    short		x, y;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    sprintf(aux, "estado%03d.html", Ciclo);
    f_salida= fopen(aux, "w");
    if (f_salida == NULL) {
        fprintf(stderr, "Error creando %s\n", aux);
        exit(1);
    } /* endif */

    /*** HTML INTRO ***/

    fprintf(f_salida, 
            "<html><head><title>%s. Ciclo %d</title></head>\n", 
            nombre_fich, Ciclo);
    fprintf(f_salida, 
            "<body bgcolor=\"white\">\n"); 

    if (Ciclo > 1) {
        fprintf(f_salida, "<a href=\"estado001.html\">INICIO</a>&nbsp;\n"); 
        fprintf(f_salida, "<a href=\"estado%03d.html\">ANT</a>&nbsp;\n", 
                Ciclo -1); 
        fprintf(f_salida, "<a href=\"estado%03d.html\">SIG</a>\n", Ciclo +1); 
    }
    else {
        fprintf(f_salida, "<!a href=\"estado001.html\">INICIO<!/a>&nbsp;\n"); 
        fprintf(f_salida, "<!a href=\"estado%03d.html\">ANT<!/a>&nbsp;\n", 
                Ciclo -1); 
        fprintf(f_salida, "<a href=\"estado%03d.html\">SIG</a>\n", Ciclo +1);    
    } /* endif */

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<a href=\"crono%03d.html\">Cronograma</a>\n", Ciclo);    

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<tt><b>Programa: %s</b></tt>\n", nombre_fich); 
    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<b>Ciclo: %d</b>\n", Ciclo); 

    fprintf(f_salida, "<br><br>\n"); 

    /*** Muestra etapas ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"white\">&nbsp;</td>\n");
    fprintf(f_salida, "<td width=112 align=center>--/IF</td>\n", i);
    fprintf(f_salida, "<td width=112 align=center>IF/ID</td>\n", i);
    fprintf(f_salida, "<td width=112 align=center>ID/EX</td>\n", i);
    fprintf(f_salida, "<td width=112 align=center>EX/MEM</td>\n", i);
    fprintf(f_salida, "<td width=112 align=center>MEM/WB</td>\n", i);
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ddeeff\">Instruc.</td>\n");

    imprime_instruccion(aux, PC); 
    fprintf(f_salida, "<td>%s</td>\n", aux);
    imprime_instruccion(aux, IF_ID.iPC); 
    fprintf(f_salida, "<td>%s</td>\n", aux);
    imprime_instruccion(aux, ID_EX.iPC); 
    fprintf(f_salida, "<td>%s</td>\n", aux);
    imprime_instruccion(aux, EX_MEM.iPC); 
    fprintf(f_salida, "<td>%s</td>\n", aux);
    imprime_instruccion(aux, MEM_WB.iPC); 
    fprintf(f_salida, "<td>%s</td>\n", aux);
    fprintf(f_salida, "</tr>\n");

/*     fprintf(f_salida, "</table><br>\n"); */

    /*** Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"white\"><td colspan=\"6\">&nbsp;</td></tr>\n");

/*     fprintf(f_salida, "<table>\n");  */

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ddeeff\">Señales</td>\n");

    if (IFstall == SI)  
        sprintf(aux, "IFstall ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (IDstall == SI)  
        sprintf(aux, "IDstall ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (MEMaEXalu_s == SI)  
      sprintf(aux, "MEMaEXalu_s ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);


    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");


    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (MEMaID == SI)  
        sprintf(aux, "MEMaID ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (MEMaEXalu_i == SI)  
      sprintf(aux, "MEMaEXalu_i ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);
  
    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (MEMaEXcomp == SI)  
      sprintf(aux, "MEMaEXcomp ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (WBaID == SI)  
        sprintf(aux, "WBaID ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (WBaEXalu_s == SI)  
      sprintf(aux, "WBaEXalu_s ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (WBaMEM == SI)  
      sprintf(aux, "WBaMEM ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);


    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (WBaEXalu_i == SI)  
      sprintf(aux, "WBaEXalu_i ");
    else
    sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);


    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (WBaEXcomp == SI)  
      sprintf(aux, "WBaEXcomp ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);


    /*** Mas Señales ***/

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=75 bgcolor=\"#ffffff\">&nbsp</td>\n");

    if (IFnop)  
        sprintf(aux, "IFnop ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (IDnop)  
        sprintf(aux, "IDnop ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (EXnop)  
      sprintf(aux, "EXnop ");
    else
      sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (MEMnop)  
        sprintf(aux, "WBnop ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

/*    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);

    if (0)  
        sprintf(aux, " ");
    else
        sprintf(aux, "&nbsp;");
    fprintf(f_salida, "<td width=100>%s</td>\n", aux);
*/
    fprintf(f_salida, "</tr>\n");
    fprintf(f_salida, "</table><br>\n");

    /*** Bancos de resgistros ***/

    fprintf(f_salida, "<p>Estado al final del ciclo\n"); 

    fprintf(f_salida, "<table>\n"); 

    /* Banco de registros enteros */

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "<td width=50 bgcolor=\"white\">&nbsp;</td>\n");
    for (i= 0; i<TAM_REGISTROS; i++) {
        fprintf(f_salida, "<td width=75 align=center>R%d</td>\n", i);
    } /* endfor */
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "<td width=50 bgcolor=\"#ddeeff\">valor</td>\n");
    for (i= 0; i<TAM_REGISTROS; i++) {
        fprintf(f_salida, "<td align=center>%d</td>\n", 
                Rint[i].valor);
    } /* endfor */
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "</table><br>\n"); 

    /*** Contenido de la memoria de datos ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "<td width=75>Dirección</td>\n");
    for (i= 0; i< 8; i++) {
        fprintf(f_salida, "<td width=75 align=center>+%d</td>\n", i*4);
    } /* endfor */
    fprintf(f_salida, "</tr>\n");

    for (i= SegDatos.inicio; i< SegDatos.final; i+= sizeof(word)) {
        if (i % 32 == 0) {
            fprintf(f_salida, "<tr align=center>\n");
            fprintf(f_salida, 
                    "<td bgcolor=\"#ddeeff\" align=right>%d</td>\n", i);
	} /* endif */

        sprintf(aux, "%d", MD.mword[dir_word(i)]);
        fprintf(f_salida, "<td>%s</td>\n", aux);

        if ((i+1) % 32 == 0) {
            fprintf(f_salida, "</tr>\n");
	} /* endif */
    } /* endfor */
  
    fprintf(f_salida, "</table><br>\n"); 

    fprintf(f_salida, "<address>Arquitectura de Computadores\n");
    fprintf(f_salida, "</address>\n");
    fprintf(f_salida, "</body></html>\n"); 

    fclose(f_salida);

} /* end imprime_estado */

/***************************************************************
 *
 * Func: imprime_crono
 *
 * Desc: Imprime el cronograma de ejecución
 *
 **************************************************************/

void imprime_crono ()
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    short		i= 0;
    char		aux[128];
    short		x, y;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    sprintf(aux, "crono%03d.html", Ciclo);
    f_salida= fopen(aux, "w");
    if (f_salida == NULL) {
        fprintf(stderr, "Error creando %s\n", aux);
        exit(1);
    } /* endif */

    /*** HTML INTRO ***/

    fprintf(f_salida, 
            "<html><head><title>Cronograma: %s. Ciclo %d</title></head>\n", 
            nombre_fich, Ciclo);
    fprintf(f_salida, 
            "<body bgcolor=\"white\">\n"); 

    if (Ciclo > 1) {
        fprintf(f_salida, "<a href=\"crono001.html\">INICIO</a>&nbsp;\n"); 
        fprintf(f_salida, "<a href=\"crono%03d.html\">ANT</a>&nbsp;\n", 
                Ciclo -1); 
        fprintf(f_salida, "<a href=\"crono%03d.html\">SIG</a>\n", Ciclo +1); 
    }
    else {
        fprintf(f_salida, "<!a href=\"crono001.html\">INICIO<!/a>&nbsp;\n"); 
        fprintf(f_salida, "<!a href=\"crono%03d.html\">ANT<!/a>&nbsp;\n", 
                Ciclo -1); 
        fprintf(f_salida, "<a href=\"crono%03d.html\">SIG</a>\n", Ciclo +1);    
    } /* endif */

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<a href=\"estado%03d.html\">Estado</a>\n", Ciclo);    

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<tt><b>Programa: %s</b></tt>\n", nombre_fich); 
    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<b>Ciclo: %d</b>\n", Ciclo); 
    fprintf(f_salida, "<br>\n"); 

    fprintf(f_salida, "<p>Estado al final del ciclo\n"); 

    /*** Cronograma de ejecución ***/

    fprintf(f_salida, "<table>\n"); 
  
    fprintf(f_salida, "<tr bgcolor=\"#ccddff\" align=\"center\">\n"); 
    fprintf(f_salida, "  <td width=\"150\">Instruc.</td>\n");
    for (x= 0; x< MAX(MAX_CICLOS_INIC, maxima_columna_visible); x++)
        fprintf(f_salida, "  <td width=\"25\">%d</td>\n", 
                x+primer_ciclo); 
    fprintf(f_salida, "</tr>\n"); 

    for (y= 0; y< MAX_INSTRUC; y++) {
        if (y % 2 == 0)
            fprintf(f_salida, "<tr bgcolor=\"#eeeeee\" align=\"center\">\n"); 
        else
            fprintf(f_salida, "<tr bgcolor=\"#dddddd\" align=\"center\">\n"); 
	
        if (!strlen(crono[y].inst))
            if (y % 2 == 0)
                fprintf(f_salida, 
                        "  <td bgcolor=\"#ddeeff\">&nbsp;</td>\n");
            else
                fprintf(f_salida, 
                        "  <td bgcolor=\"#ccddff\">&nbsp;</td>\n");
        else
            if (y % 2 == 0)
                fprintf(f_salida, 
                        "  <td align=\"left\" bgcolor=\"#ddeeff\">%s</td>\n", 
                        crono[y].inst); 
            else
                fprintf(f_salida, 
                        "  <td align=\"left\" bgcolor=\"#ccddff\">%s</td>\n", 
                        crono[y].inst); 

        for (x= 0; x< MAX(MAX_CICLOS_INIC, maxima_columna_visible); x++) {
            fprintf(f_salida, "  <td>"); 

            if (strlen(crono[y].fase[x]))
                fprintf(f_salida, crono[y].fase[x]); 
            else
                fprintf(f_salida, "&nbsp;"); 

            fprintf(f_salida, "</td>\n"); 
	} /* endfor */
        fprintf(f_salida, "</tr>\n"); 
    } /* endfor */

    fprintf(f_salida, "</table>\n"); 

    fprintf(f_salida, "<address>Arquitectura de Computadores\n");
    fprintf(f_salida, "</address>\n");
    fprintf(f_salida, "</body></html>\n"); 

    fclose(f_salida);

} /* end imprime_crono */

/***************************************************************
 *
 * Func: imprime_inicio
 *
 * Desc: Imprime el cronograma de ejecución
 *
 **************************************************************/

void imprime_inicio ()
{
    /*************************************/
    /*  Local variables                  */
    /*************************************/

    short		i= 0;

    char		aux[128];

    short		x, y;

    /*************************************/
    /*  Function body                    */
    /*************************************/

    sprintf(aux, "index.html");
    f_salida= fopen(aux, "w");
    if (f_salida == NULL) {
        fprintf(stderr, "Error creando %s\n", aux);
        exit(1);
    } /* endif */

    /*** HTML INTRO ***/

    fprintf(f_salida, 
            "<html><head><title>dlxfp-html: %s. Ciclo %d</title></head>\n", 
            nombre_fich, Ciclo);
    fprintf(f_salida, 
            "<body bgcolor=\"white\">\n"); 

    fprintf(f_salida, "<a href=\"estado%03d.html\">Estado</a>\n", 1);    

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<a href=\"crono%03d.html\">Cronograma</a>\n", 1);    

    fprintf(f_salida, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n"); 
    fprintf(f_salida, "<tt><b>Programa: %s</b></tt>\n", nombre_fich); 
    fprintf(f_salida, "<br>\n"); 
    fprintf(f_salida, "<br>\n"); 

    /*** Datos de la implementación ***/

    /*** Estructuras ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "  <td>Estructura</td>\n");
    fprintf(f_salida, "  <td align=\"center\">Número</td>\n");
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "<tr bgcolor=\"#eeeeee\">\n");
    fprintf(f_salida, "  <td bgcolor=\"#ddeeff\">Registros</td>\n");
    fprintf(f_salida, "  <td align=\"center\">%d</td>\n", TAM_REGISTROS);
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "</table><br>\n"); 

    /*** Memorias ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr valign=\"top\" bgcolor=\"#ddeeff\">\n");
    fprintf(f_salida, "  <td>Memoria&nbsp;de&nbsp;datos</td>\n");
    fprintf(f_salida, "  <td>Memoria&nbsp;de&nbsp;instrucciones</td>\n");
    fprintf(f_salida, "</tr>\n");

    fprintf(f_salida, "<tr valign=\"top\"><td>\n");

    /*** Contenido de la memoria de datos ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "  <td width=75>Dirección</td>\n");
    fprintf(f_salida, "  <td width=75>Datos</td>\n");
    fprintf(f_salida, "</tr>\n");

    for (i= SegDatos.inicio; i< SegDatos.final; i+= sizeof(word)) {
        fprintf(f_salida, "<tr>\n");
        fprintf(f_salida, "  <td align=\"right\" bgcolor=\"#ddeeff\">"
                "%d&nbsp;&nbsp;&nbsp;&nbsp;</td>\n", i);
        fprintf(f_salida, "  <td align=\"right\" bgcolor=\"#eeeeee\">%d</td>\n", 
                MD.mword[dir_word(i)]);
        fprintf(f_salida, "</tr>\n");

    } /* endfor */
  
    fprintf(f_salida, "</table>\n"); 

    fprintf(f_salida, "</td><td>\n");

    /*** Contenido de la memoria de instrucciones ***/

    fprintf(f_salida, "<table>\n"); 

    fprintf(f_salida, "<tr bgcolor=\"#ccddff\">\n");
    fprintf(f_salida, "  <td width=75>Dirección</td>\n");
    fprintf(f_salida, "  <td width=200>Instrucciones</td>\n");
    fprintf(f_salida, "</tr>\n");

    for (i= SegInstruc.inicio; i< SegInstruc.final; i++) {
        fprintf(f_salida, "<tr>\n");
        fprintf(f_salida, "  <td align=\"right\" bgcolor=\"#ddeeff\">"
                "%d&nbsp;&nbsp;&nbsp;&nbsp;</td>\n", i);
        imprime_instruccion(aux, i);
        fprintf(f_salida, "  <td bgcolor=\"#eeeeee\">%s</td>\n", aux);
        fprintf(f_salida, "</tr>\n");
    } /* endfor */
  
    fprintf(f_salida, "</table>\n"); 

    fprintf(f_salida, "</td></tr>\n");
    fprintf(f_salida, "</table><br>\n"); 

    fprintf(f_salida, "<address>Arquitectura de Computadores\n");
    fprintf(f_salida, "</address>\n");
    fprintf(f_salida, "</body></html>\n"); 

    fclose(f_salida);

} /* end imprime_inicio */
