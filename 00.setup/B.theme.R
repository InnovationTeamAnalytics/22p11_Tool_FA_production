



# : ================================




# A. Main Theme =======================================================================


default_th <-

    bs_theme(

      version = 5,

        bootswatch = 'zephyr',

            primary = "#225E64",
            secondary = '#8FBCBB',

            success = '#196774',
            info = '#e9f0ef',
            warning = '#81A1C1',
            danger = '#c37e83',

      font_scale = 0.875,
      
      base_font = font_google("Open Sans"),
      heading_font = font_google("Open Sans"),
      
     "navbar-nav-link-padding-x" = "15px",
     "navbar-nav-min-height" = '100px'

        )

bs_theme_update(default_th, spacer = "0.25rem")
#bs_theme_preview(default_th)

### reactable global theme
options(reactable.theme = react_format)
header_tables = colDef(headerStyle = list(background = "#8FBCBB", borderColor = "#8FBCBB", color = '#042326', cursor = "pointer"),
                       format = colFormat(separator = FALSE, digits = 0),
                       align = "center")



# B. Navbar =======================================================================

header_def = 
    
    tagList(
    
      tags$head(
      
       tags$style(".topimg_left {
                            margin-left: 0px;
                            margin-right: 20px;
                            margin-top: -17px;
                            margin-bottom: -60px;
                          }"),
       
       tags$style(".topimg_right {
                            margin-left: 0px;
                            margin-right: 0px;
                            margin-top: 0px;
                            margin-bottom: 0px;
                            position: fixed;
                            right: 20px;
                            top: 20px;
                          }"),
       
       tags$style(" nav { box-shadow: 0 1px 2px 0 rgba(0,0,0,.2);}"),
       
       tags$style(HTML('.navbar-nav > li > a, .navbar-brand {
                         padding-top:15px !important; 
                         padding-bottom:0 !important;
                         height: 50px;
                         font-size: 14px;
                         }
                        .navbar {min-height:50px !important;}'))
         ) 
      )
      




# C. Boxes =======================================================================

title_card =  
    
  "padding: 1rem 1.5rem;
   color: white;
   margin-bottom: 10px;
   margin-right: 5px;
   margin-left: 5px;
   background-color: rgba(0,0,0,0.03);
   border-radius: .375rem;
   border-bottom: 1px solid rgba(0,0,0,0.25);
   box-shadow: 0 1px 2px 0 rgba(0,0,0,.2);"


ricavi_card =  
    
  "padding: 1rem 1.5rem;
   color: white;
   margin-bottom: 0;
   margin-right: 5px;
   margin-left: 5px;
   background-color: #04BF8A;
   border-radius: .375rem;
   border-bottom: 1px solid rgba(0,0,0,0.125);
   box-shadow: 0 1px 2px 0 rgba(0,0,0,.2);"



table_card =  
    
  "
   color: white;
   padding-top: 20px;
   margin-top: 3px;
   margin-bottom: 3px;
   margin-right: 8px;
   margin-left: 8px;
   background-color: #fff;
   border-radius: .375rem;
   border-bottom: 1px solid rgba(0,0,0,0.125);
   box-shadow: 0 1px 2px 0 rgba(0,0,0,.2);"
  

text_title = 
    
    "color:#196774; text-align:center"

# X. Extras =======================================================================

react_ricavi = reactable::reactableTheme(

  color = "#363636",
  tableStyle = list(fontSize = 12),
  headerStyle = list(backgroundColor = "#04BF8A", color = 'white', fontSize = 14),

  backgroundColor = "#ffffff",
  borderColor = "#dfe2e5",
  stripedColor = "#f6f6f6",
  highlightColor = "#DCE4F2",

  cellPadding = "8px 12px",
  style = list(fontFamily = 'Open Sans'),

  searchInputStyle = list(width = "100%"),

  pageButtonHoverStyle = list(backgroundColor = "#DCE4F2", color = 'white'),
  pageButtonActiveStyle = list(backgroundColor = "#87A1B0", color = 'white'),

  selectStyle = list(backgroundColor = "#87A1B0", color = 'white')

)


