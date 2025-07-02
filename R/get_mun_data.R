#' Extração dos dados dos indicadores municipais
#'
#' Essa função extrai os dados dos indicadores municipais da API da plataforma
#' FGV - Municipios de acordo com o nome do indicador ou código do indicador na API
#' por município.
#'
#' @param cod_ibge Vetor character contendo os códigos dos municipios segundo IBGE.
#' @param indicator_name Vetor character contendo os nomes dos indicadores. Caso `NULL` a função usará os códigos dos indicadores.
#' @param indicator_code Vetor character contendo os códigos dos indicadores na API. Caso nada seja passado ao argumento, usará os códigos de todos os indicadores.
#'
#' @returns Uma lista contendo os dados dos municípios para cada indicador.
#' @export
#'
#' @examples
#' \dontrun(
#'   # Extraindo os dados dos indicadores de `Gasto total em educação por matrícula`
#'   e `Médicos por  mil habitantes` para as capitais do Nordeste pelos nomes dos indicadores
#'   data <- get_mun_data(
#'     cod_ibge = c("2704302", "2611606", "2927408", "2507507", "2800308", "2211001", "2304400", "2408102", "2111300"),
#'     indicator_name = c("Gasto total em educação por matrícula", "Médicos por  mil habitantes")
#'   )
#' )
get_mun_data <- function(cod_ibge = cod_ibge_munic, indicator_name = NULL, indicator_code = indicators_codes){

  # Construção dos códigos dos indicadores
  ## Caso o argumento indicator_name não for nulo e for uma character
  if(!is.null(indicator_name) && is.character(indicator_name)){
    codes <- purrr::map_chr(
      indicator_name,
      ~ {
        code <- get_indicators_municipios(.x)
      }
    )
  } else{
    # Caso o argumento indicator_name não seja utilizado, a função irá usar diretamente os códigos.
    logger::log_info("Nome dos indicadores não encontrado, utiliazando os códigos dos indicadores diretamente...")
    codes <- indicator_code
  }

  data <- purrr::map(
    codes,
    ~{
      ind_code <- .x # Código do indicador
      # Pegando o nome do indicador
      ind_name <- (setNames(as.list(indicators_names),indicators_codes))[ind_code] |> purrr::pluck(1)
      logger::log_info(stringr::str_glue("Extraindo os dados do indicador: {ind_name}"))
      logger::log_info("Construindo as requisições")
      # Construindo as requisições para cada municipio e indicador
      reqs <- purrr::map(
        cod_ibge,
        ~{
          # url da API
          url <- "https://analitica.municipios.fgv.br/"

          # Estrutura da requisição
          req <- httr2::request(url) |>
            httr2::req_url_query(
              callback = "jQuery364011825524496822326_1750829718859",
              api_ticket = "b09981dc947ed0b1e3a8371eeaf67178c5caf20ee90bcea702cb8c2a19145d3a",
              channel = "default",
              api_indicator = ind_code, # Codigo indicador
              filters = stringr::str_glue("co_municipio,2,'{.x}'") # Filtro para o código do município
            ) |>
            httr2::req_headers(
              "accept" = "*/*",
              "accept-language" = "pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7",
              "cookie" = "_ga=GA1.1.1812424873.1742563784; _ga_LDYK37ZKX2=GS1.1.1743094194.4.0.1743094194.0.0.0",
              "referer" = "https://municipios.fgv.br/",
              "sec-ch-ua" = "\"Not A(Brand\";v=\"8\", \"Chromium\";v=\"132\", \"Opera GX\";v=\"117\"",
              "sec-ch-ua-mobile" = "?0",
              "sec-ch-ua-platform" = "\"Windows\"",
              "sec-fetch-dest" = "script",
              "sec-fetch-mode" = "no-cors",
              "sec-fetch-site" = "same-site",
              "user-agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0"
            ) |>
            httr2::req_retry(5) |> # Tentativas de requisição
            httr2::req_throttle(60, realm = url) # Limite de requisições por minuto
        }
      )

      # Executando as requisições em paralelo
      # A função req_perform_parallel é a forma mais segura de fazer múltiplas requisições
      # em paralelo.
      logger::log_info("Executando as requisições para API...")
      resps <- httr2::req_perform_parallel(reqs,
                                           max_active = 10, # Limite de requisições em paralelo
                                           progress = TRUE  # Exibir a barra de progresso
      )
      logger::log_info("As requisições foram enviadas com sucesso")

      # Construindo uma função que extrairá os dados de interesse
      extract_function <- function(resp){
        # Pegando o código do município a partir da requisição que construímos
        cod_munic <- resp$request$url |>
          stringr::str_extract("(?<=27)[0-9]{7}(?=%)") # regex para pegar o código do município

        # Pegando o body da resposta da API
        body <- resp |> httr2::resp_body_string() # Pegando a resposta da API como uma string
        # Porque a API usa uma forma de codificação antiga
        # Convertendo o body em um JSON
        json <- stringr::str_match(body, "\\((.*)\\)")[, 2] |> # Removendo a codificação antiga
          jsonlite::fromJSON()                                 # e transformando em um JSON

        # Pegando o nome do indicador direto da resposta da API
        nome_ind <- json$no_indicador
        # Pegando o código do indicador direto da resposta da API
        cod_indicador <- json$api_indicador

        # Estruturando os dados em uma tabela
        data <- json$dados |> # Selecionando a lista que contém os dados de interesse
          # Transformando a lista em um tibble
          tibble::tibble() |>
          # Adicionando colunas de identificação ao tibble
          dplyr::mutate(
            municipio_codigo = cod_munic, # Adicionando uma coluna com o código do município
            nome_indicador = nome_ind,    # Adicionando uma coluna com o nome do indicador
            codigo_api_indicador = cod_indicador # Adicionando uma coluna com o código do indicador
          )

      }

      # Aplicando a função de extração a respostas das requisições
      # A forma correta de lidar com o tratamento de uma lista respostas no httr2
      # é através da função resps_data, porquem em caso de qualquer erro ou anomalia
      # da API a função contorna e não quebra.
      logger::log_info("Extraindo os dados das respostas da API")
      dataset <- httr2::resps_data(
        resps, # Lista com as respostas da API
        \(resp) extract_function(resp) # Aplicando a função de extração a cada resposta.
      )

      logger::log_info("Dados extraídos com sucesso")
      # Retornando caso algum município não tenha sido extraído
      ## Obs.: A plataforma não contempla todos os municípios do Brasil, então aqui
      ## sempre haverá o retorno de alguns municípios.
      null_mun <- setdiff(cod_ibge, dataset$municipio_codigo)

      if(length(null_mun) > 0){
        warning(
          "Alguns municípios não retornaram dados: ",
          paste(null_mun, collapse = ", ")
        )
      }

      return(dataset)

    }
  )
}

