from sqlalchemy import text
from app.db.session import engine


def test_tables_exist():
    with engine.connect() as c:
        res = c.execute(
            text(
                "select table_name from information_schema.tables "
                "where table_schema='public'"
            )
        )
        names = {r[0] for r in res}
    assert "orgs" in names and "users" in names
