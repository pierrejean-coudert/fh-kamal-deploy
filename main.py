from fasthtml.common import *

app, rt = fast_app()


# kamal health endpoint
@rt("/healthz")
def get():
    return "OK"


# dynamic endpoint
@rt("/change")
def get():
    return P("Nice to be here!")


# home
@rt("/")
def get():
    return Div(
        H1("I'm Deployed :-)"), 
        Div(P("Hello from FastHtml! (click me)"), hx_get="/change")
    )


serve(port=8000)
