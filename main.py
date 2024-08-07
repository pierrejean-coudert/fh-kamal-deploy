from fasthtml.common import *

app,rt = fast_app()

# kamal health endpoint
@rt('/healthz')
def get(): return 'OK'

@rt('/change')
def get(): return P('Nice to be here!')

@rt('/')
def get(): return Div(P('Hello World!'), hx_get="/change")

serve(port=8000)