

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

          t_input_consuntivo 

     ),


     tabPanel(

          title = 'Budgets',

          t_input_budget

     ),
     
     tabPanel(

          title = 'Support',

          t_input_support

     ),
     
     tabPanel(

          title = 'Ipotesi',

          t_input_ipotesi = 'placeholder'

     )
     
),     

     
     
# X. Analysis =============================================================================
     
     tabPanel(

          title = 'Analysis',

          'placeholder'

     )


# : ============================================================================================================================





)
