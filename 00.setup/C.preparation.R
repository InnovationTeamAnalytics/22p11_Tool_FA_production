

# A. INPUT BUDGET ECONOMICO =============================================================================================

## UPLOAD DATA =================================================================================================

dt_budget_current = read.xlsx(file.path( "data", "budget_current.xlsx"))
dt_budget_current = clean_names(dt_budget_current)
setDT(dt_budget_current)


dt_t_cdc = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Trascodifica_CdC', detectDates = TRUE)
dt_t_analitico = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Trascodifica_Analitico_Bdgt_Eco', detectDates = TRUE)
dt_t_personale = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Trascodifica_Costo_Personale', detectDates = TRUE)
dt_t_cliente_tipo = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Tipo_Cliente', detectDates = TRUE)
dt_t_cliente_expo = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Esportatori', detectDates = TRUE)
dt_t_aliquote = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Aliquota', detectDates = TRUE)
dt_t_condcom = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Condizioni_Commerciali', detectDates = TRUE)
dt_t_condcom_t = read.xlsx(file.path('data', 'support_trascodifiche.xlsx'), sheet = 'Trascodifica_Condizioni_comm_li', detectDates = TRUE)


dt_t_cdc = janitor::clean_names(dt_t_cdc)
dt_t_analitico = janitor::clean_names(dt_t_analitico)
dt_t_personale = janitor::clean_names(dt_t_personale)
dt_t_cliente_tipo = janitor::clean_names(dt_t_cliente_tipo)
dt_t_cliente_expo = janitor::clean_names(dt_t_cliente_expo)
dt_t_aliquote = janitor::clean_names(dt_t_aliquote)
dt_t_condcom = janitor::clean_names(dt_t_condcom)
dt_t_condcom_t = janitor::clean_names(dt_t_condcom_t)


setDT(dt_t_cdc)
setDT(dt_t_analitico)
setDT(dt_t_personale)
setDT(dt_t_cliente_tipo)
setDT(dt_t_cliente_expo)
setDT(dt_t_aliquote)
setDT(dt_t_condcom)
setDT(dt_t_condcom_t)



## DATA TRANSFORMATION =========================================================================================

### CODICI 
dt_budget_current[, id_contabile := paste(con_codice, con_descrizione, sep = " - ") ]
dt_budget_current[, ter_cod_adj := fifelse(ter_cod == "", "Blank", ter_cod)]
dt_budget_current[, ter_cod_adj := fifelse(ter_cod == "---", "Blank", ter_cod)]
dt_budget_current[, ter_cod_adj := fifelse(is.na(ter_cod_adj), "Blank", ter_cod_adj)]
dt_budget_current = merge(x = dt_budget_current, y = dt_t_cdc, by = "cdc_raggruppamenti", all.x = T)
setnames(x = dt_budget_current, old = "riclassifica", new = "cdc_raggruppamenti_adj")


### ID CONTABILE AND CODING
dt_budget_current = merge(x = dt_budget_current, y = dt_t_analitico[, .(cdc_raggruppamenti_adj, con_unlg_liv_2, trascodifica, tipo_voce)], by = c("cdc_raggruppamenti_adj", "con_unlg_liv_2"), all.x = T )
setnames(x = dt_budget_current, old = "trascodifica", "con_unlg_liv_2_adj" )


### COSTO PERSONALE
dt_budget_current = merge(x = dt_budget_current, y = dt_t_personale, by = "id_contabile", all.x = T)
setnames(x = dt_budget_current, 'tipo_costo', 'tipo_costo_personale', skip_absent = TRUE)


### TIPO CLIENTE
dt_budget_current = merge(x = dt_budget_current, y = dt_t_cliente_tipo[, .(ter_cod_adj = soggetto, tipo_cliente)], by = "ter_cod_adj", all.x = TRUE)
dt_budget_current[, tipo_cliente := fifelse(is.na(tipo_cliente), 'Cliente Regolare', tipo_cliente)]


### CONDIZIONI COMMERCIALI
dt_budget_current = merge(x = dt_budget_current, y = dt_t_condcom[, .(ter_cod_adj = soggetto, condizioni_di_pagamento)], by = 'ter_cod_adj', all.x = TRUE)
setnames( x = dt_budget_current, "condizioni_di_pagamento", "condizioni_commerciali_nominali")
dt_budget_current[, condizioni_commerciali_nominali := fifelse(is.na(condizioni_commerciali_nominali), 'ND', condizioni_commerciali_nominali)]



### CONDIZIONI COMMERCIALI NOMINALI
dt_budget_current = merge(x = dt_budget_current, y = dt_t_condcom_t, by = "condizioni_commerciali_nominali", all.x = TRUE)
setnames(dt_t_cliente_expo, "ter_descr", "esportatore")


### CLIENTI EXPORT
dt_budget_current = merge(x = dt_budget_current, y = dt_t_cliente_expo, by.x = 'ter_cod_adj', by.y = "soggetto", all.x = TRUE)
dt_budget_current = dt_budget_current[, esportatore := fifelse(is.na(esportatore), "NO", "SI")]




### ALIQUOTE
dt_budget_current = merge(x = dt_budget_current, y = dt_t_aliquote[, .(ter_cod_adj = soggetto, aliquota = iva_media)], by = 'ter_cod_adj', all.x = TRUE) 



dt_budget_current[, aliquota := fcase(esportatore == 'SI', 0, 
                                      esportatore == 'NO' & !is.na(aliquota), aliquota,
                                      default = 0.22)]




### Long Format -------------------------------------

kc_months = c("gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno", "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre")
dt_budget_eco_current = melt(dt_budget_current, 
                              id.vars = names(dt_budget_current)[!names(dt_budget_current) %in% kc_months],
                              measure.vars = kc_months,
                              variable.name = 'months',
                              value.name = 'valori')


### DATA + IVA
dt_budget_eco_current[, valori_lordoiva := valori * (1 + aliquota)]

kc_wide = names(dt_budget_eco_current)[!names(dt_budget_eco_current) %in% 'valori']

dt_budget_eco_current_wide = dcast(dt_budget_eco_current[, ..kc_wide], ... ~ months, value.var = 'valori_lordoiva')



#saveRDS(dt_budget_current_long, file.path('processed', 'tab_budget_current_long.rds'))



# B. BUDGET ECONOMICO ===================================================================================

## Income:  -----------------------------------------

dt_budget_eco_current_ricavi_long = dt_budget_eco_current[tipo_voce %chin% c('Ricavi', 'Altri ricavi')][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, ter_cod_adj, months)]

dt_budget_eco_current_ricavi_tot_long = dt_budget_eco_current_ricavi_long[, .(subtotal = sum(budget_current, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, months)]
dt_budget_eco_current_ricavi_tot_long[, total := sum(subtotal, na.rm = TRUE), by = .(months)]
dt_budget_eco_current_ricavi_tot_long[, perc_total := subtotal / sum(subtotal, na.rm = TRUE), by = .(months)]


## Costs:  -----------------------------------------

dt_budget_eco_current_costi_long = dt_budget_eco_current[!tipo_voce %chin% c('Ricavi', 'Altri ricavi') & cdc_raggruppamenti_adj != 'Ricavi / Costi indiretti'][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, con_unlg_liv_2_adj, months)]

dt_budget_eco_current_costi_ind_long = dt_budget_eco_current[!tipo_voce %chin% c('Ricavi', 'Altri ricavi', 'Sotto EBITDA') & cdc_raggruppamenti_adj == 'Ricavi / Costi indiretti'][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(tipo_voce, con_unlg_liv_2_adj, months)]

dt_budget_eco_current_costi_ind_long = merge(dt_budget_eco_current_costi_ind_long, dt_budget_eco_current_ricavi_tot_long[tipo_voce == 'Ricavi', .(cdc_raggruppamenti_adj, months, perc_total)],
                                             by =  c('months'), all.x = TRUE, allow.cartesian = TRUE)

dt_budget_eco_current_costi_ind_long[, budget_current := budget_current * perc_total]
dt_budget_eco_current_costi_ind_long[, perc_total := NULL]





# C. INPUT CONSUNTIVO ECONOMICO =============================================================================================

## UPLOAD DATA =================================================================================================

dt_consbe = read.xlsx(file.path('data', 'consuntivo_budget_economico.xlsx'), detectDates = TRUE)
dt_consbe = janitor::clean_names(dt_consbe)
setDT(dt_consbe)


# DATA TRANSFORMATION =========================================================================================

### SOGGETTI ADJ
dt_consbe[, soggetti_adj := fifelse(soggetti == '---', '0', soggetti)]

### CDC RAGGRUPPAMENTI ADJ
dt_consbe = merge(dt_consbe, dt_t_cdc, by = 'cdc_raggruppamenti', all.x = TRUE) |>
    setnames('riclassifica', 'cdc_raggruppamenti_adj', skip_absent=TRUE)

### ANALITICO
dt_consbe = merge(dt_consbe, dt_t_analitico[, .(cdc_raggruppamenti_adj, con_unlg_liv_2, trascodifica, tipo_voce)], by = c('cdc_raggruppamenti_adj', 'con_unlg_liv_2'), all.x = TRUE) |>
    setnames('trascodifica', 'con_unlg_liv_2_adj', skip_absent = TRUE)

### COSTO PERSONALE
dt_consbe = merge(dt_consbe, dt_t_personale, by.x = 'vdc', by.y = 'id_contabile', all.x = TRUE) |>
    setnames('tipo_costo', 'tipo_costo_personale', skip_absent = TRUE)

### TIPO CLIENTE
dt_consbe = merge(dt_consbe, dt_t_cliente_tipo[, .(soggetti_adj = soggetto, tipo_cliente)], by = 'soggetti_adj', all.x = TRUE) 
dt_consbe[, tipo_cliente := fifelse(is.na(tipo_cliente), 'Cliente Regolare', tipo_cliente)]

### CONDIZIONI COMMERCIALI
dt_consbe = merge(dt_consbe, dt_t_condcom[, .(soggetti_adj = soggetto, condizioni_commerciali_nominali = condizioni_di_pagamento)], by = 'soggetti_adj', all.x = TRUE) 
dt_consbe[, condizioni_commerciali_nominali := fifelse(is.na(condizioni_commerciali_nominali), 'ND', condizioni_commerciali_nominali)]

dt_consbe = merge(dt_consbe, dt_t_condcom_t[, .(condizioni_commerciali = condizioni_commerciali_nominali_riclassificato, condizioni_commerciali_nominali, modalita_pagamento)], by = 'condizioni_commerciali_nominali', all.x = TRUE) 

### ESPORTATORI
dt_consbe = merge(dt_consbe, dt_t_cliente_expo[, .(soggetti_adj = soggetto, esportatore)], by = 'soggetti_adj', all.x = TRUE) 
dt_consbe[, esportatore := fifelse(is.na(esportatore), 'NO', 'SI')]

### ALIQUOTE
dt_consbe = merge(dt_consbe, dt_t_aliquote[, .(soggetti_adj = soggetto, aliquota = iva_media)], by = 'soggetti_adj', all.x = TRUE) 
dt_consbe[, aliquota := fcase(esportatore == 'SI', 0, 
                              esportatore == 'NO' & !is.na(aliquota), aliquota,
                              default = 0.22)]


### DATA + IVA
kc_iva = keep_cols(dt_consbe, '2021')
dt_consbe[, (paste0(kc_iva, '_iva')) := lapply(.SD, function(x) { (1 + aliquota) * x }), .SDcols = kc_iva]



# D. BUDGET ECONOMICO =========================================================================================

## RICAVI CALCULATION =========================================================================================

### Income:  -----------------------------------------

dt_budget_eco_current_ricavi_long = dt_budget_eco_current[tipo_voce %chin% c('Ricavi', 'Altri ricavi')][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, ter_descr, months)]

dt_budget_eco_current_ricavi = dcast(dt_budget_eco_current_ricavi_long, ... ~ months, value.var = 'budget_current')
dt_budget_eco_current_ricavi_tot = dt_budget_eco_current_ricavi_long[, .(total = sum(budget_current)), by = c('cdc_raggruppamenti_adj', 'tipo_voce', 'ter_descr')]


dt_budget_eco_current_ricavi_tot_long = dt_budget_eco_current_ricavi_long[, .(subtotal = sum(budget_current, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, months)]
dt_budget_eco_current_ricavi_tot_long[, total := sum(subtotal, na.rm = TRUE), by = .(months)]
dt_budget_eco_current_ricavi_tot_long[, perc_total := subtotal / sum(subtotal, na.rm = TRUE), by = .(months)]


### Costs:  -----------------------------------------

dt_budget_eco_current_costi_long = dt_budget_eco_current[!tipo_voce %chin% c('Ricavi', 'Altri ricavi') & cdc_raggruppamenti_adj != 'Ricavi / Costi indiretti'][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(cdc_raggruppamenti_adj, tipo_voce, con_unlg_liv_2_adj, months)]

dt_budget_eco_current_costi_ind_long = dt_budget_eco_current[!tipo_voce %chin% c('Ricavi', 'Altri ricavi', 'Sotto EBITDA') & cdc_raggruppamenti_adj == 'Ricavi / Costi indiretti'][, .(budget_current = sum(valori, na.rm = TRUE)), by = .(tipo_voce, con_unlg_liv_2_adj, months)]

dt_budget_eco_current_costi_ind_long = merge(dt_budget_eco_current_costi_ind_long, dt_budget_eco_current_ricavi_tot_long[tipo_voce == 'Ricavi', .(cdc_raggruppamenti_adj, months, perc_total)],
                                             by =  c('months'), all.x = TRUE, allow.cartesian = TRUE)

dt_budget_eco_current_costi_ind_long[, budget_current := budget_current * perc_total]
dt_budget_eco_current_costi_ind_long[, perc_total := NULL]


