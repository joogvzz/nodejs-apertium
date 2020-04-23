FROM node:13.10.1
WORKDIR /usr/src/app
COPY package*.json ./
COPY botUA.json ./
RUN npm install
COPY . .
EXPOSE 4000
CMD ["npm","start"]
ENV LANG C.UTF-8
ADD https://apertium.projectjj.com/apt/apertium-packaging.public.gpg /etc/apt/trusted.gpg.d/apertium.gpg
RUN chmod 644 /etc/apt/trusted.gpg.d/apertium.gpg
ADD https://apertium.projectjj.com/apt/apertium.pref /etc/apt/preferences.d/apertium.pref
RUN chmod 644 /etc/apt/preferences.d/apertium.pref
RUN echo "deb http://apertium.projectjj.com/apt/release stretch main" > /etc/apt/sources.list.d/apertium.list
RUN apt-get -qq update && apt-get -qq install apertium-all-dev
ENTRYPOINT ["apertium"]
