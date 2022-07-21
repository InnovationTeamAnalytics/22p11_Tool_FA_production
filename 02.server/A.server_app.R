

### SERVER ###





# : ============================================================================================================================



server_app = function(input, output, session) {

      
  # A. Input =============================================================================
  
  
  ## 1. Input Economico ----------------------------------------------
  
  
  ### Data Upload -------------------------
  
 output$ricavi_groupage <- function() {

     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == 'Groupage' & tipo_voce == 'Ricavi'][1:input$head_ricavi_groupage]
    
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == 'Groupage' & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_groupage)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_cod_adj = 'Altro'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
   
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_cod_adj = 'Total'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == 'Groupage' & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])

     dt = cbind(rbind(dt_selected, dt_unselected, dt_total)[,-c(1:2)]) 
     
     subtot_r = nrow(dt) - 1
     dt |> 
         
       knitr::kable("html") |> 
         
       kable_styling(bootstrap_options = c("hover", "responsive"), full_width = TRUE, fixed_thead = list(enabled = TRUE, bold = TRUE, background = "#ADD9D1")) |> 
          column_spec(1, bold = TRUE) |> 
          column_spec(14, bold = TRUE) |> 
            row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff") |> 
            row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#fff") |> 
            row_spec(nrow(dt), bold = TRUE, color = "#486966", background = "#DEEFE7") 
         
         
         
 }
 
  
#  output$ricavi_trasporto <- function() {
# 
# results_df = head(dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == 'Trasporto'])
# 
# # Sum the last row of each column if numeric
# func <- function(z) if (is.numeric(z)) sum(z) else ''
# sumrow <- as.data.frame(lapply(results_df, func))
# 
# # Give name to the first element of the new data frame created above
# sumrow[1] <- "Total"
# 
# # Add the original and new data frames together
# summed_results_df <- rbind(results_df, sumrow)
# 
# # Name the columns
# colnames <- names(results_df)
# colnames(summed_results_df) <- colnames
# 
# # Make Table
# kable(summed_results_df, caption = "Normalized Annual Energy Demand", booktabs = TRUE) %>%
#   kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
#   row_spec(dim(summed_results_df)[1], bold = T) %>% # format last row
#   column_spec(1, italic = T) # format first column
#  }

}











