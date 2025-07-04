% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_mun_data.R
\name{get_mun_data}
\alias{get_mun_data}
\title{Extração dos dados dos indicadores municipais}
\usage{
get_mun_data(
  cod_ibge = cod_ibge_munic,
  indicator_name = NULL,
  indicator_code = indicators_codes
)
}
\arguments{
\item{cod_ibge}{Vetor character contendo os códigos dos municipios segundo IBGE. Caso nada seja passado ao argumento, usará so códigos de todos os municípios do Brasil.}

\item{indicator_name}{Vetor character contendo os nomes dos indicadores. Caso `NULL` a função usará os códigos dos indicadores.}

\item{indicator_code}{Vetor character contendo os códigos dos indicadores na API. Caso nada seja passado ao argumento, usará os códigos de todos os indicadores.}
}
\value{
Uma lista contendo os dados dos municípios para cada indicador.
}
\description{
Essa função extrai os dados dos indicadores municipais da API da plataforma
FGV - Municipios de acordo com o nome do indicador ou código do indicador na API
por município.
}
\examples{
\dontrun(
  # Extraindo os dados dos indicadores de `Gasto total em educação por matrícula`
  e `Médicos por  mil habitantes` para as capitais do Nordeste pelos nomes dos indicadores
  data <- get_mun_data(
    cod_ibge = c("2704302", "2611606", "2927408", "2507507", "2800308", "2211001", "2304400", "2408102", "2111300"),
    indicator_name = c("Gasto total em educação por matrícula", "Médicos por  mil habitantes")
  )
)
}
