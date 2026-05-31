from setuptools import setup
from setuptools.command.build_py import build_py
from setuptools.command.sdist import sdist

import os


def write_version_file(root, version):
    version_file = os.path.join(root, "miasm", "VERSION")
    os.makedirs(os.path.dirname(version_file), exist_ok=True)
    with open(version_file, "w", encoding="utf-8") as fdesc:
        fdesc.write(version)


class MiasmBuildPy(build_py):
    def run(self):
        super().run()
        write_version_file(self.build_lib, self.distribution.get_version())


class MiasmSdist(sdist):
    def make_release_tree(self, base_dir, files):
        super().make_release_tree(base_dir, files)
        write_version_file(base_dir, self.distribution.get_version())


setup(
    cmdclass={
        "build_py": MiasmBuildPy,
        "sdist": MiasmSdist,
    },
)
