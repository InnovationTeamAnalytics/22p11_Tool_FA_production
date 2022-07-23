

### SERVER ###





# : ============================================================================================================================



server_app = function(input, output, session) {

      
  # A. BUDGET =============================================================================
  
  
  ## 1. Budget Economico ----------------------------------------------
  
  ### 1. Ricavi ----------------------------------------
    
  #### Groupage -------------------------
  
 output$ricavi_groupage <- renderReactable({
     
     line = 'Groupage'

     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_groupage]
    
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_groupage)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
   
     dt = cbind(rbind(dt_selected, dt_unselected)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt)
     
     dt |> 
            reactable(
                
                bordered = TRUE, highlight = TRUE, compact = TRUE, sortable = TRUE, fullWidth = TRUE,
                minRows = input$head_ricavi_groupage, showPagination = FALSE, defaultSorted = list(TOTALE = "desc"),
                theme = reactableTheme(color = "#486966", tableStyle = list(fontSize = 12),
                                       headerStyle = list(height = "3em", background = "#649FA1", borderColor = "#8FBCBB", color = '#fff', cursor = "pointer", fontSize = 15),
                                       footerStyle = list(height = "2.25em")),
                      
                defaultColDef = colDef(
                    cell = function(value) format(value, nsmall = 0,  big.mark = ".", decimal.mark = ','),
                    align = "right",
                    minWidth = 80),
  
                columns = list(
                    DESCRIZIONE = colDef(name = "DESCRIZIONE", minWidth = 200, align = 'left', style = list(fontWeight = "bold")),
                    TOTALE = colDef(name = "TOTALE", minWidth = 120, align = 'right', style = list(fontWeight = "bold"))),
                
                rowStyle = function(index) { if (dt[index, 'DESCRIZIONE'] == "ALTRO") { list(background = "rgba(0, 0, 0, 0.05)")}}
        )
         

         
 })
 
 
 
 
 
 
 #### Trasporto -------------------------
 
 output$ricavi_trasporto <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_trasporto]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_trasporto)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) 

     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed', full_width = TRUE)) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#649FA1", font_size = 12, color = '#fff') |> 
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) 
     
 }
 
 
 ### % 
 
 output$ricavi_trasporto_perc <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 12) 
     
 }
 
 
 #### Altri Ricavi -------------------------
 
 output$ricavi_altri <- function() {
     
     line = 'Ricavi / Costi indiretti'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_selected[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = dt_total[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1

     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#649FA1", font_size = 12, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 
 #### Totale Ricavi -------------------------
 
 output$ricavi_tot <- function() {
     
     dt_selected = dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'Totale dei Ricavi'), dt_selected[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16]])
     
     dt = dt_total[,-c('tipo_voce')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#196774", font_size = 14, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#fff", font_size = 13) 
     
 }
 
 
 
 
 ### 2. Costi Variabili ----------------------------------------
 
 #### Groupage -------------------------
 
 output$ricavi_groupage2 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_groupage]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_groupage)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |>  
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) 
     
 }
 
 ### % 
 
 output$ricavi_groupage_perc2 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 
 
 #### Trasporto -------------------------
 
 output$ricavi_trasporto2 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_trasporto]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_trasporto)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected, dt_total)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed', full_width = TRUE)) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) |> 
         row_spec(nrow(dt), bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 ### % 
 
 output$ricavi_trasporto_perc2 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 #### Altri Ricavi -------------------------
 
 output$ricavi_altri2 <- function() {
     
     line = 'Ricavi / Costi indiretti'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_selected[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = dt_total[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 
 #### Totale Ricavi -------------------------
 
 
 output$ricavi_tot2 <- function() {
     
     dt_selected = dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'Totale dei Ricavi'), dt_selected[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16]])
     
     dt = dt_total[,-c('tipo_voce')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#953C3C", font_size = 14, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#fff", font_size = 13) 
     
 }
 
 
 
 
 ### 3. Costi Fissi Diretti ----------------------------------------
 
 #### Groupage -------------------------
 
 output$ricavi_groupage3 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_groupage]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_groupage)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |>  
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) 
     
 }
 
 ### % 
 
 output$ricavi_groupage_perc3 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 
 
 #### Trasporto -------------------------
 
 output$ricavi_trasporto3 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_trasporto]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_trasporto)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected, dt_total)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed', full_width = TRUE)) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) |> 
         row_spec(nrow(dt), bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 ### % 
 
 output$ricavi_trasporto_perc3 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 #### Altri Ricavi -------------------------
 
 output$ricavi_altri3 <- function() {
     
     line = 'Ricavi / Costi indiretti'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_selected[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = dt_total[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 
 #### Totale Ricavi -------------------------
 
 output$ricavi_tot3 <- function() {
     
     dt_selected = dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'Totale dei Ricavi'), dt_selected[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16]])
     
     dt = dt_total[,-c('tipo_voce')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#953C3C", font_size = 14, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#fff", font_size = 13) 
     
 }
 
 
 
 
 ### 4. Costi Fissi Indiretti ----------------------------------------
 
 #### Groupage -------------------------
 
 output$ricavi_groupage4 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_groupage]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_groupage)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |>  
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) 
     
 }
 
 ### % 
 
 output$ricavi_groupage_perc4 <- function() {
     
     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 
 
 #### Trasporto -------------------------
 
 output$ricavi_trasporto4 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][1:input$head_ricavi_trasporto]
     
     dt_unselected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi'][-c(1:input$head_ricavi_trasporto)]
     dt_unselected = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'ALTRO'), dt_unselected[, lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_unselected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = cbind(rbind(dt_selected, dt_unselected, dt_total)[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]) 
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed', full_width = TRUE)) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1:subtot_r, bold = FALSE, color = "#486966", background = "#fff", font_size = 11) |> 
         row_spec(subtot_r, bold = FALSE, italic = TRUE, color = "#486966", background = "#F2F2F2", font_size = 11) |> 
         row_spec(nrow(dt), bold = TRUE, color = "#486966", background = "#DEEFE7", font_size = 11) 
     
 }
 
 
 ### % 
 
 output$ricavi_trasporto_perc4 <- function() {
     
     line = 'Trasporto'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), col.names = NULL, align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(2, italic = TRUE, color = "#5C7373", background = "#fff", font_size = 11) |> 
         row_spec(1, bold = TRUE, color = "#fff", background = "#BF99A0", font_size = 12) 
     
 }
 
 
 #### Altri Ricavi -------------------------
 
 output$ricavi_altri4 <- function() {
     
     line = 'Ricavi / Costi indiretti'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'TOTAL'), dt_selected[cdc_raggruppamenti_adj == line & tipo_voce == 'Altri ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16], by = 'cdc_raggruppamenti_adj'])
     
     dt = dt_total[,-c('tipo_voce', 'cdc_raggruppamenti_adj')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     subtot_r = nrow(dt) - 1
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, bold = TRUE, width = '30em') |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, bold = TRUE, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#BB716F", font_size = 12, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#fff", font_size = 11) 
     
 }
 
 
 
 #### Totale Ricavi -------------------------
 
 
 output$ricavi_tot4 <- function() {
     
     dt_selected = dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi']
     dt_total = cbind(data.table(tipo_voce = 'Ricavi', ter_descr = 'Totale dei Ricavi'), dt_selected[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_selected)[4:16]])
     
     dt = dt_total[,-c('tipo_voce')]
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))
     
     dt |> 
         
         knitr::kable("html", digits = 0, format.args = list(big.mark = ".", decimal.mark = ','), align = c('c', rep('r', 13)))  |> 
         
         kable_styling(bootstrap_options = c("hover", "responsive", 'bordered', 'condensed'), full_width = TRUE) |> 
         column_spec(1, width = '30em',) |> 
         column_spec(2:13, width = '10em') |> 
         column_spec(14, width = '15em') |> 
         row_spec(0, bold = TRUE, background = "#953C3C", font_size = 14, color = '#fff') |> 
         row_spec(1, bold = TRUE, color = "#486966", background = "#fff", font_size = 13) 
     
 } 

}











