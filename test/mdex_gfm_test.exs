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

    html = MDEx.new(markdown: markdown) |> MDExGFM.attach() |> MDEx.to_html!()

    assert html ==
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

  test "attaches extension options" do
    mdex = MDEx.new() |> MDExGFM.attach()
    opts = mdex.options[:extension]

    assert Keyword.take(opts, [
             :alerts,
             :autolink,
             :footnotes,
             :shortcodes,
             :strikethrough,
             :table,
             :tagfilter,
             :tasklist
           ]) ==
             [
               alerts: true,
               autolink: true,
               footnotes: true,
               shortcodes: true,
               strikethrough: true,
               table: true,
               tagfilter: true,
               tasklist: true
             ]
  end

  test "attaches parse options" do
    mdex = MDEx.new() |> MDExGFM.attach()
    opts = mdex.options[:parse]

    assert Keyword.take(opts, [:relaxed_autolinks, :relaxed_tasklist_matching]) ==
             [
               relaxed_autolinks: true,
               relaxed_tasklist_matching: true
             ]
  end

  test "attaches render options" do
    mdex = MDEx.new() |> MDExGFM.attach()
    opts = mdex.options[:render]

    assert Keyword.take(opts, [:github_pre_lang, :full_info_string, :unsafe]) ==
             [
               github_pre_lang: true,
               full_info_string: true,
               unsafe: true
             ]
  end
end
