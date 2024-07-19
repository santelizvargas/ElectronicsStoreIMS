"""
    Config module
"""
from pydantic_settings import BaseSettings
import os


class DatabaseSettings(BaseSettings):
    app_name: str = 'ElectronicsStoreIMS Backend'

    db_host: str = os.environ.get('DB_HOST', 'localhost')
    db_user: str = os.environ.get('DB_USER', 'postgres')
    db_port: int = os.environ.get('DB_PORT', 5432)
    db_pass: str = os.environ.get('DB_PASS', 'password')
    db_name: str = os.environ.get('DB_NAME', 'ims')
