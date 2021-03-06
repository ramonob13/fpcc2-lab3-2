library(tidyverse)
library(here)
library(viridis)
source(here::here("code/lib.R"))
theme_set(theme_bw())

knitr::opts_chunk$set(tidy = FALSE,
                      fig.width = 6,
                      fig.height = 5)

dados = read_csv(
    here::here("data/participation-per-country.csv"),
    col_types = cols(
        .default = col_double(),
        site = col_character(),
        country = col_character(),
        geo = col_character(),
        four_regions = col_character(),
        eight_regions = col_character(),
        six_regions = col_character(),
        `World bank income group 2017` = col_character()
    )
) %>%
    filter(usuarios > 200)
glimpse(dados)


#Estamos interessados na relação entre quanto as pessoas de diferentes países comentam em questões dos outros. A proporção das pessoas do país que comentou nas questões de outros está medido na variável `comentaram_prop`.

#Considerando essa variável, queremos examinar a relação entre ela e o quão hierárquicas são as relações em um país (`PDI`). Queremos também levar em conta o quanto as pessoas daquele país têm acesso à Internet (`Internet`) e qual o tamanho da base de dados que detectamos daquele país (`usuarios`).

## Examinando essa relação
dados %>%
    ggplot(aes(x = PDI, y = responderam_prop)) +
    geom_point()

dados %>%
    ggplot(aes(x = PDI, y = responderam_prop, color = site)) +
    geom_point()

dados %>%
    ggplot(aes(
        x = PDI,
        y = responderam_prop,
        color = Internet,
        size = log10(usuarios)
    )) +
    geom_point(alpha = .6)

dados %>%
    ggplot(aes(
        size = PDI,
        y = responderam_prop,
        color = Internet,
        x = log10(usuarios)
    )) +
    geom_point(alpha = .6)

dados %>%
    ggplot(aes(
        x = PDI,
        y = responderam_prop,
        color = Internet,
        size = log10(usuarios)
    )) +
    geom_point(alpha = .6) +
    facet_grid(site ~ ., scales = "free_y")

dados %>%
    ggplot(aes(
        x = PDI,
        y = responderam_prop,
        size = Internet,
        color = log10(usuarios)
    )) +
    geom_point(alpha = .6) +
    facet_grid(site ~ ., scales = "free_y")

#Faça uma visualização que usa os princípios de eficácia no projeto de visualizações para facilitar as comparações que você acha que são as mais importantes para entendermos esse contexto.

## Outras formas de ver

#Em seguida, faça 5 visualizações que usem as mesmas variáveis e também pontos, mas que sejam **menos eficazes** que a que você escolheu acima.

## Bônus

#Inclua o continente dos países (`six_regions`) na visualização.
dados %>%
    ggplot(aes(
        x = PDI,
        y = responderam_prop,
        size = Internet,
        color = log10(usuarios)
    )) +
    geom_point(alpha = .6) +
    facet_grid(six_regions ~ ., scales = "free_y")

dados %>%
    ggplot(aes(
        x = PDI,
        y = responderam_prop,
        size = Internet,
        color = log10(usuarios)
    )) +
    geom_point(alpha = .6) +
    facet_grid(six_regions ~ ., scales = "free_x",drop=TRUE)

six_regions_update<-dados %>% filter(dados$six_regions )