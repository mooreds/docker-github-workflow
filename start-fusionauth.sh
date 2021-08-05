POSTGRESUSER=$1
POSTGRESPASS=$2
FAVERSION=$3

export NET=`docker network ls |grep github_network|awk '{print $2}'`; 

docker run --network=$NET -d --health-timeout=60s --health-cmd='bash check-fa.sh' --health-interval=2s --health-retries=10 -p 9011:9011 -e DATABASE_URL=jdbc:postgresql://postgres:5432/fusionauth -e DATABASE_ROOT_USERNAME=$POSTGRESUSER -e DATABASE_ROOT_PASSWORD=$POSTGRESPASS -e DATABASE_USERNAME=$POSTGRESUSER -e DATABASE_PASSWORD=$POSTGRESPASS -e FUSIONAUTH_APP_MEMORY=512M -e FUSIONAUTH_APP_RUNTIME_MODE=development -e FUSIONAUTH_APP_KICKSTART_FILE=/usr/local/fusionauth/kickstart/kickstart.json -e SEARCH_TYPE=database -v /home/runner/work/docker-github-workflow/docker-github-workflow/kickstart:/usr/local/fusionauth/kickstart fusionauth/fusionauth-app:$FAVERSION
