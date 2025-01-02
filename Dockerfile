FROM perl:latest

# Prerequisites for DBD::mysql
RUN echo "deb http://ftp.de.debian.org/debian/ sid main" > /etc/apt/sources.list
RUN apt update && apt install -y libmysqlclient-dev

# install all CLI tools required for running/starting application
RUN cpanm --notest Plack Poet DBD::mysql

# create working directory & poet application
WORKDIR /container
RUN poet new app
WORKDIR /container/app

# copy & install dependencies needed by server
COPY cpanfile .
RUN if [ -f cpanfile ]; then cpanm --notest --installdeps .; fi 

# Copy webserver specifics into container
COPY app.psgi bin/app.psgi
COPY lib/Ws24 lib/Ws24
COPY static static
COPY conf/local.cfg conf/

# copy actual projects into container
COPY wae99 comps/wae99

# ARG project_dir
# COPY $project_dir comps/$project_dir

# below is for testing if plackup won't start, e.g. halt container to allow exec-ing into it
# CMD ["tail", "-f", "/dev/null"]

# Standardbefehl, um Plack zu starten
CMD ["plackup", "--host", "0.0.0.0", "--port", "5000", "-R", "/container/app/comps", "bin/app.psgi"]