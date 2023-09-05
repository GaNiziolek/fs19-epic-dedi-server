# fs19-epic-dedi-server
An implementation of dedicated server for Farming Simulator 19 on docker using wine and epic/legendary

Run Container with: 
```sh
docker run --rm -it -e EPIC_AUTH_CODE=b3c70043e0c945c58282385bd7c12d4b -v ./legendary-config/:/root/.config/legendary -v ~/Games/FarmingSimulator19:/root/Games/FarmingSimulator19 -v "./documents_fs19:/root/My Games/FarmingSimulator2019" -p 8080:80 fs-server /bin/bash
```
