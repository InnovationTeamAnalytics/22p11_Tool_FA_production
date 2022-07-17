
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
      
       tags$style(".topimg {
                            margin-left: 0px;
                            margin-right: 20px;
                            margin-top: -17px;
                            margin-bottom: -60px;
                          }"))
      )


# FOOTER =======================================================================

tag_foot_1 = 
    
        tags$style(".footer{
                      position: absolute;
                      bottom: 0; 
                      width: 100%;
                      background-color: rgba(248, 249, 250, .9);
                   }")

        
tag_foot_2 = 
        
        tags$style(".bottomimg {
                            margin-left:-10px;
                            margin-right: 0px;
                            margin-top: 12px;
                            margin-bottom: 0px;
                            
                          }")        


footer_def = 
    
    tagList(
        
        tag_foot_1, tag_foot_2, 
    
    footer = tags$div(
        
       class = "footer",
       
       fluidRow(
         column(4, div(style = 'text-align: left; margin-left: -80px', img(class = "bottomimg", src = "mbs_footer.svg", width = '100%', height = '30px'))),
         column(4, p('', style = "text-align: center; padding-top: 14px; color: #002b36")),
         column(4, p('www.mbsconsulting.com - 2022 | All Rights reserved.', style = "text-align: right; padding-top: 14px; padding-right: 10px;  color: #002b36"))
       
         ))
    )