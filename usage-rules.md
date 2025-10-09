# MDExGFM Usage Rules

MDExGFM is an Elixir plugin for [MDEx](https://hex.pm/packages/mdex) that enables [GitHub Flavored Markdown](https://github.github.com/gfm) support.

## What is MDExGFM?

MDExGFM is a lightweight plugin that configures MDEx with GFM-specific options to enable GitHub-style markdown rendering. It provides a single function `attach/2` that applies all necessary configuration to an MDEx document.

## Installation

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:mdex_gfm, "~> 0.1"}
  ]
end
```

## Basic Usage

The primary pattern for using MDExGFM:

```elixir
# Create MDEx document and attach GFM plugin
mdex = MDEx.new(markdown: markdown_string) |> MDExGFM.attach()

# Convert to HTML
html = MDEx.to_html!(mdex)
```

### Common Mistakes to Avoid

1. **Don't** attach GFM options manually - use `MDExGFM.attach/2`:
   ```elixir
   # Wrong - manually setting options
   MDEx.new(
     markdown: markdown,
     extension: [table: true, strikethrough: true]
   )

   # Correct - use MDExGFM.attach/2
   MDEx.new(markdown: markdown) |> MDExGFM.attach()
   ```

2. **Don't** forget that `attach/2` returns the modified document:
   ```elixir
   # Wrong - not capturing the result
   mdex = MDEx.new(markdown: markdown)
   MDExGFM.attach(mdex)
   MDEx.to_html!(mdex)  # GFM not enabled!

   # Correct - capture the result
   mdex = MDEx.new(markdown: markdown) |> MDExGFM.attach()
   MDEx.to_html!(mdex)
   ```

## GFM Features Enabled

When you attach MDExGFM, the following features are automatically enabled:

### 1. Alerts (GitHub-style callouts)

```markdown
> [!NOTE]
> Useful information

> [!WARNING]
> Critical content
```

Renders as:
```html
<div class="markdown-alert markdown-alert-note">
<p class="markdown-alert-title">Note</p>
<p>Useful information</p>
</div>
```

### 2. Task Lists

```markdown
- [x] Completed task
- [ ] Pending task
```

Renders as:
```html
<ul>
<li><input type="checkbox" checked="" disabled="" /> Completed task</li>
<li><input type="checkbox" disabled="" /> Pending task</li>
</ul>
```

### 3. Tables

```markdown
| Header 1 | Header 2 |
|----------|----------|
| Cell 1   | Cell 2   |
```

### 4. Strikethrough

```markdown
~~deleted text~~
```

### 5. Autolinks

URLs and email addresses are automatically converted to links:
```markdown
https://example.com
user@example.com
```

### 6. Footnotes

```markdown
Here's a sentence with a footnote[^1].

[^1]: This is the footnote.
```

### 7. Shortcodes

Emoji and other shortcode support:
```markdown
:smile: :+1:
```

## Advanced Usage

### Custom Syntax Highlighting

MDExGFM doesn't automatically set syntax highlighting themes. Configure them separately:

```elixir
mdex = MDEx.new(markdown: markdown) |> MDExGFM.attach()

html = MDEx.to_html!(mdex,
  syntax_highlight: [formatter: {:html_inline, theme: "github_light"}]
)
```

Available GitHub themes:
- `"github_light"`
- `"github_dark"`
- `"github_dark_dimmed"`

### Combining with Other MDEx Options

You can still pass additional MDEx options:

```elixir
mdex =
  MDEx.new(
    markdown: markdown,
    # Other MDEx options
    features: [smart_punctuation: true]
  )
  |> MDExGFM.attach()
```

## Pipeline Integration

MDExGFM works well in Elixir pipelines:

```elixir
markdown
|> String.trim()
|> then(&MDEx.new(markdown: &1))
|> MDExGFM.attach()
|> MDEx.to_html!()
|> Phoenix.HTML.raw()
```

## Configuration Options

The `attach/2` function accepts an optional keyword list of options (currently unused but reserved for future configuration):

```elixir
MDExGFM.attach(mdex, [])  # Options parameter available for future use
```

## Internal Configuration

For reference, MDExGFM configures the following MDEx options:

**Extensions:**
- `alerts: true` - GitHub-style alert blocks
- `autolink: true` - Automatic URL linking
- `footnotes: true` - Footnote support
- `shortcodes: true` - Emoji shortcodes
- `strikethrough: true` - Strikethrough text
- `table: true` - Table support
- `tagfilter: true` - Filter potentially unsafe HTML tags
- `tasklist: true` - Task list checkboxes

**Parse Options:**
- `relaxed_autolinks: true` - More lenient autolink detection
- `relaxed_tasklist_matching: true` - Flexible task list syntax

**Render Options:**
- `github_pre_lang: true` - GitHub-style code block language classes
- `full_info_string: true` - Preserve full info string in code blocks
- `unsafe: true` - Allow raw HTML (use with caution)

## Security Considerations

MDExGFM sets `unsafe: true` by default to match GitHub's behavior, which allows raw HTML in markdown. If you're processing untrusted user input, consider sanitizing the output HTML or using a more restrictive configuration.

## Best Practices

1. **Always use the pipeline operator** for clarity:
   ```elixir
   mdex = MDEx.new(markdown: markdown) |> MDExGFM.attach()
   ```

2. **Set syntax highlighting themes explicitly** when needed:
   ```elixir
   MDEx.to_html!(mdex, syntax_highlight: [formatter: {:html_inline, theme: "github_light"}])
   ```

3. **Keep markdown content separate** from configuration:
   ```elixir
   # Good
   markdown = File.read!("content.md")
   mdex = MDEx.new(markdown: markdown) |> MDExGFM.attach()

   # Avoid inline strings for large content
   ```

4. **Handle errors appropriately**:
   ```elixir
   # Using the bang version for expected success
   html = MDEx.to_html!(mdex)

   # Or handle errors explicitly
   case MDEx.to_html(mdex) do
     {:ok, html} -> html
     {:error, reason} -> handle_error(reason)
   end
   ```

## Related Resources

- [MDEx Documentation](https://hexdocs.pm/mdex)
- [GitHub Flavored Markdown Spec](https://github.github.com/gfm)
- [MDExGFM Documentation](https://hexdocs.pm/mdex_gfm)
