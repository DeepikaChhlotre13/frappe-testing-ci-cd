# Dockerfile (simple pattern that uses official frappe base)
FROM frappe/bench:latest

# create workdir
WORKDIR /home/frappe/frappe-bench

# copy only your app folder (assumes your app folder name is 'deepika' inside repo)
COPY ./deepika /home/frappe/frappe-bench/apps/deepika

# provide apps.json to install during build (optional)
COPY ./apps.json /home/frappe/apps.json

# default command (production method depends on frappe_docker; for simple dev)
CMD ["bench", "start"]






