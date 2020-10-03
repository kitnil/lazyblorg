import sys
from setuptools import setup

MAJOR_VERSION = '0'
MINOR_VERSION = '0'
MICRO_VERSION = '1'
VERSION = "{}.{}.{}".format(MAJOR_VERSION, MINOR_VERSION, MICRO_VERSION)

setup(name='lazyblorg',
      version=VERSION,
      description="Blogging with Org-mode for very lazy people",
      url='https://github.com/novoid/lazyblorg',
      author='Karl Voit',
      author_email='git@Karl-Voit.at',
      license='GPLv3',
      packages=['.', 'lib'],
      classifiers=[
          'Environment :: Console',
          'Intended Audience :: End Users/Desktop',
          'Intended Audience :: Developers',
          'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
          'Operating System :: MacOS :: MacOS X',
          'Operating System :: Unix',
          'Operating System :: POSIX',
          'Programming Language :: Python',
          'Programming Language :: Python :: 3.6',
          'Development Status :: 5 - Production/Stable',
          'Topic :: Office/Business'
      ],
      zip_safe=False,
      entry_points={'console_scripts': ['lazyblorg = lazyblorg:main']},
      platforms='any')
