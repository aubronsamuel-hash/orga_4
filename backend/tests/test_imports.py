import pkgutil
import importlib
import app


def test_import_all_app_modules():
    for m in pkgutil.walk_packages(app.__path__, app.__name__ + '.'):
        importlib.import_module(m.name)
