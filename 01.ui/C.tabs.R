

### TAB PANELS ###




# : ---------

tabText1 <- "Raw denim you probably haven't heard of them jean shorts Austin. 
            Nesciunt tofu stumptown aliqua, retro synth master cleanse. Mustache 
            cliche tempor, williamsburg carles vegan helvetica. Reprehenderit 
            butcher retro keffiyeh dreamcatcher synth. Raw denim you probably 
            haven't heard of them jean shorts Austin. Nesciunt tofu stumptown 
            aliqua, retro synth master cleanse"

tabText2 <- "Cosby sweater eu banh mi, qui irure terry richardson ex squid. 
            Aliquip placeat salvia cillum iphone. Seitan aliquip quis cardigan 
            american apparel, butcher voluptate nisi qui."

tabText3 <- "Raw denim you probably haven't heard of them jean shorts Austin. 
            Nesciunt tofu stumptown aliqua, retro synth master cleanse. 
            Mustache cliche tempor, williamsburg carles vegan helvetica. 
            Reprehenderit butcher retro keffiyeh dreamcatcher synth"



# A. Input =============================================================================


## Single File ----------------------------------------------

t_input_consuntivo_eco = 
      
   argonPage(
       
       argonRow(
           
           argonCard(title = 'Table', width = 12,
                  
                reactable(mtcars,
                          highlight = TRUE)
                
                )
                  
              ) ,
              
        br(),
       
       argonRow(
           
           argonColumn(width = 6,
           
           argonCard(width = 12, icon = NULL,
                  
               mtcars |> hchart("scatter", hcaes(x = mpg, y = cyl)) 
                  
                )),

               argonColumn(
      width = 6,    
      
      argonCard(width = 12,
      
      argonTabSet(
        id = "tab-1",
        card_wrapper = TRUE,
        horizontal = TRUE,
        circle = FALSE,
        size = "sm",
        width = 12,
        iconList = lapply(X = 1:3, FUN = argonIcon, name = "atom"),
        argonTab(
          tabName = "Tab 1",
          active = FALSE,
          tabText1
        ),
        argonTab(
          tabName = "Tab 2",
          active = TRUE,
          tabText2
        ),
        argonTab(
          tabName = "Tab 3",
          active = FALSE,
          argonSection(p('sth'))
        )
      )           
                
              ))
              
   )

)



# X. Analysis =============================================================================







