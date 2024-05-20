#!/bin/bash
gunicorn -w 1 --thread 3 -t 60 --max-requests 8 --pid process.pid --bind 0.0.0.0:5000 --daemon wsgi:application --access-logfile logs/access.log --error-logfile logs/error.log
echo "Service Started!"