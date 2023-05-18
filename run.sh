#!/bin/bash

fuser 5000/tcp -k
fuser 5173/tcp -k

cd mediapipe
source venv/bin/activate
python3 server.py &
cd ..

cd svelte
npm install
npm run dev &
cd ..
