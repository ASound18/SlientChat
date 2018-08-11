options(shiny.host="10.64.20.23")
options(shiny.port=7401)

library(shiny)
library(shinyjs)

shinyUI(
  bootstrapPage(
    useShinyjs(),
    # We'll add some custom CSS styling -- totally optional
    # includeCSS("css/bootstrap_Lumen.css"),  
    uiOutput("selectCSS"),  
     
    # And custom JavaScript -- just to send a message when a user hits "enter"
    # and automatically scroll the chat window for us. Totally optional.
    includeScript("sendOnEnter.js"), 
    
    div(
      # Setup custom Bootstrap elements here to define a new layout
      class = "container-fluid", 
      div(class = "row-fluid",
          # Set the page title
          tags$head(tags$title("SilentChat")),
          
          # Create the header
          div(class="span6", style="padding: 10px 0px;",
              h1("SilentChat")
              #h4("Hipper than IRC...")
          ),
          
          # Text input for admin password
          div(
              column(3, passwordInput("adminPassWord", "Admin Password: ", placeholder = "Do not even try :p")),
              column(3, conditionalPanel(condition="input.adminPassWord=='yutongchuandatiancai'",
                                         radioButtons("mode_selection", label="", choices=c("Silent Mode","Log Mode"), selected="Silent Mode", inline = TRUE),
                                         actionLink("clearChat", "Clear Chat", icon=icon("eraser"))
                     )),
              column(2, selectInput("css", "Feeling Stylish?",
                                    choices = c("Cerulean","Flaty","Journal","Litera","Pulse","Sketchy","United"), selected = "Sketchy")
                     )
          ),

          div(class="span4", id="play-nice", 
                 "IP Addresses are logged... be a decent human being."
          )
          
          
      ),
      # The main panel
      div(
        class = "row-fluid", 
        mainPanel(
          # Create a spot for a dynamic UI containing the chat contents.
          fluidRow(uiOutput("chat")),  
          
          # Create the bottom bar to allow users to chat.
          fluidRow(
            div(class="span10",
                textInput("entry", "")
            ),
            div(class="span2 left",
                actionButton("send", "Send")
            )
          )
        ),
        # The right sidebar
        sidebarPanel(
          # Let the user define his/her own ID
          textInput("user", "Your User ID:", value=""),
          tags$hr(),
          h5("Connected Users"),
          # Create a spot for a dynamic UI containing the list of users.
          uiOutput("userList"),
          tags$hr(),
          helpText(h5(a("Invite", href="mailto:someone@aig.com?subject= Join me on SlientChat&bcc=tongchuan.yu@aig.com&body=You are invited to join SilentChat. Please use this link http://10.64.20.23:7401/."), "friends to join SilentChat!")),
          # helpText(HTML("<p>Built using R & <a href = \"http://rstudio.com/shiny/\">Shiny</a>.<p>Source code available <a href =\"https://github.com/trestletech/ShinyChat\">on GitHub</a>."))
          helpText(h5("For maintenance, please contact the ", a("developer.", href="mailto:tongchuan.yu@aig.com?subject=SilentChat Maintenance")))
          
        )
      )
    )
  )
)