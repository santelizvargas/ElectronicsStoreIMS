"""
    Sql alchemy database module
"""
from typing import Iterator
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from v1.config import database_url


__DATABASE_URL = database_url()

engine = create_engine(
    __DATABASE_URL,
    future=True
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
)


def get_session() -> Session:
    db = SessionLocal()
    try:
        return db
    finally:
        db.close()
