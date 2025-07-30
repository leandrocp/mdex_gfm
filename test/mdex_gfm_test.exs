defmodule MDExGFMTest do
  use ExUnit.Case

  test "gfm" do
    markdown = """
    # GFM

    > [!NOTE]
    > GFM is enabled!

    - [x] Install `:mdex_gfm`
    - [ ] Write your markdown
    """

    mdex = MDEx.new() |> MDExGFM.attach()

    assert MDEx.to_html!(mdex, document: markdown) ==
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
             |> String.trim()
  end
end
