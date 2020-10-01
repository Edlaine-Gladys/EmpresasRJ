#Etapa 1 do processo de Análise das Empresas

# Quais foram os segmentos de mercado que mais houve reclamações? E quais empresas 
#se enquadraram neste perfil ?

library(dplyr)
library(formattable)

# Relação do segmento de mercado que mais tem reclamação no Rio De Janeiro

dadosRio <- readr::read_rds(path = "dados/dadosRio.rds")

Segmento_mercado_reclamacao <- dadosRio %>%
  group_by(Segmento.de.Mercado) %>%
  summarise(clientes=n()) %>%
  arrange(desc(clientes)) %>%
  mutate(Percentual= clientes/sum(clientes)*100) 

sum(Segmento_mercado_reclamacao$clientes)

# somar  as colunas( verificação) 
apply(Segmento_mercado_reclamacao[, 2:3], 2, sum)

options(digits = 1)

# Foi identificado neste segmento de mercado o serviço de Telecomunicações com 
# maior número de reclamações, vamos criar uma tabela para esta vizualização 


formattable(Segmento_mercado_reclamacao,
            list(clientes = FALSE,
              Percentual =
                   formatter("span",style = x ~ style(
                     display = "block","border-radius" = "4px",
                     "padding-right" = "4px",color = "white",
                     "background-color" = rgb(x/max(x), 0, 0)))))


# Identicar no setor de Telecomunicações quais foram os maiores problemas  

setor_telecomunicacao <- dadosRio %>% 
  filter (Segmento.de.Mercado==
            "Operadoras de Telecomunicações (Telefonia, Internet, TV por assinatura)")

problema_no_setor_telecomunicacao <- setor_telecomunicacao %>% 
  group_by(Grupo.Problema) %>% 
  summarise(clientes=n()) %>% 
  arrange(desc(clientes)) %>% 
  mutate(Percentual= clientes/sum(clientes)*100) 

sum(problema_no_setor_telecomunicacao$clientes)

formattable(problema_no_setor_telecomunicacao)


# Foi analisado que no segmento de mercado o serviço de Telecomunicações 
# aprsentam os maiores índices de reclamações  com 35,81%  dentro deste serviço 
# o problema que mais atinge os clientes é o de Cobrança e Constentação com
# 46,94%, agora vamos agora relacionar quais empresas se encaixam neste perfil,
# esta análise será feita por meio de um gráfico, que está em outro scprit.  
