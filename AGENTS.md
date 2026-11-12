<!-- LOVABLE:BEGIN -->
> [!IMPORTANT]
> This project is connected to [Lovable](https://lovable.dev). Avoid rewriting
> published git history — force pushing, or rebasing/amending/squashing commits
> that are already pushed — as it rewrites history on Lovable's side and the
> user will likely lose their project history.
>
> Commits you push to the connected branch sync back to Lovable and show up in
> the editor, so keep the branch in a working state.
<!-- LOVABLE:END -->

## Project architecture

- Use Lovable Cloud as the source of truth for editable archive records, media metadata, inquiries, and administrator roles; bundled legacy photographs remain read-only fallbacks so the original field archive is never lost.
- Serve published private-bucket media through a public server function that signs only rows marked published; keep storage object reads admin-only.
