from pymongo import MongoClient
import os
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def verify_setup():
    try:
        connection_string = os.environ.get('COSMOS_CONNECTION_STRING')
        if not connection_string:
            raise ValueError("Connection string not found")
        
        client = MongoClient(connection_string)
        db = client['visitordb']
        
        # Test connection
        server_info = client.server_info()
        logger.info(f"Successfully connected to MongoDB version: {server_info.get('version')}")
        
        # Check if counter exists
        counter = db.visitors.find_one({"id": "visitor_count"})
        if counter:
            logger.info(f"Counter found with value: {counter.get('count')}")
        else:
            logger.warning("Counter not found")
            
    except Exception as e:
        logger.error(f"Verification failed: {str(e)}")
        raise

if __name__ == "__main__":
    verify_setup()