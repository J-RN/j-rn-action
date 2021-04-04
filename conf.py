# -*- coding: utf-8 -*-
# For a full list of options see http://www.sphinx-doc.org/en/master/config

# -- Path setup --------------------------------------------------------------
import os
import sys

sys.path.insert(0, os.path.abspath('.'))

# -- Project information -----------------------------------------------------
from meta import release, version # NOQA: E402, F401; isort:skip
from meta import (                # NOQA: E402; isort: skip
    authors, copyright_code, copyright_text, description, keywords, title, year)
try:
    from meta import editors
except ImportError:
    editors = []
try:
    from meta import doi
except ImportError:
    doi = ''

project = "The J-RN"

_auths = ["{lastname}, {forenames}".format(**i) for i in authors]
_auths_links = [
    j if 'orcid' not in i else '<a href="https://orcid.org/{orcid}">{j}</a>'.format(j=j, **i)
    for i, j in zip(authors, _auths)]
author = _auths_links[0] if len(
    _auths_links) < 2 else f'{"; ".join(_auths_links[:-1])}, and {_auths_links[-1]}'
copyright = (
    f'{year}'
    f' <a href="https://spdx.org/licenses/{copyright_text}.html">{copyright_text}</a> (text)'
    f' <a href="https://spdx.org/licenses/{copyright_code}.html">{copyright_code}</a> (code)'
    f' {author}')

# -- General configuration ---------------------------------------------------
extensions = [
    'nbsphinx', 'sphinx.ext.mathjax', 'sphinx.ext.githubpages', 'sphinxcontrib.bibtex',
    'sphinx_copybutton', 'sphinx_multiversion']
templates_path = ['_templates']
source_suffix = '.ipynb'
html_sourcelink_suffix = ''
master_doc = 'index'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
language = None
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
# The name of the Pygments (syntax highlighting) style to use.
pygments_style = None

# -- Options for HTML output -------------------------------------------------
html_theme = 'alabaster'
html_theme_options = {
    'analytics_id': "UA-56320088-8", 'show_powered_by': False, 'page_width': "1024px",
    'fixed_sidebar': True, 'logo': "logo.svg"}
html_context = {
    'title': title, 'description': description, 'authors': authors,
    'copyright_code': copyright_code, 'copyright_text': copyright_text, 'year': year,
    'github_repository': os.getenv('GITHUB_REPOSITORY')}
if keywords:
    html_context['keywords'] = keywords
if editors:
    html_context['editors'] = editors
if doi:
    html_context['doi'] = doi
html_static_path = ['_static']
html_sidebars = {"**": ["about.html", "meta.html", "localtoc.html", "versioning.html"]}
html_js_files = ['custom.js']

# -- Options for HTMLHelp output ---------------------------------------------
# Output file base name for HTML help builder.
htmlhelp_basename = 'pagesdoc'

# -- Options for LaTeX output ------------------------------------------------
latex_elements = {'papersize': 'a4paper', 'pointsize': '10pt', 'figure_align': 'htbp'}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [(master_doc, title + '.tex', title, " and ".join(_auths), 'manual')]

# -- Options for manual page output ------------------------------------------
# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [(master_doc, title, title, [author], 1)]

# -- Options for Texinfo output ----------------------------------------------
# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, title, title, " and ".join(_auths), title, description, 'Miscellaneous')]

# -- Extension configuration -------------------------------------------------
nbsphinx_execute_arguments = [
    "--InlineBackend.figure_formats={'svg', 'pdf'}", "--InlineBackend.rc={'figure.dpi': 96}"]
mathjax_config = {'TeX': {'equationNumbers': {'autoNumber': 'AMS', 'useLabelIds': True}}}
bibtex_bibfiles = ['references.bib']
