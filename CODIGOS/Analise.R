install.packages(
  c("ggplot2", "tibble", "tidyr", "forcats", "purrr", "prismatic", "corrr", 
    "cowplot", "ggforce", "ggrepel", "ggridges", "ggsci", "ggtext", "ggthemes", 
    "grid", "gridExtra", "patchwork", "rcartocolor", "scico", "showtext", 
    "shiny", "plotly", "highcharter", "echarts4r", 'hrbrthemes')
)



# pacotes
library(tidyverse)
library(ggtext)
library(ggthemes)
library(hrbrthemes)
library(ggforce)
library(gridExtra)
library(waffle)


## cores
cor_azul_claro <- '#56b4e9'
cor_laranja <- '#e69f00'
cor_amarelo <- '#F0E442'
cor_verde <- '#009e73'
cor_roxo <- '#cc79a7'
cor_bege <- '#D9BBA0'
cor_cinza <- '#B0B0B0'

cor_feminino <- '#FF6F61'
cor_masculino <- '#007B83'

cor_democratas <- '#2171b5'
cor_republicanos <- '#d71920'
cor_independentes <- '#b2b2b2'



# Leitura dos dados
dados <- read.csv('DATA\\nonvoters_data.csv')

# Verificando os dados carregados
str(dados)
head(dados)

###### Parte 1 - Publico ######

# G1 - Idade
resumo <- dados %>%
  summarise(mediana = median(ppage),
            media = mean(ppage))

idade_maior_80 <- count(dados[dados$ppage >= 80,])


g1 <- ggplot(dados, aes(x = ppage)) +
  geom_histogram(col = 'white', fill = cor_cinza, alpha = 0.6, bins = 30) +
  geom_histogram(data = subset(dados, ppage > 80), fill = cor_roxo, alpha = 0.4) +
  geom_vline(xintercept = resumo$media, col = "black", linetype = "dashed", size = 1, alpha = .4) +
  geom_vline(xintercept = resumo$mediana, col = cor_laranja, linetype = "dashed", size = 1, alpha = .8) +
  theme_ipsum() +
  labs(
    title = "Histograma da variavel idade (ppage)",
    subtitle = "Ha uma presenca de dois picos para a idade, um proximo aos 30 anos e o outro, proximo aos 65 anos.",
    x = "Idade",
    y = "Frequência",
    caption = "Fonte: FiveThirtyEight - Desafio Universidade dos Dados"
  ) +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank()
  )

g1 <- g1 + annotate(geom = 'text', x = resumo$media-4, y = 400, label = paste0('Media: ', round(resumo$media,2)),
              col = 'black', size = 6, alpha = .5)
g1 <- g1 + annotate(geom = 'text', x = resumo$mediana+4, y = 400, label = paste0('Mediana: ', round(resumo$mediana,2)),
              col = cor_laranja, size = 6)
g1 <- g1 + annotate(geom = 'text', x = 90, y = 100, label = paste0(idade_maior_80, " pessoas possuem\nmais de 80 anos"),
                    col = cor_roxo, size = 6)
g1

# G2 - Genero

resumo_genero <- dados %>%
  group_by(gender) %>%
  summarise(qtde = n()) %>%
  mutate(prop = qtde / sum(qtde) * 100)



# G3 - Raca
resumo_raca <- dados %>%
  group_by(race) %>%
  summarise(qtde = n())%>%
  mutate(prop = qtde/sum(qtde)) %>%
  arrange(desc(qtde)) %>%
  mutate(prop_acumulada = cumsum(prop),
         race = forcats::fct_reorder(race, -prop))


resumo_raca <- resumo_raca %>% 
  group_by(race) %>%
  mutate(first_bar = ifelse(race == 'White' , "first", "other"))

# 
g3 <- ggplot(resumo_raca, aes(y = race, x = prop, fill = first_bar)) +
  geom_col(width = 0.7) +
  facet_wrap(~ race, ncol = 1, scales = "free_y") +
  scale_x_continuous(
    expand = c(0,0), limits = c(0,0.7),
    name = 'Proporção'
  ) +
  scale_y_discrete(guide = "none", expand = expansion(add = c(0.5, .2))) +
  scale_fill_manual(values = c("first" = cor_laranja, "other" = "grey80"), guide = "none") +
  theme_minimal() +
  theme(
    strip.text = element_text(
      hjust = 0, margin = margin(1, 0, 1, 0), 
      size = rel(1.1), face = "bold"
    ),
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    axis.title.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    axis.line.x = element_line(color = "grey80", size = 0.4),
    axis.ticks.x = element_line(color = "grey80", size = 0.4),
    plot.margin = margin(10, 15, 10, 15)
  ) +
  labs(
    title = "Proporção por Raça",
    subtitle = "A raca branca corresponde a 63,6% dos respondentes, 4 vezes maior que a segunda posicao.",
    caption = "Fonte: FiveThirtyEight - Desafio Universidade dos Dados"
  )


g3 +
  geom_text(aes(label = paste0("  ", sprintf("%2.1f", prop * 100), "%  "), 
        color = prop > 50, hjust = prop > 50), size = 5, fontface = "bold", family = "Spline Sans"
  ) +
  scale_color_manual(values = c("black", "white"), guide = "none")


# G4 - Nivel Educacional

resumo_educacao <- dados %>%
  group_by(educ) %>%
  summarise(qtde = n()) %>%
  mutate(prop = qtde / sum(qtde),
         educ = forcats::fct_relevel(educ, 'High school or less', 'Some college', 'College')) %>%
  arrange(educ) %>%
 mutate(prop_acumulada = cumsum(prop))

# G5 - Nivel Salarial
dados %>%
  group_by(income_cat) %>%
  summarise(qtde = n()) %>%
  mutate(income_cat = forcats::fct_relevel(income_cat, 'Less than $40k', '$40-75k', '$75-125k', '$125k or more'),
         prop = qtde/sum(qtde))

## Qual a racao que possui maior poder aquisitivo e menor

dados <- dados %>%
  mutate(income_cat = forcats::fct_relevel(income_cat, 'Less than $40k', '$40-75k', '$75-125k', '$125k or more'),
         educ = forcats::fct_relevel(educ, 'High school or less', 'Some college', 'College'))


table(dados$race, dados$income_cat)
round(prop.table(table(dados$race, dados$income_cat), margin = 1)*100,2)

## podemos dizer que nível educacional e poder aquisitivo estão correlacionados? 

table(dados$educ, dados$income_cat)
round(prop.table(table(dados$educ, dados$income_cat), margin = 1)*100,2)

chisq.test(dados$educ, dados$income_cat)

### PARTE 2

# - Um nível educacional maior implica em maior responsabilidade em relação a votar? 


cor_cinza <- "#B0BEC5"
cor_azul <- "#42A5F5"
cor_verde <- "#66BB6A"
cor_vermelho <- "#EF5350"

p2_g1 <- dados %>%
  mutate(Q2_1 = recode_factor(Q2_1,
                              `1` = "Very important",
                              `2` = "Somewhat important",
                              `3` = "Not so important",
                              `4` = "Not at all important",
                              .default = NA_character_)) %>%
  group_by(Q2_1, educ) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  filter(Q2_1 != -1) %>%
  group_by(Q2_1) %>%
  mutate(prop = qtde / sum(qtde)) %>%
  ggplot(aes(x = Q2_1, y = qtde, fill = educ)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(cor_azul, cor_verde, cor_vermelho, cor_cinza)) +
  coord_flip() +
  labs(
    title = "Importancia de Votar e a Escolaridade",
    subtitle = 'Os valores "-1" foram desconsiderados. Foram apenas 35 casos',
    x = "Importance Level",
    y = "Quantidade de Respondentes",
    fill = "Nivel de Escolaridade"
  ) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank()
  )



p2_g2 <- dados %>%
  mutate(Q2_1 = recode_factor(Q2_1,
                              `1` = "Very important",
                              `2` = "Somewhat important",
                              `3` = "Not so important",
                              `4` = "Not at all important",
                              .default = NA_character_)) %>%
  group_by(educ, Q2_1) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  filter(Q2_1 != -1) %>%
  group_by(Q2_1) %>%
  mutate(prop = qtde / sum(qtde)) %>%
  ggplot(aes(x = educ, y = qtde, fill = Q2_1)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(cor_laranja, cor_azul_claro, cor_bege, cor_roxo, cor_azul, cor_verde, cor_vermelho, cor_cinza)) +
  coord_flip() +
  labs(
    title = "",
    subtitle = '',
    x = "Importance Level",
    y = "Quantidade de Respondentes",
    fill = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank()
  )


grid.arrange(p2_g1, p2_g2, ncol = 2)


## Dentre os nao-brancos, o que e mais importante para ser um bom americano?

p2_g3 <- dados %>%
  select(race, Q2_1, Q2_4, Q2_7) %>%
  filter(race != 'White') %>%
  pivot_longer(-race, names_to = 'Questao', values_to = 'valor') %>%
  group_by(Questao, valor) %>%
  summarise(qtde = n()) %>%
  filter(valor != -1) %>%
  mutate(valor = recode_factor(valor,
                              `1` = "Very important",
                              `2` = "Somewhat important",
                              `3` = "Not so important",
                              `4` = "Not at all important",
                              .default = NA_character_),
         Questao = recode_factor(Questao,
                                 Q2_1 = 'Votar',
                                Q2_4 = 'Demonstrar bandeira',
                                 Q2_7 =  'Apoiar Exercito',
                                 .default = NA_character_)) %>%
  ggplot(aes(x = valor, y = qtde, fill = Questao)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c(cor_azul, cor_verde, cor_vermelho, cor_cinza)) +
  coord_flip() +
  labs(
    title = "Dentre os não-brancos, o que é mais importante para ser um bom americano?",
    subtitle = 'O grafico menor representa o percentual que cada item representa dentro da categoria',
    x = "Importance Level",
    y = "Quantidade de Respondentes",
    fill = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank()
  )


p2_g3_within <- dados %>%
  select(race, Q2_1, Q2_4, Q2_7) %>%
  filter(race != 'White') %>%
  pivot_longer(-race, names_to = 'Questao', values_to = 'valor') %>%
  group_by(Questao, valor) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  filter(valor != -1) %>%
  group_by(Questao) %>%
  mutate(proporcao = qtde / sum(qtde)) %>%
  mutate(valor = recode_factor(valor,
                               `1` = "Very important",
                               `2` = "Somewhat important",
                               `3` = "Not so important",
                               `4` = "Not at all important",
                               .default = NA_character_),
         Questao = recode_factor(Questao,
                                 Q2_1 = 'Votar',
                                 Q2_4 = 'Demonstrar bandeira',
                                 Q2_7 =  'Apoiar Exercito',
                                 .default = NA_character_)) %>%
  ggplot(aes(x = valor, y = proporcao, fill = Questao)) +
  geom_col(position = "fill") +
  scale_fill_manual(values = c(cor_azul, cor_verde, cor_vermelho, cor_cinza)) +
  coord_flip() +
  labs(
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_blank(),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    plot.background = element_rect(linetype = 2),
    plot.margin = margin(0,0,0,0)
  )


p2_g3 + annotation_custom(ggplotGrob(p2_g3_within), 
                          ymin = 1000, xmin = 1.5, ymax = 1700, xmax = 4.5)



## Considerando o poder aquisitivo

dados %>%
  select(race, Q2_1, Q2_4, Q2_7,income_cat) %>%
  filter(race != 'White') %>%
  pivot_longer(-c(race, income_cat), names_to = 'Questao', values_to = 'valor') %>%
  group_by(Questao, valor, income_cat) %>%
  summarise(qtde = n()) %>%
  filter(valor != -1) %>%
  mutate(valor = recode_factor(valor,
                               `1` = "Very important",
                               `2` = "Somewhat important",
                               `3` = "Not so important",
                               `4` = "Not at all important",
                               .default = NA_character_),
         Questao = recode_factor(Questao,
                                 Q2_1 = 'Votar',
                                 Q2_4 = 'Demonstrar bandeira',
                                 Q2_7 =  'Apoiar Exercito',
                                 .default = NA_character_)) %>%
  ggplot(aes(x = valor, y = qtde, fill = Questao)) +
  geom_col(position = "fill") +
  scale_fill_manual(values = c(cor_azul, cor_verde, cor_vermelho, cor_cinza)) +
  coord_flip() +
  facet_wrap(income_cat~.)+
  labs(
    title = "Dentre os não-brancos, o que é mais importante para ser um bom americano?",
    subtitle = 'Existe uma diferença na preferência de não-brancos de maior poder aquisitivo vs menor poder aquisitivo?',
    x = "Importance Level",
    y = "Proporcao de Respondentes",
    fill = ""
  ) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    strip.text = element_text(size = 12, face = 'bold'))


## Considerando que respeitar a opinião dos outros (Q2_8) é um indício de tolerância, 
## ao compararmos as gerações de 18-30 anos, 31-50 anos e +51, 
## qual é a mais tolerante e a menos tolerante?


resumo_idade_tolerancia <- dados %>%
  select(ppage, Q2_8) %>%
  mutate(idade = case_when(
    ppage <= 30 ~ 'Abaixo de 30 anos',
    ppage <= 50 ~ 'De 31 a 50 anos',
    ppage > 50 ~ 'Acima de 51 anos',
    TRUE ~ 'Erro'
  )) %>%
  select(idade, Q2_8) %>%
  filter(Q2_8 != -1) %>%
  group_by(idade, Q2_8) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  mutate(Q2_8 = recode_factor(Q2_8,
                              `1` = "Very important",
                              `2` = "Somewhat important",
                              `3` = "Not so important",
                              `4` = "Not at all important",
                              .default = NA_character_
  ),
  idade = forcats::fct_relevel(idade, "Abaixo de 30 anos", "De 31 a 50 anos", "Acima de 51 anos"))


ggplot(resumo_idade_tolerancia, aes(x = Q2_8, y = qtde, fill = Q2_8)) +
  geom_col(position = "dodge") +
  facet_wrap(~ idade) +#, scales = "free_x") +
  coord_flip() +
  scale_fill_manual(values = c(cor_laranja, cor_azul_claro, cor_bege, cor_roxo)) +
  labs(
    title = "Respeitar a opiniao dos outros pela fator Idade",
    subtitle = " Respecting the opinions of those who disagree with you...",
    x = "Nivel de Importancia",
    y = "Quantidade de Respondentes",
    fill = "Importance Level"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    legend.position = "top",
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    strip.text = element_text(size = 12, face = 'bold')
  )


#### PARTE 3


# Qual escolha partidária, incluindo pessoas sem partido (Q30), 
# possui eleitores mais jovens? 

p3_g1 <- dados %>%
  select(ppage, Q30) %>%
   filter(Q30 != -1) %>% # 48 CASOS %>%
  mutate(idade = case_when(
    ppage <= 30 ~ 'Abaixo de 30 anos',
    ppage <= 50 ~ 'De 31 a 50 anos',
    ppage > 50 ~ 'Acima de 51 anos',
    TRUE ~ 'Erro'
  ),
  idade = forcats::fct_relevel(idade, "Abaixo de 30 anos", "De 31 a 50 anos", "Acima de 51 anos"),
  partido = case_when(
    Q30 == 1 ~ 'Republican',
    Q30 == 2 ~ 'Democrat',
    Q30 == 3 ~ 'Independent',
    TRUE ~ "Another/No preference")) %>%
  group_by(partido, idade) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
 
  ggplot(aes(x = qtde, y = idade, fill = partido)) +
  geom_col(position = 'dodge') +
  scale_fill_manual(values = c(cor_bege, cor_democratas, cor_independentes, cor_republicanos)) +
  geom_text(aes(label = qtde), 
            size = 5, 
            fontface = "bold", 
            position = position_dodge(width = 0.9), 
            vjust = 0.5, 
            hjust = -0.2) +
  labs(
    title = "Partido politico e faixa etaria",
    subtitle = " Qual escolha partidária, incluindo pessoas sem partido (Q30), possui eleitores mais jovens? ",
    fill = "Partido"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    legend.position = "top",
    panel.grid.major = element_line(size = 0.5, linetype = 'dotted', color = "grey"),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    strip.text = element_text(size = 12, face = 'bold'),
    axis.title.x = element_blank(),
    axis.text.x = element_blank()
  )

p3_g1


## E qual possui mais mulheres como apoiadoras? 
dados %>%
  filter(Q30 != -1) %>%
  mutate(partido = case_when(
    Q30 == 1 ~ 'Republican',
    Q30 == 2 ~ 'Democrat',
    Q30 == 3 ~ 'Independent',
    TRUE ~ "Another/No preference")) %>%
  group_by(gender, partido) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  filter(gender == 'Female') %>%
  mutate(qtde = qtde/100) %>%
  select(partido, qtde) %>%
  waffle(rows = 4, colors = c(
    cor_bege, cor_democratas, cor_independentes, cor_republicanos
  ), title = 'Apoio Feminino por partido',
  xlab = '1 quadrado = 100 mulheres') +
  labs(subtitle = '') +
  theme_minimal() +
  theme(legend.position = 'bottom',
        legend.text = element_text(size = 15),
    plot.title = element_text(size = 20, face = "bold"),
    plot.subtitle = element_text(size = 15, face = "italic"),
    axis.title = element_text(size = 15),
    axis.text = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank()
  )


## Perfil do publico em termos de idade e genero

dados %>%
  filter(Q30 != -1) %>%
  mutate(partido = case_when(
    Q30 == 1 ~ 'Republican',
    Q30 == 2 ~ 'Democrat',
    Q30 == 3 ~ 'Independent',
    TRUE ~ "Another/No preference")) %>%
  group_by(gender, partido) %>%
  summarise(qtde = n(), .groups = 'drop') %>%
  pivot_wider(names_from = partido, values_from = qtde)


dados %>%
  select(Q30, ppage) %>%
  filter(Q30 != -1) %>%
  mutate(partido = case_when(
    Q30 == 1 ~ 'Republican',
    Q30 == 2 ~ 'Democrat',
    Q30 == 3 ~ 'Independent',
    TRUE ~ "Another/No preference")) %>%
  group_by(partido) %>%
  summarise(median = median(ppage),
            media = mean(ppage),
            desvio_padrao = sd(ppage),
            minimo = min(ppage),
            maior = max(ppage))


# Existe uma correlação entre idade e propensão a votos (voter_category)? 
df_prop_voto_idade <- dados %>%
  select(ppage, voter_category) %>%
  mutate(idade = case_when(
    ppage <= 30 ~ 'Abaixo de 30 anos',
    ppage <= 50 ~ 'De 31 a 50 anos',
    ppage > 50 ~ 'Acima de 51 anos',
    TRUE ~ 'Erro'
  ),
  idade = forcats::fct_relevel(idade, "Abaixo de 30 anos", "De 31 a 50 anos", "Acima de 51 anos"))

tabela <- table(df_prop_voto_idade$voter_category, df_prop_voto_idade$idade)
teste_chiq <- chisq.test(tabela)

print(teste_chiq)


##### ANOVA

anova_result <- aov(ppage ~ voter_category, data = dados)

# Exibir o resumo dos resultados
summary(anova_result)


# teste de Tukey
tukey_result <- TukeyHSD(anova_result)
tukey_result

# grafico
ggplot(dados, aes(x = voter_category, y = ppage)) +
  geom_jitter(width = 0.2, alpha = 0.6, color = 'black') +
  geom_boxplot(alpha = 0.3, fill = cor_cinza, outlier.shape = NA) +
  labs(title = "Boxplot - Idade por Categoria do eleitor",
       x = "",
       y = "Idade") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12)
  ) +
  scale_x_discrete(labels = c("Always" = "Sempre", "Rarely/Never" = "Raramente/Nunca", "Sporadic" = "Esporádico"))

