from setuptools import setup, find_packages
import os

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name="detailed-neofetch",
    version="1.0.0",
    author="Beau Bruins",
    author_email="beaubruins150@gmail.com",
    description="A more detailed version of neofetch",
    long_description=read('README.md'),
    long_description_content_type="text/markdown",
    license="MIT",
    url="https://github.com/Lilsan444/detailed-neofetch",
    packages=find_packages(),
    classifiers=[
        "Programming Language :: Python",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    scripts=['bin/detailed-neofetch'],
    include_package_data=True,
)
