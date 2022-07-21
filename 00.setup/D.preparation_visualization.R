

# :=======================================================================================



# A. Budget =============================================================================================================

## 1. Ricavi -----------------------------------------------------------

### Groupage ---------------

dt_budget_eco_current_ricavi = merge(dt_budget_eco_current_ricavi, dt_budget_eco_current_ricavi_tot, by = c('cdc_raggruppamenti_adj', 'tipo_voce', 'ter_cod_adj'))
setorder(dt_budget_eco_current_ricavi, tipo_voce, cdc_raggruppamenti_adj, -total)
