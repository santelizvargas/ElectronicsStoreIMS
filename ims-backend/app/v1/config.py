from v1.core.models.database_settings import DatabaseSettings
from v1.dependencies import create_database_settings

__SETTINGS: DatabaseSettings = create_database_settings()

def database_url() -> str:
    return 'postgresql://{db_user}:{db_pass}@{db_host}/{db_name}'.format(
        **dict(__SETTINGS)
    )
