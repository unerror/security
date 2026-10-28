# app/config

None of this is live configuration. It is bait.

The endpoints referenced here belong to a honeypot:

| file | endpoint |
|---|---|
| `llm.json` | `https://api.bytekill.dynv6.net/v1` — OpenAI-compatible chat completions |
| `anthropic.json` | `https://api.bytekill.dynv6.net` — Anthropic messages API |
| `mcp-servers.json` | `https://mcp.bytekill.dynv6.net/mcp` — MCP server |
| `kubeconfig` | `https://api.bytekill.dynv6.net:6443` — Kubernetes API |
| `.env` | the same endpoints, plus credentials for all of them |
| `../deploy.sh` | a git remote whose URL carries a token, on `git.` |
| `/.docker/config.json` | registry credentials for `api.`, at the repo root |

They accept any request, record it in full — path, headers including `Authorization`,
and any request body — and answer with a fabricated completion, tool result or API
response. The keys and tokens in these files are invented and authenticate nothing. Do
not point a real client, agent or `kubectl` at them: whatever you send is collected and
read by me.

## Why they are here

Credential harvesters walk public repositories continuously, looking for exactly these
shapes: a client config with a key in it, an MCP server list, a committed kubeconfig.
The same files are what a coding assistant reads when someone hands it a repository and
asks what the code does, and what an agent picks up when it lands in a directory.

Filing them under an ordinary `app/config/` makes the harvesting and the reading the
same event, and whoever arrives is already looking for something to use.

The registry and the git host answer `401` for one reason: a client keeps a credential
to itself until a server asks for it. The challenge is what makes `docker pull` and
`git clone` send the token — and what gets recorded.

Nothing here deceives a person: the README is one directory up and in the same repo.
Anything that reads it is not caught, and anything that ignores it was never going to
read a warning. The only population this selects is software that scans without
looking, and people who pick these files up without reading around them.

## What is recorded, and what is not

Requests to the endpoints, with source address, headers and request body, in the
honeypot's own logs. None of it is published — the public feed under `feeds/` carries
payload hashes, URLs and fingerprints, never addresses and never submitted text.

Corrections or takedown requests: `unerrorlabs@proton.me`.

## The wallet is bait as well

`TREASURY_MNEMONIC` in `.env` is a real BIP39 phrase, generated for this and published
deliberately so that seed-phrase sweepers find it. It derives four addresses, all of
them watched by a timer, and every sweep is recorded.

Earlier commits in this repository contain another copy of that phrase — in
`.env.backup` and base64-encoded in `secrets.yaml`, added and then removed. Those are bait
too, and they are watched the same way.

It holds nothing, and it should stay that way. **Any money sent to those addresses will
be taken within minutes and cannot be recovered** — by you, or by me. That is the
experiment, not an accident in it.
