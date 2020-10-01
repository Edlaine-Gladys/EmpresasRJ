# The_pilot

dadosBrasil <- read.table("dados/2019_semestre_2.csv", 
                         header = TRUE,
                          sep = ";", dec = ",")


# Salvar em Rds os dados do Brasil

readr::write_rds(dadosBrasil, "dados/dadosBrasil.rds")

#A análise se trata apenas do Rio de Janeiro 

dadosRio <- dadosBrasil %>%
filter(UF=="RJ")

# Salvar em Rds os dados do Rio de Janeiro

readr::write_rds(dadosRio, "dados/dadosRio.rds")

# ler em Rds

dadosRio <- readr::read_rds(path = "dados/dadosRio.rds")
