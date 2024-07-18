from v1.app import server_v1 as app
from dotenv import load_dotenv
from v1.core.database.postgres.database import get_session
import uvicorn
import os


# Load the environment variables
load_dotenv()

if __name__  == '__main__':
  # Configure the uvicorn server
  uvicorn.run(
    app=app,
    host=os.getenv('HOST', default='0.0.0.0'),
    port=int(os.getenv('PORT', default=8000)),
  )
