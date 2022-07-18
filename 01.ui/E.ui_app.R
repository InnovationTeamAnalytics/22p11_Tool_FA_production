

### UI WRAPPER ###





# : ============================================================================================================================



ui_app <-


# Header ================================================================================

navbarPage(
    
      title = div(div(class = "topimg_left", img(src = "innteamc.svg", width = '100%', height = '40px')), div(class = "topimg_right", img(src = "mbscvd.svg", width = '100%', height = '40px'))),
      windowTitle = 'MBS |  Controllo Finanziario',
      theme = default_th,
      header = header_def,
      footer = NULL,



# A. Input =============================================================================
  
navbarMenu(

     title = 'Input',

     tabPanel(

          title = 'Consuntivo',

          t_input_consuntivo_eco 

     ),


     "----",

     tabPanel(

          title = 'Budget Economico',

          t_input_budget_eco = 'placeholder'

     ),
     
     tabPanel(

          title = 'Budget Finanziario',

          t_input_budget_fin = 'placeholder'

     ),
     
     "----",
     
     tabPanel(

          title = 'Ipotesi',

          t_input_ipotesi = 'placeholder'

     ),
     
     "----",
     
     tabPanel(

          title = 'Extra',

          t_input_extra = 'placeholder'

     )
     
),     

     
     
# X. Analysis =============================================================================
     
     tabPanel(

          title = 'Analysis',

          'placeholder'

     )


# : ============================================================================================================================





)
