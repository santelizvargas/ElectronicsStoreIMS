"""
    Dependencies which can be used for DI
"""
from functools import lru_cache
from v1.core.models.database_settings import DatabaseSettings

@lru_cache()
def create_database_settings() -> DatabaseSettings:
    return DatabaseSettings()
