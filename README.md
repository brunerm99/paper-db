# Academic Paper Database

## Goals
* Use NLP to cluster papers into a set of keywords to allow for quick searching. 
* Create a clean web interface to:
    * Search and view PDFs based on keywords.
    * Ingest new papers into database for classification.
    * Get BibTeX citations.

## Startup
This app uses ```docker-compose```. 
To start, run (while inside the main directory):
``` bash
docker-compose up -d --build
```
This will start the docker container in the background as a daemon (```-d```).
The daemon flag can be removed to see all the error and info messages.
