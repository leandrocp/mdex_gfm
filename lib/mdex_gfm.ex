defmodule MDExGFM do
  @external_resource "README.md"

  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC -->")
             |> Enum.fetch!(1)

  alias MDEx.Document

  @options [
    extension: [
      alerts: true,
      autolink: true,
      footnotes: true,
      shortcodes: true,
      strikethrough: true,
      table: true,
      tagfilter: true,
      tasklist: true
    ],
    parse: [
      relaxed_autolinks: true,
      relaxed_tasklist_matching: true
    ],
    render: [
      github_pre_lang: true,
      full_info_string: true,
      unsafe: true
    ]
  ]

  @doc """
  Attaches the MDExGFM plugin into the MDEx document.

  **Note** it does not change the syntax highlighting options to use any GitHub theme automatically,
  but you can set it manually in the `syntax_highlight` options, for example:

      html =
        MDEx.to_html!(mdex,
          document: markdown,
          syntax_highlight: [formatter: {:html_inline, theme: "github_light"}]
        )

  """
  @spec attach(Document.t(), keyword()) :: Document.t()
  def attach(document, _options \\ []) do
    document
    |> Document.put_extension_options(@options[:extension])
    |> Document.put_parse_options(@options[:parse])
    |> Document.put_render_options(@options[:render])
  end
end
