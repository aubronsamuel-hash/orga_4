import importlib
import pkgutil


def test_routers_importable():
    pkg = importlib.import_module("app")
    for m in pkgutil.walk_packages(pkg.__path__, pkg.__name__ + "."):
        if ".routers" in m.name or ".routes" in m.name:
            importlib.import_module(m.name)
