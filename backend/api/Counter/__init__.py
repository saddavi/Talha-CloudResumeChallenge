import logging
import azure.functions as func
import json

app = func.FunctionApp()

@app.function_name("counter")
@app.route(route="counter")
def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Simple counter function processed a request.')
    return func.HttpResponse(
        json.dumps({"count": 123}),
        mimetype="application/json",
        status_code=200
    )