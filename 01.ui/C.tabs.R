

### TAB PANELS ###




# : ---------



# A. BUDGET ECONOMICO =============================================================================

t_budget_economico = 
    
    argonPage(
        
        fluidRow(style = title_card,
             
             h4(HTML("<b>Ricavi </b>"), style = text_title)),
        
## 1. Ricavi ----------------------------------------------
        
        fluidRow(style = ricavi_card, 
                 
                 fluidRow(
                     column(h5(HTML("<b>Groupage</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                     column(tags$div(id = "head_ricavi_groupage_1", class = "inline", numericInput(inputId = "head_ricavi_groupage", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
                 ),
                 
                 fluidRow(tableOutput("ricavi_groupage"),
                          tableOutput("ricavi_groupage_perc")),
                 
                 fluidRow(
                     column(h5(HTML("<b>Trasporto</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                     column(tags$div(id = "head_ricavi_trasporto_1", class = "inline", numericInput(inputId = "head_ricavi_trasporto", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
                 ),
                 
                 fluidRow(tableOutput("ricavi_trasporto"),
                          tableOutput("ricavi_trasporto_perc")),             
                 
                 fluidRow(
                     column(h5(HTML("<b>Altri Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8)),
                 fluidRow(tableOutput("ricavi_altri")),
                 
                 br(),
                 hr(),
                 br(),
                 
                 fluidRow(
                     column(h3(HTML("<b>Totale Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 12, align = 'center')),
                 fluidRow(tableOutput("ricavi_tot")
                          
                 )             
                 
        ),

        br(), br(),



## 2. Costi Variabili ----------------------------------------------


fluidRow(style = title_card,
         
         h4(HTML("<b>Costi Variabili </b>"), style = text_title)),

         
        fluidRow(style = costi1_card, 
                 
             fluidRow(
                 column(h5(HTML("<b>Groupage</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                 column(tags$div(id = "head_ricavi_groupage_1", class = "inline", numericInput(inputId = "head_ricavi_groupage", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
             ),
             
             fluidRow(tableOutput("ricavi_groupage2"),
                      tableOutput("ricavi_groupage_perc2")),

             fluidRow(
                 column(h5(HTML("<b>Trasporto</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                 column(tags$div(id = "head_ricavi_trasporto_1", class = "inline", numericInput(inputId = "head_ricavi_trasporto", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
             ),
             
             fluidRow(tableOutput("ricavi_trasporto2"),
                      tableOutput("ricavi_trasporto_perc2")),             
                 
             fluidRow(
                 column(h5(HTML("<b>Altri Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8)),
            fluidRow(tableOutput("ricavi_altri2")),
             
             br(),
             hr(),
             br(),
             
             fluidRow(
                 column(h3(HTML("<b>Totale Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 12, align = 'center')),
             fluidRow(tableOutput("ricavi_tot2")
             
             )             
            
        ),

        br(), br(),
   
        
             
## 3. Costi Fissi Diretti ----------------------------------------------

fluidRow(style = title_card,
         
         h4(HTML("<b>Costi Fissi Diretti </b>"), style = text_title)),        
        fluidRow(style = costi2_card, 
                 
                 fluidRow(
                     column(h5(HTML("<b>Groupage</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                     column(tags$div(id = "head_ricavi_groupage_1", class = "inline", numericInput(inputId = "head_ricavi_groupage", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
                 ),
                 
                 fluidRow(tableOutput("ricavi_groupage3"),
                          tableOutput("ricavi_groupage_perc3")),
                 
                 fluidRow(
                     column(h5(HTML("<b>Trasporto</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8),
                     column(tags$div(id = "head_ricavi_trasporto_1", class = "inline", numericInput(inputId = "head_ricavi_trasporto", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
                 ),
                 
                 fluidRow(tableOutput("ricavi_trasporto3"),
                          tableOutput("ricavi_trasporto_perc3")),             
                 
                 fluidRow(
                     column(h5(HTML("<b>Altri Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 8)),
                 fluidRow(tableOutput("ricavi_altri3")),
                 
                 br(),
                 hr(),
                 br(),
                 
                 fluidRow(
                     column(h3(HTML("<b>Totale Ricavi</b>"), style = 'color: #fff;'), hr(style = "height:2px;border-width:0;color:white;background-color:white"), width = 12, align = 'center')),
                 fluidRow(tableOutput("ricavi_tot3")
                          
                 )             
                 
        ),

        br(), br(),



## 4. Costi Fissi Indiretti ----------------------------------------------

fluidRow(style = title_card,
         
         h4(HTML("<b>Costi Fissi Indiretti </b>"), style = text_title)),
fluidRow(style = costi3_card, 
         
         fluidRow(
             column(h5(HTML("<b>Groupage</b>"), style = 'color: #196774;'), hr(style = "height:2px;border-width:0;color:white;background-color:#196774"), width = 8),
             column(tags$div(id = "head_ricavi_groupage_1", class = "inline", numericInput(inputId = "head_ricavi_groupage", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
         ),
         
         fluidRow(tableOutput("ricavi_groupage4"),
                  tableOutput("ricavi_groupage_perc4")),
         
         fluidRow(
             column(h5(HTML("<b>Trasporto</b>"), style = 'color: #196774;'), hr(style = "height:2px;border-width:0;color:white;background-color:#196774"), width = 8),
             column(tags$div(id = "head_ricavi_trasporto_1", class = "inline", numericInput(inputId = "head_ricavi_trasporto", label = NULL, value = 5, min = 3, step = 1)), align = 'right',  width = 4)
         ),
         
         fluidRow(tableOutput("ricavi_trasporto4"),
                  tableOutput("ricavi_trasporto_perc4")),             
         
         fluidRow(
             column(h5(HTML("<b>Altri Ricavi</b>"), style = 'color: #196774;'), hr(style = "height:2px;border-width:0;color:white;background-color:#196774"), width = 8)),
         fluidRow(tableOutput("ricavi_altri4")),
         
         br(),
         hr(),
         br(),
         
         fluidRow(
             column(h3(HTML("<b>Totale Ricavi</b>"), style = 'color: #196774;'), hr(style = "height:2px;border-width:0;color:white;background-color:#196774"), width = 12, align = 'center')),
         fluidRow(tableOutput("ricavi_tot4")
                  
         )             
         
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







