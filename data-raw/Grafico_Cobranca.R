
#Conforme analisado anteriormente o segmento de mercado: Serviço de 
# Telecomunicações apresentaram  os maiores índices de reclamações  
# com 35,81%.

# Dentro do  serviço de Telecomunicações o problema que mais atinge 
# os clientes é o de Cobrança e Constentação com 46,94% das reclamações.

# Agora vamos ver quais são as seis empresas que se enquadram 
# nesta categoria, por meio de uma tabela e um gráfico.

#                            Tabela 

# Tabelas de Empresas que se apresentam alto índice de reclamações no setor 
# de Telecomunicações 

setor_telecomunicacao <- dadosRio %>% 
  filter (Segmento.de.Mercado==
            "Operadoras de Telecomunicações (Telefonia, Internet, TV por assinatura)")

options(digits = 2)

tabela_empresa_cobranca <- setor_telecomunicacao %>%
  filter(Grupo.Problema=="Cobrança / Contestação") %>%
  group_by(Nome.Fantasia) %>%
  summarise(clientes=n()) %>%
  arrange(desc(clientes)) %>%
  mutate(Percentual=clientes/sum(clientes)*100) %>% 
  head() 


formattable::formattable(tabela_empresa_cobranca,list(clientes = FALSE))


                             # Gráfico

setor_telecomunicacao %>%
  filter(Grupo.Problema=="Cobrança / Contestação") %>%
  group_by(Nome.Fantasia) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  mutate(Nome.Fantasia = fct_reorder(Nome.Fantasia, n)) %>%
  mutate(Taxa=n/sum(n)*100) %>% 
  head() %>% 
  ggplot() +
  geom_col(aes(x = Nome.Fantasia, y = n, fill = Nome.Fantasia), 
           show.legend = FALSE) +
  geom_label(aes(x = Nome.Fantasia, y = n/2, label = Nome.Fantasia)) +
  coord_flip()+
  labs(title= "Serviço de Cobrança e Contestação")
       







