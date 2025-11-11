FROM openanalytics/r-ver:4.2.1

MAINTAINER E Breitmoser "e.breitmoser@epcc.ed.ac.uk"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.1   \
    zlib1g

# system library dependency for the babynames app
RUN apt-get update && apt-get install -y \
    libmpfr-dev 

# basic shiny functionality
RUN R -e "install.packages(c('promises', 'httpuv'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

# install dependencies of the babynames app
RUN R -e "install.packages(c('dygraphs'), repos='https://cloud.r-project.org/')"
RUN R -e "install.packages(c('stringr'), repos='https://cloud.r-project.org/')"

# copy the app to the image
RUN mkdir /root/babynames
COPY babynames /root/babynames

# COPY Rprofile.site /usr/lib/R/etc/   # Copy fails, no such file or directory

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/babynames',,host='0.0.0.0',port=3838)"]

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:3838 || exit 1    
