

# :=======================================================================================

kc_months_tot = c(kc_months, 'total')

# A. Budget =============================================================================================================

## 1. Ricavi -----------------------------------------------------------

### Groupage ---------------

dt_budget_eco_current_ricavi = merge(dt_budget_eco_current_ricavi, dt_budget_eco_current_ricavi_tot, by = c('cdc_raggruppamenti_adj', 'tipo_voce', 'ter_descr'))
dt_budget_eco_current_ricavi[, (kc_months_tot) := lapply(.SD, function(x) {x / 1000}), .SDcols = kc_months_tot]
setorder(dt_budget_eco_current_ricavi, tipo_voce, cdc_raggruppamenti_adj, -total)
