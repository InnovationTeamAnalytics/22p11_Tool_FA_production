

### UI WRAPPER ###





# : ============================================================================================================================



ui_app <-


# Header ================================================================================

navbarPage(
    
      title = div(class = "topimg", img(src = "innteamc.svg", width = '100%', height = '40px')),
      windowTitle = 'MBS |  Controllo Finanziario',
      theme = default_th,
      header = header_def,
      footer = footer_def,



# A. Input =============================================================================
  
navbarMenu(

     title = 'Input',

     tabPanel(

          title = 'Single File',

          t_upload_single 

     ),


     "----",


     tabPanel(

          title = 'Multiple Files',

          t_upload_multi = 'placeholder'

     )
     
),     

     
     
# X. Analysis =============================================================================
     
     tabPanel(

          title = 'Analysis',

          'placeholder'

     )


# : ============================================================================================================================





)
