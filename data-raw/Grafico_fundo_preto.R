# Gráfico fundo preto

setor_telecomunicacao %>%
  filter(Grupo.Problema=="Cobrança / Contestação") %>%
  group_by(Nome.Fantasia) %>%
  summarise(n=n()) %>%
  arrange(desc(n)) %>%
  mutate(Nome.Fantasia = fct_reorder(Nome.Fantasia, n)) %>%
  mutate(Taxa=n/sum(n)*100) %>% 
  head() %>% 
  ggplot(aes(
    x =Nome.Fantasia,
    y = Taxa,
    fill = Nome.Fantasia)
  ) +
  geom_col()+
  
  #nomes dentro da coluna
  
  geom_text(aes(label=n), vjust=2, color="black", size=4.5)+
  
  xlab("")+ylab("")+
  
  labs(title= "Serviços Telecomunicações",
       subtitle ="Maiores índices de reclamações")+
  
  # Design do gráfico
  
  theme(legend.position = "none", # miniquadro do lado
        #axis.text.x = element_text(size = 15,angle = 45),
        
        #Primeirofundo preto
        plot.background = element_rect(fill = "black"),
        
        # Segundo fundo preto
        panel.background = element_rect(fill = "black"),
        
        # Colocar o quadro da legenda preto também, neste caso não tem pois
        #legend.position = "none"
        
        #legend.background = element_rect(fill = "black"),
        
        # Cor do título e subtítulo, posição e tamanho
        
        plot.title = element_text(color = "white", hjust = 0.01, size = 22),
        plot.subtitle = element_text(color = "White", hjust = 0.01, size = 15),
        
        
        #melhoar a grade
        
        # Remover as retas verticais
        
        panel.grid.major.x = element_blank(),
        
        #panel.grid.minor.x = element_blank(),
        
        # Diminui  quantidade de retas y, ouseja na horizontal
        
        panel.grid.minor.y = element_blank(),
        
        # determinar a lagura das retas y, ouseja horizontais
        panel.grid.major.y = element_line( size = 0.01),
        
        axis.text = element_text(
          color = "white",
          size = 12),
        axis.ticks.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8,angle = 0))
