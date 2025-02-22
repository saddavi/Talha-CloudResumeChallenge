import unittest
import azure.functions as func
from src.VisitorCounter import main
from unittest.mock import patch, MagicMock
import os

class TestVisitorCounter(unittest.TestCase):
    def setUp(self):
        # Set up test environment variable with a fake connection string
        os.environ["COSMOS_CONNECTION_STRING"] = "mongodb://mockdb:27017"

    @patch('src.VisitorCounter.MongoClient')
    def test_counter_increment(self, mock_client):
        # Create mock collection with proper return values
        mock_collection = MagicMock()
        mock_collection.find_one.return_value = {"id": "visitor_count", "count": 41}
        mock_collection.update_one.return_value = MagicMock(ok=1)

        # Set up mock chain using direct attribute access
        mock_db = MagicMock()
        # In our function, we do: db = client["visitordb"] and then collection = db["visitors"]
        mock_db.__getitem__.return_value = mock_collection

        mock_client_instance = MagicMock()
        mock_client_instance.__getitem__.return_value = mock_db
        mock_client.return_value = mock_client_instance

        # Test request
        req = func.HttpRequest(
            method='GET',
            body=None,
            url='/api/VisitorCounter',
            params={}
        )

        # Run test
        response = main(req)

        # Verify that find_one and update_one were called with the correct parameters
        mock_collection.find_one.assert_called_once_with({"id": "visitor_count"})
        mock_collection.update_one.assert_called_once_with(
            {"id": "visitor_count"},
            {"$set": {"count": 42}}
        )

        # Assertions to confirm the response contains the incremented count
        self.assertEqual(response.status_code, 200)
        self.assertIn("42", response.get_body().decode())

    def tearDown(self):
        if "COSMOS_CONNECTION_STRING" in os.environ:
            del os.environ["COSMOS_CONNECTION_STRING"]