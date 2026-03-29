FROM node:23.11.1-alpine

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package.json package-lock.json* /app

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . /app

#RUN
RUN npm run build

EXPOSE 4173

# Run vite preview server, binding to 0.0.0.0 (all interfaces) so Docker
# can forward traffic from host machine. Without --host 0.0.0.0, Vite defaults
# to 127.0.0.1 (localhost inside container) which blocks external connections.
CMD ["npm", "run", "preview", "--", "--host", "0.0.0.0", "--port", "4173"]



