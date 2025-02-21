import logging
import azure.functions as func
import os
from pymongo import MongoClient

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        # Get connection string from environment variable
        cosmos_connection_string = os.environ["COSMOS_CONNECTION_STRING"]
        client = MongoClient(cosmos_connection_string)
        db = client["visitordb"]
        collection = db["visitors"]

        # Get or create the visitor count document
        visitor_count_doc = collection.find_one({"id": "visitor_count"})
        if not visitor_count_doc:
            visitor_count_doc = {"id": "visitor_count", "count": 0}
            collection.insert_one(visitor_count_doc)

        # Increment the visitor count
        new_count = visitor_count_doc["count"] + 1
        collection.update_one({"id": "visitor_count"}, {"$set": {"count": new_count}})

        # Return the new count
        return func.HttpResponse(
            f"Visitor count: {new_count}",
            mimetype="text/plain",
            status_code=200
        )
    except Exception as e:
        logging.error(f"Error: {e}")
        return func.HttpResponse(
             "Error",
             status_code=500
        )