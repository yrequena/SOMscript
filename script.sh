#!/bin/bash
#Script By: JCRequena

#     
# Declaración de FUNCIONES
#   

fntCrearBasedeDatos() {
        mkdir "Reserva de aulas"
        for i in {01..12}
        do
                mkdir "Reserva de aulas"/$i
                for j in {01..31}$i"20"
                do
                        touch "Reserva de aulas"/$i/$j
                done
        done
        echo "Base de datos creada correctamente"
}

fntComprobarBasedeDatos() {

       echo  "Comprobando si existe una base de datos..."
	RDA="Reserva de aulas"
	if [ -d "$RDA" ]
	then 
		echo "Existe una base de datos"
	else
		echo "No existe una base de datos"
		read -p "¿Desea crear una ahora? [s/n]" respuesta1
		case $respuesta1 in
		s|S)
			 fntCrearBasedeDatos
		;;
		n|N)
			 echo "Puedes crear la base de datos desde el Menú"
		;;
		*)
			 echo $respuesta1 "no es un término válido"
		;;
		esac
	fi
}

fntCrearreserva() {
        echo "*********************Introduzca los datos de la reserva*********************"
	echo ""
	read -p "Indica el mes de la reserva [01-12]: " mes
	if [ $mes -le 12 ]
	then
		cd "Reserva de aulas"/$mes
		echo "*********"
		read -p "Indica el día de la reserva [01-31]: " dia
                echo "*********"
		read -p "Hora de la reserva [00-23]: " hora
                echo "*********"
		read -p "Minuto de la reserva [00-59]: " minuto
                echo "*********"
		read -p "Descripción de la reserva: " descripcion
                echo "*********"
		read -p "Profesor/a a cargo: " profesor
                echo "*********"
		read -p "Grupo de clase: " clase
                echo "*********"
		read -p "Sesiones: " sesion
                echo "*********"
		read -p "Aulas: " aula
                echo "*********"
		echo "H:"$hora":"$minuto";""D:"$descripcion";""R:"$profesor";""G:"$clase";""S:"$sesion";""A:"$aula
		read -p "¿Es correcta la información introducida? [s/n]: " respuesta2

			case $respuesta2 in
			s|S)
				echo "H:"$hora":"$minuto" ; ""D:"$descripcion" ; ""R:"$profesor" ; ""G:"$clase" ; ""S:"$sesion" ; ""A:"$aula >> $dia$mes"20"
			;;
			n|N)	
				echo "Es necesario que vuelva a introducir todos los datos"
			;;
			*)
				echo $respuesta2 "No es una respuesta válida, debe volver a introducir los datos"
			;;
			esac

		cd ../..

	else
		echo "Introduce un número entre [01-12]"
		echo "Recuerda introducir un 0 en valores de un solo dígito"
	fi


} 

fntConsultarreservas() {

	clear
	echo "*****************************************************************************"
	echo "····························  Menú de consultas  ····························"
	echo "*****************************************************************************"
	echo "1. Visualiza las [n] primeras/últimas reservas de un día concreto."
	echo "2. Visualiza las reservas que se hayan realizado por un grupo concreto."
	echo "3. Visualiza las reservas que se hayan realizado en un aula en concreto."
	echo "4. Visualiza las reservas que tengan una duración de [n] sesiones."
	echo "5. Visualiza los campos [Profesor/a] y [Descripción]"
	echo "6. Visualiza todas las reservas con el campo [Descripción] vacío."
	echo "7. Visualiza todas las reservas para un mes en concreto."
	echo "8. Ordena las reservas de un día en concreto por el campo [Hora]."
	echo "9. Volver al menú principal."
	echo "****************************************************************************"

        read -p "Seleccione la operacion a realizar [1-9]: " menu
        case $menu in
        1) 
                read -p "¿Desea visualizar las primeras o las últimas reservas? [p/u] " opcion1pu
		read -p "Elige el mes que desea visualizar: " opcion1mes
		read -p "Elige el día que desea visualizar: " opcion1dia
		read -p "Elige el número de reservas que desa ver: " opcion1num
		cd "Reserva de aulas"/$opcion1mes

		echo "El resultado obtenido es: "
		if [ $opcion1pu = p ]
		then
			head -n $opcion1num $opcion1dia$opcion1mes"20"
			echo "Pulsa Enter para continuar"
		else
			tail -n $opcion1num $opcion1dia$opcion1mes"20"
			echo "Pulsa Enter para continuar"

		fi
		cd ../..
			read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
	                case $opcionmenu2 in
        	                s|S)
                	                fntConsultarreservas
                	        ;;
                       		 n|N)
                                	fntmostrarMenu
                        	;;
                        	*)
                                	echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                	fntConsultarreservas
                        	;;
               		 esac
                ;;

        2) 
		read -p "¿Sobre que grupo desea realizar la búsqueda?: " opcion2
		find "Reserva de aulas" | grep -r "G:"$opcion2 "Reserva de aulas"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
                ;;
        3) 
                read -p "¿Sobre que aula desea realizar la búsqueda?: " opcion3
                find "Reserva de aulas" | grep -r "A:"$opcion3 "Reserva de aulas"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
		;;
        4) 
                read -p "¿De cuantas sesiones desea realizar la búsqueda?: " opcion4
                find "Reserva de aulas" | grep -r "S:"$opcion4 "Reserva de aulas"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
		;;
	5) 
                read -p "¿En que mes desea realizar la búsqueda?: " opcion5mes
		read -p "¿En que día desea realizar la búsqueda?: " opcion5dia
		echo $opcion5dia"-"$opcion5mes"-20"
		cut -d";" -f2,3 "Reserva de aulas"/$opcion5mes/$opcion5dia$opcion5mes"20"
#		find "Reserva de aulas" | egrep -o "D:\w* | R:\w*" "Reserva de aulas"/$opcion5mes/$opcion5dia$opcion5mes"20"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
                ;;
        6) 
		find "Reserva de aulas" | grep -r "D: " "Reserva de aulas"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo $opcionmenu2 "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
                ;;
        7) 
		read -p "¿De que mes desea ver las reservas? " opcion7
                find "Reserva de aulas" | grep -rh "H:" "Reserva de aulas"/$opcion7
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
                ;;
        8) 	read -p "¿De que mes desea realizar la consulta de reservas? " opcion8mes
		read -p "¿De que día? " opcion8dia
		find "Reserva de aulas" | grep -rh "H:*" | sort -g "Reserva de aulas"/$opcion8mes/$opcion8dia$opcion8mes"20"
                        read -p "¿Desea seguir en el menú de consultas? [s/n] " opcionmenu2
                        case $opcionmenu2 in
                                s|S)
                                        fntConsultarreservas
                                ;;
                                 n|N)
                                        fntmostrarMenu
                                ;;
                                *)
                                        echo "Error: " $opcionmenu2 " No es una respuesta válida"
                                        fntConsultarreservas
                                ;;
                         esac
                ;;
	9) 
                clear
                echo "Volviendo al menú principal..."
		fntmostrarMenu
                ;;
        *) 
                echo "Error: Seleccione una opcion valida [1-9]!"
                ;;
        esac
        read -p "Press [Enter] key to continue..."



}

fntBorrarBasedeDatos() {

	read -p "ALERTA: ¿Desea continuar con la opción de borrar? [s/n] " borrado1
	case $borrado1 in
		s|S)
			read -p "¿Desea borrar un las reservas de un mes [m] o las reservas de un día en concreto [d]? " borrado2
			case $borrado2 in
				m|M)
					read -p "¿De que mes desea borrar las reservas? [01-12] " borradom
						rm -r "Reserva de aulas"/$borradom
						mkdir "Reserva de aulas"/$borradom
						touch "Reserva de aulas"/$borradom/{01..31}$borradom"20"
					read -p "¿Desea seguir borrando archivos? [s/n] " borrado3
					case $borrado3 in
						s|S)
							fntBorrarBasedeDatos
						;;
						n|N)
							fntmostrarMenu
						;;
						*)
							echo "Error: "$borrado3 " No es una respuesta válida."
							fntmostrarMenu
						;;
					esac
				;;
				d|D)
					read -p "¿A que mes pertenecen las reservas? " borradom2
					read -p "¿Las reservas de que día desea borrar? " borradod
						echo "" > "Reserva de aulas"/$borradom2/$borradod$borradom2"20"
					case $borrado3 in
                                                s|S)
                                                        fntBorrarBasedeDatos
                                                ;;
                                                n|N)
                                                        fntmostrarMenu
                                                ;;
                                                *)
                                                        echo "Error: "$borrado3 " No es una respuesta válida."
                                                        fntmostrarMenu
                                                ;;
                                        esac

				;;
				*)
					echo "Error: " $borrado2 " No es una respuesta válida"
					fntBorrarBasedeDatos
				;;
			esac
		;;
		n|N)
			fntmostrarMenu
		;;
		*)
			echo "Error: " $borrado1 " No es una respuesta válida"
			fntBorrarBasedeDatos
		;;
		esac
}

fntComprimirBasedeDatos() {

	read -p "¿Desea empaquetar y comprimir la Base de datos? [s/n] " comprimir
	case $comprimir in
		 s|S)
                        tar -czf "Reserva de aulas.tgz" "Reserva de aulas"
                ;;
		 n|N)
                        fntmostrarMenu
                ;;
		 *)
                	echo "Error: " $comprimir " No es una respuesta válida"
			fntComprimirBasedeDatos
                ;;

	esac
}


fntmostrarMenu () {
        clear
        echo "Bienvenido " $LOGNAME
        echo "╦═╗┌─┐┌─┐┌─┐┬─┐┬  ┬┌─┐  ┌┬┐┌─┐  ┌─┐┬ ┬┬  ┌─┐┌─┐
╠╦╝├┤ └─┐├┤ ├┬┘└┐┌┘├─┤   ││├┤   ├─┤│ ││  ├─┤└─┐
╩╚═└─┘└─┘└─┘┴└─ └┘ ┴ ┴  ─┴┘└─┘  ┴ ┴└─┘┴─┘┴ ┴└─┘ "
	echo ""
        echo "*******************	Menu	*******************"
        echo "_____________________________________________________"
        echo ""
        echo "1)" "Crear Base de datos [directorios+ficheros]"
        echo "2)" "Comprobar si existe una base de datos"
        echo "3)" "Crear Reservas"
        echo "4)" "Consultar Reservas"
        echo "5)" "Eliminar Reservas"
        echo "6)" "Comprimir Base de datos"
        echo "7)" "Consultar Reservas"
        echo "_____________________________________________________"


}


                                           ####################
#------------------------------------------#PROGRAMA PRINCIPAL#---------------------------------------------

#     ##################
#-------MENÚ PRINCIPAL---
#     ##################

# Bucle while infinito, ya que la variable opcion simpre será distinto de ""
# Salimos del bucle con el comando 'exit' --> al pulsar la opción 4
#
while [ opcion != "" ]
do
	
	fntmostrarMenu
	read -p "Seleccione la operacion a realizar [1-9]: " opcion
	#Comprueba si el valor recogido en opcion es 1,2,3 o 4, si es otra cosa, se ejecuta *)
    	case $opcion in
    	1) 
		fntCrearBasedeDatos
       		;;
    	2) 
		fntComprobarBasedeDatos	   
       		;;
    	3) 
		fntCrearreserva
        	;;
	4) 
		fntConsultarreservas
		;;
    	5) 
		fntBorrarBasedeDatos
		;;
	6) 
		fntComprimirBasedeDatos
		;;
	7) 
		clear
		echo "Saliendo de la App....."
	 	exit
        	;;
    	*) 
		echo "Error: Seleccione una opcion valida [1-4]!"
		;;
   	esac
	read -p "Press [Enter] key to continue..."
done
