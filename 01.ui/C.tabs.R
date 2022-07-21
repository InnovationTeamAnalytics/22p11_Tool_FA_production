

### TAB PANELS ###




# : ---------



# A. BUDGET ECONOMICO =============================================================================

## 1. Ricavi ----------------------------------------------

t_budget_economico = 
    
    argonPage(
        
        fluidRow(style = title_card,
            
            h4(HTML("<b>Budget Economico</b>"), style = text_title)),
        
        fluidRow(style = ricavi_card, 
                 
                 column(h3(HTML("<b>Ricavi</b>"), style = 'color: #fff;'), hr(), width = 11), 
                 column(style = 'text-align: right;', width = 1, 
                        
                        dropdownButton(tags$h5("Visualizzazione"), hr(),
                                       
                                       numericInput(inputId = 'head_ricavi_groupage', label = h6(HTML("<b>Groupage:</b> Display # Rows")), value = 5, min = 3, step = 1),
                                       numericInput(inputId = 'head_ricavi_trasporto', label = h6(HTML("<b>Groupage:</b> Display # Rows")), value = 5, min = 3, step = 1),
                                       
                                                  circle = FALSE, 
                                                  status = "info",
                                                  icon = icon("gear"),
                                                  width = "350px",
                                                  size = 'lg')
                        ),
                 
         #fluidRow(style = table_card,
                  
                  tableOutput("ricavi_groupage"),
                      
                  tableOutput("ricavi_trasporto"),

                  tableOutput("ricavi_altri")
            
        )
        
    )



# B. Input =============================================================================

## 1. Consuntivo ----------------------------------------------

t_input_consuntivo = 
    
    argonPage(
        
        argonRow(
            
           argonCard(width = 12,
                      
                      title = h5('Consutivo Economico'), 
                      
                      reactable(dt_consbe, outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
            
        )),
        
        br(),
        
        argonRow(
            
            argonCard(title = h5('Consutivo Finanziario'), width = 12,
                      
                      reactable(dt_consbe[1:20], outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
                      
            )
            
        )
        
    )

## 2. Budgets ----------------------------------------------

t_input_budget = 
      
   argonPage(
       
       argonRow(
           
           argonCard(title = h5('Budget Economico'), width = 12,
                  
                 reactable(dt_budget_eco_current_wide,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                     
                
                )
                  
              ),
              
        br(),
       
       argonRow(
           
           argonCard(title = h5('Budget Finanziario'), width = 12,
                     
                     reactable(dt_budget_eco_current_wide,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                     
                     
           )
           
       )

)




## 3. Support ----------------------------------------------


t_input_support = 
    
    argonPage(
        
        argonRow(
            
            argonCard(title = h5('Centri di Costi'), width = 3,  
                      
                      reactable(dt_t_cdc,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, defaultPageSize = 10, height = 500, pagination = FALSE)
                      
                      
            ),
            
            argonCard(title = h5('Tipo Clienti'), width = 5,
                      
                      reactable(dt_t_cliente_tipo,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, defaultPageSize = 10, height = 500, pagination = FALSE)
                      
                      
            ),
            
            argonCard(title = h5('Clienti Export'), width = 4,
                      
                      reactable(dt_t_condcom,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, height = 500, pagination = FALSE)
                      
                      
            )               
            
        ),
        
        br(),
        
        argonRow(
            
            argonCard(title = h5('Condizioni Commerciali'), width = 5,
                      
                      reactable(dt_t_condcom,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            ),
            
            argonCard(title = h5('Condizioni Commerciali 2'), width = 7,
                      
                      reactable(dt_t_condcom_t,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )            
            
        ),
        
        argonRow(
            
            argonCard(title = h5('Aliquote'), width = 5,
                      
                      reactable(dt_t_aliquote,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            ),
            
            argonCard(title = h5('Personale'), width = 7,
                      
                      reactable(dt_t_personale,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )            
            
        ),
        
        argonRow(
            
            argonCard(title = h5('Analitico'), width = 12,
                      
                      reactable(dt_t_analitico,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )
            
        )
        
    )



# X. Analysis =============================================================================







