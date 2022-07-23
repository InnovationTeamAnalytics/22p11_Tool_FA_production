

# :=======================================================================================

kc_months_tot = c(kc_months, 'total')

# A. Budget =============================================================================================================

## 1. Ricavi -----------------------------------------------------------

### Groupage ---------------

dt_budget_eco_current_ricavi = merge(dt_budget_eco_current_ricavi, dt_budget_eco_current_ricavi_tot, by = c('cdc_raggruppamenti_adj', 'tipo_voce', 'ter_descr'))
dt_budget_eco_current_ricavi[, (kc_months_tot) := lapply(.SD, function(x) {x / 1000}), .SDcols = kc_months_tot]
setorder(dt_budget_eco_current_ricavi, tipo_voce, cdc_raggruppamenti_adj, -total)

#### TOTAL & PERCENTAGE

     line = 'Groupage'
     
     dt_selected = dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16], by = 'cdc_raggruppamenti_adj']
     dt_all = cbind(data.table(cdc_raggruppamenti_adj = 'Total'), dt_budget_eco_current_ricavi[tipo_voce == 'Ricavi', lapply(.SD, sum), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt_perc = cbind(data.table(cdc_raggruppamenti_adj = '% su Totale (no altri ricavi)'), dt_selected[, -1] / dt_all[, -1])
     
     dt_perc[, (kc_months_tot) := lapply(.SD, function(x) {paste(round(x * 100, digits = 1), ' %')}), .SDcols = kc_months_tot]
     
     dt_total = cbind(data.table(cdc_raggruppamenti_adj = 'TOTAL'), dt_budget_eco_current_ricavi[cdc_raggruppamenti_adj == line & tipo_voce == 'Ricavi', lapply(.SD, function(x) {format(round(sum(x), digits = 0), big.mark = ".", decimal.mark = ',')}), .SDcols = names(dt_budget_eco_current_ricavi)[4:16]])
     
     dt = rbind(dt_total, dt_perc)
     
     setnames(dt, names(dt), c('DESCRIZIONE', 'GEN', 'FEB', 'MAR', 'APR', 'MAG', 'GIU', 'LUG', 'AGO', 'SET', 'OTT', 'NOV', 'DIC', 'TOTALE'))

     ricavi_summary_table = 
         
     dt |> 
         
         reactable(
                
                bordered = TRUE, highlight = TRUE, compact = TRUE, sortable = TRUE, fullWidth = TRUE,
                minRows = 2, showPagination = FALSE,
                theme = reactableTheme(color = "#486966", tableStyle = list(fontSize = 12),
                                       headerStyle = list(height = "0em", background = "#F2F2F2", borderColor = "#F2F2F2", color = '#F2F2F2', cursor = "pointer", fontSize = 15)
                                       ),
                      
                defaultColDef = colDef(
                    align = "right",
                    minWidth = 80),
  
                columns = list(
                    DESCRIZIONE = colDef(name = "DESCRIZIONE", minWidth = 200, align = 'left', style = list(fontWeight = "bold")),
                    TOTALE = colDef(name = "TOTALE", minWidth = 120, align = 'right', style = list(fontWeight = "bold"))),
                
                rowStyle = function(index) { if (dt[index, 'DESCRIZIONE'] == "TOTAL") { list(background = "rgba(0, 0, 0, 0.05)", fontSize = 13)}},
                rowClass = function(index) { if (dt[index, 'DESCRIZIONE'] == "TOTAL") { "bold"}}
        )
     