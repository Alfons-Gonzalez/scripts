#!/bin/sh
#
# Jugando con funciones en shell
#
UN_SEGUNDO=1

fun1 ()
{ # La funcion mas sencilla.
  echo "Esto es una funcion."
  echo "Salimos de la funcion."
} # Acaba la definicion


fun2 ()
{ # Una funcion + completa.
  i=1
  LIMITE=31

  echo
  echo "Ahora la funcion 2."
  echo

  sleep $UN_SEGUNDO    # 
  while [ $i -lt $LIMITE ]
  do
    echo "--------------------"
    echo "$i"
    echo "--------------------"
    echo
    let "i+=1"
  done
}

  # Llamo a las funciones.

fun1
fun2

exit 0 # Salimos del script
