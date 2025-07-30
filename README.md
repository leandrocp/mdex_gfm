# MDExGFM

[![Hex.pm](https://img.shields.io/hexpm/v/mdex_gfm)](https://hex.pm/packages/mdex_gfm)
[![Hexdocs](https://img.shields.io/badge/hexdocs-latest-blue.svg)](https://hexdocs.pm/mdex_gfm)

<!-- MDOC -->

[MDEx](https://mdelixir.dev) plugin to enable [GitHub Flavored Markdown](https://github.github.com/gfm)

## Usage

````elixir
Mix.install([
  {:mdex_gfm, "~> 0.1"}
])

markdown = """
# GFM

> [!NOTE]
> GFM is enabled!

- [x] Install `:mdex_gfm`
- [ ] Write your markdown
"""

mdex = MDEx.new() |> MDExGFM.attach()

MDEx.to_html!(mdex, document: markdown) |> IO.puts()
"""
<h1>GFM</h1>
<div class="markdown-alert markdown-alert-note">
<p class="markdown-alert-title">Note</p>
<p>GFM is enabled!</p>
</div>
<ul>
<li><input type="checkbox" checked="" disabled="" /> Install <code>:mdex_gfm</code></li>
<li><input type="checkbox" disabled="" /> Write your markdown</li>
</ul>
"""
````

See [attach/2](https://hexdocs.pm/mdex_gfm/MDExGFM.html#attach/2) for more info.
