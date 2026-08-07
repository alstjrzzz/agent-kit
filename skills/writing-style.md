---
name: "writing-style"
description: "Technical writing guide. Use for technical documents meant to be revisited later, like study notes, troubleshooting logs, or performance/benchmark records."
---

## Technical Writing

A document meant to be revisited later, like study notes, troubleshooting logs, or benchmark records. The goal is fast comprehension on a future re-read. That means cutting meaningless AI-style adverbs and clichés, and writing clear, readable sentences.

### Tone

- Informal register, plain declarative endings. No polite/formal speech.
- Short sentences, one piece of information per sentence. Split long sentences into two.
- Cut meaningless intensifiers like "really," "very," "extremely."
- No AI-style clichés ("truly," "literally," "Today we'll look at..."), no emoji, no excessive bullet points, no hollow reactions.
- Don't coin terms that aren't actually used in practice (like "knowledge bundle"). Use real industry/community terminology if it exists; if not, describe the function plainly instead of forcing a summary noun.
- Don't mix native-language placeholders into file paths, commands, or example code (like a translated "name.md"). Use plausible real-world English names (`pr-code-review.md`, `test-runner`, etc.).
- When explaining a concept that has runnable commands (slash commands, CLI flags, etc.), look up and include the relevant commands.
- Never use em dashes (—), under any circumstances. Use a period or comma instead.
- Never use bold (**). Even to emphasize a term, just write it in plain text.
- Don't open with a reaction or emotion the user never actually expressed (like "this is confusing"). State only the real reason or purpose for writing, briefly.

### Paragraphs

- Keep paragraphs to about 2-4 sentences, with sentences flowing naturally into each other. Don't force a line break after every sentence.
- Only break into a new paragraph when moving to a different point.

### Level of summarization

- Don't try to transcribe everything from the conversation. Since the goal is fast comprehension on a later read, keep only necessary examples or elaboration and cut the rest aggressively.
- Length isn't a fixed sentence count. It's however much the concept actually needs. Keep simple concepts short; give more space to concepts that are easy to misunderstand or get wrong. Don't cut just because it's long, or pad just because it's short.
- Readability and concision are still the default. Even necessary content shouldn't be spelled out at length if it can be compressed further. "As much as needed" doesn't mean cramming in everything; it means not cutting something that's genuinely needed.
- Don't stop at "what it is." When it exists, "why/when to use it" is often more valuable on a later read, so include it when it matters. But don't force a filler line if the purpose is already obvious from the concept or its name.
- Define any term that appears in the piece (including secondary concepts like "marketplace" or "permission mode") briefly on first mention. Don't just attach a parenthetical example without ever stating the actual definition.

### Before writing

Settle on the title and topic before writing.
This is less about the exact title wording and more about pinning down the piece's intent and angle (is it a definition/list, a plan/log, a concept intro, or an application piece).
If the topic isn't clear, propose title candidates and confirm the angle together.
Then propose an outline, or ask how to structure it.
Once the title and outline are set, follow that order.

### Structure

- Use only # and ## headings; don't break down further into ### or below.
- Don't fix the number of sections in advance. Split only as much as the content naturally divides. Don't force independent concepts into groups of two or three under an invented umbrella heading.
- If it gets long enough to be a burden to read in one sitting (mixed topics or a lot of added length), consider splitting into a multi-part series.
- Use code blocks for code, logs, and config values; use tables for comparisons or numeric data.
- For anything expressible as a diagram (architecture, flow, structural relationships), draw it directly as a mermaid code block instead of an `[image: description]` placeholder.
- Only use `[image: description]` placeholders for things mermaid can't render, like screenshots or real photos.
- Don't scatter reference links through the body; collect them in a "References" section at the end.
- For concepts made up of multiple files/folders (Plugin, marketplace, etc.), show a tree structure. For structurally simple, single-file concepts (Command, etc.), a plain text path is fine without a tree. But don't apply the tree-or-not decision inconsistently between concepts of similar complexity.
- Don't turn a classification scheme or comparison axis that was used mid-conversation to explain something into its own standalone section in the piece. If the body's section headings already carry that distinction, a section that re-summarizes it upfront is just clutter. Build the outline around the piece's actual purpose (intro, plan, log, etc.), not around the order the conversation happened to explain things in.

### Splitting into multiple parts

Suggest splitting when topics get mixed, when the length would be a lot to read in one sitting, or when there's tangential content. Number the parts in the title, and add a one-line previous/next-part pointer at the start of each part.

### Output

Save as a `.md` file.
