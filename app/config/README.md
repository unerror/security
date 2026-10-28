# app/config

None of this is live configuration. It is bait.

The endpoints referenced here belong to a honeypot:

| file | endpoint |
|---|---|
| `llm.json` | `https://api.bytekill.dynv6.net/v1` — OpenAI-compatible chat completions |
| `anthropic.json` | `https://api.bytekill.dynv6.net` — Anthropic messages API |
| `mcp-servers.json` | `https://mcp.bytekill.dynv6.net/mcp` — MCP server |
| `kubeconfig` | `https://api.bytekill.dynv6.net:6443` — Kubernetes API |

They accept any request, record it in full — path, headers including `Authorization`,
and any request body — and answer with a fabricated completion, tool result or API
response. The keys and tokens in these files are invented and authenticate nothing. Do
not point a real client, agent or `kubectl` at them: whatever you send is collected and
read by me.

## Why they are here

Credential harvesters walk public repositories continuously, looking for exactly these
shapes: a client config with a key in it, an MCP server list, a committed kubeconfig. The same files are what a
coding assistant reads when someone hands it a repository and asks what the code does,
and what an agent picks up when it lands in a directory.

Filing them under an ordinary `app/config/` makes the harvesting and the reading the
same event, and whoever arrives is already looking for something to use.

Nothing here deceives a person: the README is one directory up and in the same repo.
Anything that reads it is not caught, and anything that ignores it was never going to
read a warning. The only population this selects is software that scans without
looking, and people who pick these files up without reading around them.

## What is recorded, and what is not

Requests to the endpoints, with source address, headers and request body, in the
honeypot's own logs. None of it is published — the public feed under `feeds/` carries
payload hashes, URLs and fingerprints, never addresses and never submitted text.

Corrections or takedown requests: `unerrorlabs@proton.me`.
