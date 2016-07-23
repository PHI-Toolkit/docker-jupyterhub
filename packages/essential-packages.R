# The packages below come from: https://github.com/qinwf/awesome-R

# databases
install.packages(c('RODBC', 'RMySQL', 'RSQLite'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')

# Data manipulation packages
install.packages(c('dplyr', 'tidyr', 'stringr', 'lubridate'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')
install.packages(c('jsonlite', 'XML', 'quantmod', 'rvest', 'reshape2'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')

# Data visualization packages
install.packages(c('ggplot2', 'ggvis', 'rgl', 'htmlwidgets'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')
install.packages(c('leaflet', 'dygraphs', 'networkD3', 'maps'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')
install.packages(c('knitr', 'plotly', 'RColorBrewer'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')

# Machine learning packages
install.packages(c('randomForest', 'e1071', 'rpart'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')
install.packages(c('rminer', 'gmodels', 'class', 'wordcloud', 'neuralnet'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')

# Natural Language Processing
install.packages(c('text2vec', 'tm', 'topicmodels', 'quanteda', 'RTextTools'), lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')
