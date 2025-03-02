import azure.functions as func
import logging
import os
from pymongo import MongoClient

app = func.FunctionApp()

@app.function_name("VisitorCounterUnique")
@app.route(route="VisitorCounter", auth_level=func.AuthLevel.ANONYMOUS)
def VisitorCounterUnique(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Processing HTTP request for VisitorCounterUnique.")

    try:
        # Log steps for troubleshooting
        logging.info("Getting connection string...")
        cosmos_connection_string = os.environ["COSMOS_CONNECTION_STRING"]
        logging.info("Creating MongoDB client...")
        client = MongoClient(cosmos_connection_string)
        logging.info("Accessing database...")
        db = client["visitordb"]
        logging.info("Accessing collection...")
        collection = db["visitors"]
        logging.info("Finding visitor document...")

        # Get or create the visitor count document
        visitor_doc = collection.find_one({"id": "visitor_count"})
        if not visitor_doc:
            visitor_doc = {"id": "visitor_count", "count": 0}
            collection.insert_one(visitor_doc)

        # Increment the visitor count
        new_count = visitor_doc["count"] + 1
        collection.update_one({"id": "visitor_count"}, {"$set": {"count": new_count}})

        # Return the updated visitor count with CORS headers
        return func.HttpResponse(
            f"Visitor count: {new_count}",
            mimetype="text/plain",
            status_code=200,
            headers={
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET',
                'Access-Control-Allow-Headers': 'Content-Type'
            }
        )

    except Exception as e:
        logging.error(f"Error processing the visitor counter: {e}")
        return func.HttpResponse(
            f"Error: {e}",
            status_code=500
        )
