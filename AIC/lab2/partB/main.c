/**************************************************************************
 * 
 * Departamento de Informática de Sistema y Computadores (DISCA)
 * Universidad Politécnica de Valencia.                         
 * 
 * Author: Sergio Sáez (ssaez@disca.upv.es)
 *	   Pedro López (plopez@gap.upv.es)
 * 
 * File: main.c
 *  
 * Description: 
 *    Módulo principal del simulador
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

#define main_C

/***** Includes ***********************************************/

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"

/*** Definiciones Externas *************************************************/

#include "tipos.h"
#include "instrucciones.h"
#include "mips.hi"

extern void ensamblador (FILE*);

/*** Variables Globales ****************************************************/

extern int pos_datos;

/*** Variables Locales *****************************************************/

static instruccion_t	ultima_intruc;
static word		ultimo_PC;

/*** Funciones Locales *****************************************************/


/***************************************************************
 *
 * Func: inicializa_mips
 *
 * Desc: Inicializa las estructuras del mips
 *
 **************************************************************/

static void inicializa_mips (
    )

{
    /*************************************/
    /*  Variables locales                */
    /*************************************/

    int		i;
    instruccion_t instr;

    /*************************************/
    /*  Cuerpo función                   */
    /*************************************/

    /* Registros */

    PC = 0;

    for (i=0; i<TAM_REGISTROS; i++)
    {
        Rint[i].valor= 0;
    } /* endfor */

    /* Memoria de datos */

    for (i=0; i< TAM_MEMO_DATOS; i+= sizeof(word))
    {
        MD.mword[dir_word(i)]= 0;
    } /* endfor */

    /* Memoria de instrucciones */

    for (i=0; i<TAM_MEMO_INSTRUC; i++)
    {
        MI[i].codop= OP_TRAP;	/* Cuando el programa encuentre una
				   instruccion del tipo TRAP 0
				   terminará */
        MI[i].tipo= FormatoI;
        MI[i].Rdestino= 0;
        MI[i].Rfuente1= 0;
        MI[i].Rfuente2= 0;
        MI[i].inmediato= 0;
    } /* endfor */

    /* Registros intermedios */

    instr.codop= OP_NOP;
    instr.tipo= FormatoR;
    instr.Rdestino= 0;
    instr.Rfuente1= 0;
    instr.Rfuente2= 0;
    instr.inmediato= 0;

    IF_ID.IR = instr;
    IF_ID.NPC = 0;  
    IF_ID.iPC = -1;  
    IF_ID.orden = 0;  

    ID_EX.IR = instr;
    ID_EX.NPC = 0;
    ID_EX.Ra = 0;
    ID_EX.Rb = 0;
    ID_EX.Imm = 0;
    ID_EX.iPC = -1;  
    ID_EX.orden = -1;  

    EX_MEM.IR = instr;
    EX_MEM.ALUout = 0;
    EX_MEM.data = 0;
    EX_MEM.cond = NO;
    EX_MEM.iPC = -1;  
    EX_MEM.orden = -1;  

    MEM_WB.IR = instr;
    MEM_WB.ALUout = 0;
    MEM_WB.MEMout = 0;
    MEM_WB.iPC = -1;  
    MEM_WB.orden = -1;  
 
    IFstall = NO;
    IDstall = NO;
  
} /* end inicializa_mips */


/***************************************************************
 *
 * Func: ejecutar_codigo
 *
 *
 * Retorna:  RC  (int) 
 *
 * Descripción: 
 *   Ejecuta el bucle principal del computador
 *
 **************************************************************/

static int ejecutar_codigo (  
    )

{
    /*************************************/
    /*  Variables locales                */
    /*************************************/

    int		RC;	/* Valor de retorno */

    boolean	final = NO;
/*  boolean	html = NO; */
  
    /*************************************/
    /*  Cuerpo función                   */
    /*************************************/

    RC= 0;
  
    /*** Inicializacion del computador */

    Ciclo= 0;
    orden= 1;

    imprime_inicio();

    /*** Bucle principal */

    while (!final)
    {
        /*** Enteros ******************************/

        /*** Fase: WB **************/

        final = fase_escritura ();

        /*** Fase: MEM **************/

        fase_memoria ();

        /*** Fase: EX *************/

        fase_ejecucion ();

        /*** Fase: ID **************/

        fase_decodificacion ();

        /*** Fase: IF ***********/

        fase_busqueda();
	
        /* Incrementa el número de ciclos ejecutados */

        Ciclo++;			

        /*** Imprime el estado -- interfaz de texto  */
        if (salida == res_ciclo) {
            imprime_etapas ();  
            imprime_reg (); 
            imprime_memdatos (); 
        }	


        if ((Ciclo >= MAX_CICLOS_HTML) && (salida==html))
        {
            fprintf(stderr, 
                    "\nERROR: Salida de emergencia (html). "
                    "Número de ciclos excesivo\n"
                    "NO olvides borrar los archivos *.html\n\n");
            /* if (salida_texto != res_no) html = NO; *//* y continuamos en modo texto */
            /* else */
            exit(1); 
        } 

        if ((Ciclo >= MAX_CICLOS_TXT) && (salida != html))
        {
            fprintf(stderr, 
                    "ERROR: Salida de emergencia (texto). "
                    "Número de ciclos excesivo\n");
            exit(1);
        } 

        /*** Imprime el estado del los operadores, etc.  */

        if (salida==html)
        {
            imprime_estado ();
            actualiza_crono ();
            imprime_crono ();
        }
 
        impulso_reloj();


    } /* endwhile */

    if (salida == res_final) {
        fprintf(stdout, "Nº de ciclos: %d \n",Ciclo);  
        imprime_reg (); 
        imprime_memdatos (); 
    }	

 
    return (RC);

} /* end ejecutar_codigo */

/*** Funciones Exportables *************************************************/

/***************************************************************
 *
 * Func: main
 *
 * Parametros:
 *	argc  (int) ; Número de parametros en linea
 *	argv[]  (char*) ; Texto de los parametros en linea
 *
 * Retorna:  RC  (int) 
 *
 * Descripción: 
 *   Función principal
 *
 **************************************************************/

int main (  
    int	argc,
    char*	argv[]
    )

{
    /*************************************/
    /*  Variables locales                */
    /*************************************/

    int		RC;	/* Valor de retorno */

    int		i;

    char *	uso= 
        "\n%s -s salida -d riesgos_datos -c riesgos_control -f fichero.s\n"
        "\tsalida    ciclo final html(*)\n"
        "\tr.datos   n:ninguno(*), p:parada, c:cortocircuito\n"
        "\tr.control p:parada(*), t:p-n-taken, 3:ds=3, 2:ds=2, 1:ds=1\n"
        "\tfichero	Nombre del fichero en ensamblador\n"
        "";  

    boolean	arg_correctos = 0;  
  
    FILE*		f_entrada= NULL;

    /*************************************/
    /*  Cuerpo función                   */
    /*************************************/

    /*** Lectura de parametros */

    solucion_riesgos_datos = ninguno;
    solucion_riesgos_control = stall;
    salida = html;
  
  
    if (argc == 1)
    {
        fprintf(stderr, uso, argv[0]);
        exit(1);
    }
  
    for (i = 1 ; i < argc; i++) {
  
        if (strncmp(argv[i],"-d",2) == 0) {
            if (i<argc-1) {
                if (strncmp(argv[i+1],"n",1) == 0) {
                    solucion_riesgos_datos = ninguno;
                } else if (strncmp(argv[i+1],"p",1) == 0) {
                    solucion_riesgos_datos = parada;
                } else if (strncmp(argv[i+1],"c",1) == 0) {
                    solucion_riesgos_datos = cortocircuito;
                } else {
                    fprintf(stderr, "\nError en argumento -d\n");
                    fprintf(stdout, uso, argv[0]);
                    exit(1);
                }
            } else if (i>=argc-1) {
                fprintf(stderr, "\nError en argumento -d\n");
                fprintf(stderr, uso, argv[0]);
                exit(1);
            }
        } 
	
        if (strncmp(argv[i],"-c",2) == 0) {
            if (i<argc-1) {
                if (strncmp(argv[i+1],"3",1) == 0) {
                    solucion_riesgos_control = ds3;
                } else if (strncmp(argv[i+1],"2",1) == 0) {
                    solucion_riesgos_control = ds2;
                } else if (strncmp(argv[i+1],"1",1) == 0) {
                    solucion_riesgos_control = ds1;
                } else if (strncmp(argv[i+1],"t",1) == 0) {
                    solucion_riesgos_control = pnt;
                } else if (strncmp(argv[i+1],"p",1) == 0) {
                    solucion_riesgos_control = stall;
                } else {
                    fprintf(stderr, "\nError en argumento -c\n");
                    fprintf(stderr, uso, argv[0]);
                    exit(1);
                }
            } else if (i>=argc-1) {
                fprintf(stderr, "\nError en argumento -c\n");
                fprintf(stderr, uso, argv[0]);
                exit(1);
            }
        } 


        if (strncmp(argv[i],"-s",2) == 0) {
            if (i<argc-1) {
                if (strncmp(argv[i+1],"html",1) == 0) {
                    salida = html;
                } else if (strncmp(argv[i+1],"ciclo",1) == 0) {
                    salida = res_ciclo;
                } else if (strncmp(argv[i+1],"final",1) == 0) {
                    salida = res_final;
                } else {
                    fprintf(stderr, "\nError en argumento -s\n");
                    fprintf(stderr, uso, argv[0]);
                    exit(1);
                }
            } else if (i>=argc-1) {
                fprintf(stderr, "\nError en argumento -t\n");
                fprintf(stderr, uso, argv[0]);
                exit(1);
            }
        }


        if (strncmp(argv[i],"-f",2) == 0) {
            if (i<argc-1) {
                f_entrada= fopen(argv[i+1], "r");
                if (f_entrada == NULL)
                {
                    fprintf(stderr, "\n%s: Error abriendo fichero '%s' \n",
                            argv[0], argv[i+1]);
                    fprintf(stderr, uso, argv[0]);
                    exit(1);
                } else {
                    arg_correctos = 1;
                } /* endif */
            } else if (i>=argc-1) {
                fprintf(stderr, "\nFalta nombre del fichero\n");
                fprintf(stderr, uso, argv[0]);
                exit(1);
            }
        } 
 
    } /* end for */

    if (!arg_correctos) {
  	fprintf(stderr, "\nFalta nombre del fichero\n");
  	fprintf(stderr, uso, argv[0]);
  	exit(1);
    };

    switch (salida) {
      case html:
             fprintf(stdout, "\nSalida html");
             break;
      case res_ciclo:
             fprintf(stdout, "\nSalida texto: ciclo a ciclo");
             break;
      case res_final :   
             fprintf(stdout, "\nSalida texto: resultados finales");
    };
 

    switch (solucion_riesgos_datos) {
      case ninguno:
             fprintf(stdout, "\nRiesgos de datos: Ninguno");
             break;
      case parada:
             fprintf(stdout, "\nRiesgos de datos: Ciclos de parada");
             break;
      case cortocircuito:   
             fprintf(stdout, "\nRiesgos de datos: Cortocircuito");
    };


    switch (solucion_riesgos_control) {
      case ds3:
             fprintf(stdout, "\nRiesgos de control: Salto retardado (DS=3)");
             break;
      case ds2:
             fprintf(stdout, "\nRiesgos de control: Salto retardado (DS=2)");
             break;
      case ds1:
             fprintf(stdout, "\nRiesgos de control: Salto retardado (DS=1)");
             break;
      case pnt:
             fprintf(stdout, "\nRiesgos de control: Predict-not-taken");
             break;
      case parada:   
             fprintf(stdout, "\nRiesgos de control: Ciclos de parada");
    };


    fprintf(stdout, "\n\n");
    
    /*** Inicializacion de estructuras */

    inicializa_mips ();

    /*** Carga el codigo en lenguaje ensamblador */

    ensamblador (f_entrada);

    /*** Llama al bucle principal */

    RC= ejecutar_codigo ();

    return (RC);

} /* end main */

