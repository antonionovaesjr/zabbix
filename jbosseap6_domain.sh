#!/bin/bash
# Criado por Antonio Novaes

# diretório do jdk usado pelo jboss
export JAVA_HOME="/path/jdk"

#localização do diretório BIN do jboss em execução
export PATH_JBOSS_CLI="/path/jboss-eap-6.2/bin/"

#Usuáro deve ser criado no domain master
USUARIO='zabbix'
SENHA='zabbix123'

# o tipo de item que será monitorado
export OBJETO="$1"
# nomeo do host que está executando a aplicação
export CONTROLLER="$2"

# portal cli usada para se conectar com o manager
export PORT_CLI="$3"

# nome do datasource utilizada pela aplicação
export DATASOURCE="$4"

# nome do host que é exibido no manager do jboss
export HOST="$5"

# nome da instância que executa a aplicação
export INSTANCIA="$6"

#Item a ser coletada, no caso do APP_EAR deve ser o nome do pacote ear, e no caso do APP_WAR o nome pacote war
export ITEM="$7"

# para monitorar o datasource, é preciso habilitar a estatística
if [ $OBJETO == 'datasource' ]; then


  case $ITEM in

	ActiveCount)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=ActiveCount)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	AvailableCount)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI  --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=AvailableCount)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	ActiveCount)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI  --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=ActiveCount)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	MaxUsedCount)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI  --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=MaxUsedCount)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	TimedOut)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI  --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=TimedOut)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	InUseCount)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI  --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/subsystem=datasources/data-source=$DATASOURCE/statistics=pool:read-attribute(name=InUseCount)"|grep result|awk '{print $3}'|cut -d\" -f2
;;

	*)
		echo "Item não encontrado"
	;;

esac

fi


if [ $OBJETO == 'jvm-heap' ]; then


  case $ITEM in

	init)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=heap-memory-usage)"|grep init|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	used)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=heap-memory-usage)"|grep used|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	committed)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=heap-memory-usage)"|grep committed|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	max)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=heap-memory-usage)"|grep max|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	*)
		echo "Item não encontrado"
	;;

esac

fi


if [ $OBJETO == 'jvm-non-heap' ]; then


  case $ITEM in

	init)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=non-heap-memory-usage)"|grep init|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	used)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=non-heap-memory-usage)"|grep used|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	committed)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=non-heap-memory-usage)"|grep committed|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	max)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/core-service=platform-mbean/type=memory:read-attribute(name=non-heap-memory-usage)"|grep max|awk '{print $3}'|cut -d\" -f2|cut -d\L -f1
;;

	*)
		echo "Item não encontrado"
	;;

esac

fi

if [ $OBJETO == 'sessions' ]; then


  case $ITEM in

	active-sessions)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/deployment=$APP_EAR/subdeployment=$APP_WAR/subsystem=web:read-attribute(name=active-sessions)"|grep result|awk '{print $3}'
;;

	rejected-sessions)
		$PATH_JBOSS_CLI/jboss-cli.sh -c --controller=$CONTROLLER:$PORT_CLI --user=$USUARIO --password=$SENHA --command="/host=$HOST/server=$INSTANCIA/deployment=$APP_EAR/subdeployment=$APP_WAR/subsystem=web:read-attribute(name=rejected-sessions)"|grep result|awk '{print $3}'
;;


	*)
		echo "Item não encontrado"
	;;

esac

fi
