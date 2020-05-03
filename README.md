# Interface graphique de controlle

```
nerell-gui unix /tmp/ecran.sock [debug]
```

## Messages JSON

### Récupérer la configuration

* Query
```json
{
    "action": "GET_CONFIG"
}
```

* Réponse
```json
{
    "status": "OK",
    "action": "GET_CONFIG",
    "datas": {
        "team": "JAUNE",
        "startCalibration": false,
        "strategy": "STRAT1",
        "modeManuel": false,
        "skipCalageBordure": false,
        "updatePhoto": false,
        "etalionnageBalise": false,
        "posEcueil": [
            [500, 500],
            [500, 500]
        ],
        "posBouees": [ ... ] // huit positions ou null
    }
}
```

### Mettre à jour les informations d'init

* Query
```json
{
    "action": "UPDATE_STATE",
    "datas": {
        "i2c": true,
        "lidar": true,
        "au": true,
        "alim12v": true,
        "alim5vp": true,
        "tirette": true,
        "phare": true,
        "balise": true,
        "message": "Démarrage"
    }
}
```

* Réponse
```json
{
    "status": "OK",
    "action": "UPDATE_STATE"
}
```

### Mettre à jour les informations de match

* Query
```json
{
    "action": "UPDATE_MATCH",
    "datas": {
        "score": 90,
        "message": "Fin de match"
    }
}
```

* Réponse
```json
{
    "status": "OK",
    "action": "UPDATE_MATCH"
}
```

### Mettre à jour la photo de la balise

* Query
```json
{
    "action": "UPDATE_PHOTO",
    "datas": {
        "photo": "jpeg en base64 sans l'en-tete"
    }
}
```

* Réponse
```json
{
    "status": "OK",
    "action": "UPDATE_PHOTO"
}
```

### Mettre à jour le résultat d'étalonnage balise

* Query
```json
{
    "action": "UPDATE_ETALONNAGE",
    "datas": {
        "ecueil": ["#ff00ff00", "#ffff0000"],
        "bouees": [ ... ] // huit couleurs ou null
    }
}
```

* Réponse
```json
{
    "status": "OK",
    "action": "UPDATE_ETALONNAGE"
}
```
