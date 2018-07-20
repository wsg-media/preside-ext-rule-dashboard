<cfoutput>
    #renderView( view="/admin/layout/sidebar/_menuItem", args={
          active       = false
        , title        = "Dashboard"
        , link         = event.buildAdminLink( linkTo="dashboard" )
        , icon         = "fa-tachometer"
    } )#
</cfoutput>