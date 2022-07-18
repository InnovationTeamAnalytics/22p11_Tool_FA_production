
default_th <-

    bs_theme(

      version = 5,

        bootswatch = 'zephyr',

            primary = "#037f8c",
            secondary = '#8FBCBB',

            success = '#006e6e',
            info = '#e9f0ef',
            warning = '#81A1C1',
            danger = '#c37e83',

      font_scale = 1,
      
      base_font = font_google("Open Sans"),
      heading_font = font_google("Poppins"),
      
     "navbar-nav-link-padding-x" = "15px"

        )

bs_theme_update(default_th, spacer = "0.5rem")
#bs_theme_preview(default_th)

### reactable global theme
options(reactable.theme = react_format)
header_tables = colDef(headerStyle = list(background = "#8FBCBB", borderColor = "#8FBCBB", color = '#042326', cursor = "pointer"),
                       format = colFormat(separator = FALSE, digits = 0),
                       align = "center")



# HEADER =======================================================================

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
                            top: 10px;
                          }"),
       
       tags$style(" nav { box-shadow: 0 1px 2px 0 rgba(0,0,0,.2);}"))
      )


