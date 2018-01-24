docker run -it -d --name nettest --net=host  -v /monroe/scripts/config.rmbt:/monroe/config:ro -v /monroe/results:/monroe/results  aliparic/repo1
docker run -it -d --name ali_ping --net=host  -v /monroe/scripts/config.ping:/monroe/config:ro -v /monroe/results:/monroe/results  aliparic/repo2
/monroe/ssTrace.sh
