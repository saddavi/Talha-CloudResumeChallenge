import azure.functions as func
import datetime
import json
import logging
import os
from pymongo import MongoClient

app = func.FunctionApp()

@app.function_name("VisitorCounterUnique")
@app.route(route="VisitorCounter", auth_level=func.AuthLevel.ANONYMOUS)
def VisitorCounterUnique(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Processing HTTP request for VisitorCounterUnique.")

    try:
        # Ensure COSMOS_CONNECTION_STRING is correctly set in your environment or local.settings.json
        cosmos_connection_string = os.environ["COSMOS_CONNECTION_STRING"]
        client = MongoClient(cosmos_connection_string)
        db = client["visitordb"]
        collection = db["visitors"]

        # Get or create the visitor count document
        visitor_doc = collection.find_one({"id": "visitor_count"})
        if not visitor_doc:
            visitor_doc = {"id": "visitor_count", "count": 0}
            collection.insert_one(visitor_doc)

        # Increment the visitor count
        new_count = visitor_doc["count"] + 1
        collection.update_one({"id": "visitor_count"}, {"$set": {"count": new_count}})

        # Return the updated visitor count
        return func.HttpResponse(
            f"Visitor count: {new_count}",
            mimetype="text/plain",
            status_code=200
        )

    except Exception as e:
        logging.error(f"Error processing the visitor counter: {e}")
        return func.HttpResponse(
             f"Error: {e}",
             status_code=500
        )

{
  
}
