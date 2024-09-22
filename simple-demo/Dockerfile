FROM rocker/shiny:4.4
RUN rm -rf /srv/shiny-server/*
WORKDIR /srv/shiny-server/
RUN R -e "install.packages(c('shiny', 'ggplot2'), repos='https://cran.rstudio.com/')"
ADD ./app.R ./app.R
RUN chown -R shiny:shiny ./app.R
