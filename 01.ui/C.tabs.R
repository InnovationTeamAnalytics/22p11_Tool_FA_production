

### TAB PANELS ###




# : ---------



# A. BUDGET ECONOMICO =============================================================================

## 1. Ricavi ----------------------------------------------

t_input_consuntivo = 
    
    argonPage(
        
        argonRow(
            
            argonCard(title = 'Consutivo Economico', width = 12,
                      
                      reactable(dt_consbe, outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
                      
            )
            
        ),
        
        br(),
        
        argonRow(
            
            argonCard(title = 'Consutivo Finanziario', width = 12,
                      
                      reactable(dt_consbe[1:20], outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
                      
            )
            
        )
        
    )



# B. Input =============================================================================

## 1. Consuntivo ----------------------------------------------

t_input_consuntivo = 
    
    argonPage(
        
        argonRow(
            
            argonCard(title = 'Consutivo Economico', width = 12,
                      
                      reactable(dt_consbe, outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
                      
            )
            
        ),
        
        br(),
        
        argonRow(
            
            argonCard(title = 'Consutivo Finanziario', width = 12,
                      
                      reactable(dt_consbe[1:20], outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                      
                      
            )
            
        )
        
    )

## 2. Budgets ----------------------------------------------

t_input_budget = 
      
   argonPage(
       
       argonRow(
           
           argonCard(title = 'Budget Economico', width = 12,
                  
                 reactable(dt_budget_eco_current_wide,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                     
                
                )
                  
              ),
              
        br(),
       
       argonRow(
           
           argonCard(title = 'Budget Finanziario', width = 12,
                     
                     reactable(dt_budget_eco_current_wide,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE)
                     
                     
           )
           
       )

)




## 3. Support ----------------------------------------------


t_input_support = 
    
    argonPage(
        
        argonRow(
            
            argonCard(title = 'Centri di Costi', width = 3,  
                      
                      reactable(dt_t_cdc,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, defaultPageSize = 10, height = 500, pagination = FALSE)
                      
                      
            ),
            
            argonCard(title = 'Tipo Clienti', width = 5,
                      
                      reactable(dt_t_cliente_tipo,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, defaultPageSize = 10, height = 500, pagination = FALSE)
                      
                      
            ),
            
            argonCard(title = 'Clienti Export', width = 4,
                      
                      reactable(dt_t_condcom,  outlined = TRUE, striped = TRUE, highlight = TRUE, searchable = TRUE, height = 500, pagination = FALSE)
                      
                      
            )               
            
        ),
        
        br(),
        
        argonRow(
            
            argonCard(title = 'Condizioni Commerciali', width = 5,
                      
                      reactable(dt_t_condcom,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            ),
            
            argonCard(title = 'Condizioni Commerciali 2', width = 7,
                      
                      reactable(dt_t_condcom_t,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )            
            
        ),
        
        argonRow(
            
            argonCard(title = 'Aliquote', width = 5,
                      
                      reactable(dt_t_aliquote,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            ),
            
            argonCard(title = 'Personale', width = 7,
                      
                      reactable(dt_t_personale,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )            
            
        ),
        
        argonRow(
            
            argonCard(title = 'Analitico', width = 12,
                      
                      reactable(dt_t_analitico,  outlined = TRUE, striped = TRUE, highlight = TRUE, compact = TRUE, searchable = TRUE, height = 400, pagination = FALSE)
                      
            )
            
        )
        
    )



# X. Analysis =============================================================================







