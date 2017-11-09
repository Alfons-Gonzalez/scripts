LDAP_HOST=sit-ldap.s.upf.edu
LOGIN=
echo -e "ELIMINAR USUARI AL GRUP SITCLUSTER\n";
cat <<EOF | ldapmodify -x -h ${LDAP_HOST} -D "cn=admin,dc=upf,dc=edu" -w O,esmLdS.4
dn: cn=sitcluster,ou=Machines,dc=upf,dc=edu
changetype: modify
delete: memberUid
memberUid: uid=${LOGIN},ou=Users,dc=upf,dc=edu
EOF


