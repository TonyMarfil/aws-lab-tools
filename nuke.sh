for i in $(seq $START $END);

do
docker cp terraform-destroy.sh user${i}:/usr/local/bin/terraform-destroy.sh
docker exec -it -d user${i} chmod +x /usr/local/bin/terraform-destroy.sh
docker exec -it -d user${i} terraform-destroy.sh
done

