
#Nuvem_de_palavras_Shinny_Twitter"

  
library(quanteda)
library(wordcloud2)

#dadosRio <- readr::read_rds(path = "dados/dadosRio.rds")

# essa nuvem de palavras será criada a partir da descrição do problema 
#  dos serviços de cobrança e Contestação citados pelos clientes 
#  que fizeram reclamções sobre o setor de Telecomunicações 


setor_telecomunicacao <- dadosRio %>% 
  filter (Segmento.de.Mercado==
            "Operadoras de Telecomunicações (Telefonia, Internet, TV por assinatura)")

#Criando Corpus

corpusquanteda<- corpus(setor_telecomunicacao$Problema)


# Limpeza


dfm_corpusquanteda=corpusquanteda %>%
  tokens(remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE) %>%
  tokens_remove(stopwords("pt")) %>%
  tokens_remove(c("além")) %>%
  tokens_remove(min_nchar=3) %>%
  dfm(tolower = TRUE, stem=FALSE) %>% 
  #comando "stem" trabalha com os radicais 
  dfm_trim(min_docfreq = 0.001, docfreq_type = "prop")

#Depois de feito a limpeza, pode ser que tenha  ficado algumas linhas vazias, 
#por isso é necessário  criar um novo corpus, após criar uma dfm novamente. 

corpus_2 <-corpus_subset(corpusquanteda, ntoken(dfm_corpusquanteda) > 0)
dfm_corpusquanteda<- dfm_subset(dfm_corpusquanteda, ntoken(dfm_corpusquanteda) > 0)


  # "Topfeatures" é a parte do Pré processamento importante para avaliar se precisa
#retirar mais algumas palavras para iniciar o Processamnto do texto.

#termos mais frequentes 
topfeatures(dfm_corpusquanteda, n=20)


#                          Limpeza de stopwords

# EXCLUIR PALAVRAS NA quanteda e repetir o processo 

dfm_corpusquanteda=corpusquanteda %>%
  tokens(remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE) %>%
  tokens_remove(stopwords("pt")) %>%
  tokens_remove(c("serviço ","cobrança",   "após",
                  "pode","pra","ser","tomar","sobre","ainda","ter","vacina",
                  "vai","vou","diz","vem","gente","fica","serviço")) %>%
  tokens_remove(min_nchar=3) %>%
  dfm(tolower = TRUE, stem=FALSE) %>%#comando "stem" trabalha com os radicais 
  
  dfm_trim(min_docfreq = 0.001, docfreq_type = "prop")

# novo corpus, nova dfm 

corpus_2 <-corpus_subset(corpusquanteda, ntoken(dfm_corpusquanteda) > 0)
dfm_corpusquanteda<- dfm_subset(dfm_corpusquanteda, ntoken(dfm_corpusquanteda) > 0)

# verficar se as palavras foram retiradas
topfeatures(dfm_corpusquanteda, n=20)
```
#Caso tenhamos dúvida, podemos ainda analizar uma determinada palavra em seu contexto:
  
head(kwic(corpus_2, pattern = 'cloroquina', window=10))


#                    Nuvem de palavras com quanteda


palavrastopfeatures= topfeatures(dfm_corpusquanteda, n=500)

palavrastopfeatures=tibble(word = names(palavrastopfeatures), 
                           freq = unname(palavrastopfeatures) )

        

#                              Gerar Nuvem 

wordcloud2(palavrastopfeatures, size = 0.5, minSize = 0, gridSize = 0.5,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-dark', backgroundColor = "white",
           minRotation = -pi/2, maxRotation = pi/2, shuffle = TRUE,
           rotateRatio = 0, shape = 'circle', ellipticity = 0.65,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)
