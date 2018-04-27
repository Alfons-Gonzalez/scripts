# que es el que haura de fer l'script

# obtenir el jobid (com sera un epilog, aixo ho ha de tenir com variable, check doc)

# obtenir el node d'execucio (idem)

# Obtenir la llista de PIDs associats 
# caldra fer un ssh al node d'execucio (es pot fer que l'epilog s'executi al node, pero si falla quelcom el deixa en drain i no mola, aixi que de moment farem que sigui el master qui faci la feina)

llista=`ssh $node "scontrol listpids $jobid" | awk '{print $1}'`

# comprovar els pid i quedar-nos amb el que correspon al sshfs

muntatge=`for proces in $llista; do ssh $node "ps -p $proces 2>err"; done | grep sshfs | awk {'print $1'}`

# verificar que al node ja no hi es al cap d'una estona 

sleep 10

usuari=`ssh $node "ps -u -p $muntatge | tail -1 | awk {'print $1'}`
comanda=`ssh $node "ps -u -p $muntatge | tail -1 | awk {'print $11'`
filesistem=`ssh $node "ps -u -p $muntatge | tail -1 | awk {'print $12'}`
puntdemuntatge=`ssh $node "ps -u -p $muntatge | tail -1 | awk {'print $13'}`

# si hi es desmuntar-ho

if [ -z "$puntdemuntatge" ]; then
	su - $usuari -c 'fusermount $puntdemuntatge' 
fi

# Nota 1: revisar l'script abans de posar-ho a l'epilog i fer alguna prova manual

# Nota 2:  al SIT caldra modificar alguna cosa pq
# - per fer anar fusermount cal fer module load sshfs
# - fusermount es fusermount3
# - alguna altra cosa pot ser diferent respecte hydra 





