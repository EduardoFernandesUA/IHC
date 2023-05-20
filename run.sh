#!/bin/bash

lsof -ti:5000 | xargs kill
lsof -ti:5173 | xargs kill

cd mediapipe
source venv/bin/activate
pip install -r requirements.txt

python3 server.py &
cd ..

cd svelte
npm install
npm run dev &
cd ..
