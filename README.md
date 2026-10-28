# security

Feeds produced by a honeypot I run on a single VPS, plus the notes that come out of it.

Nothing here is hand-curated. A timer on the box takes what arrived in the last 24
hours and commits whatever changed, every three hours. A stretch of commits with no
file changes is normal — it means nothing new arrived, not that something broke.

## feeds/honeypot

Honeypot indicators. Refreshed every three hours.

| file | contents |
|---|---|
| `hashes.txt` | SHA-256 of captured payloads of 1 KB or more, with the family name where known |
| `hassh.txt` | SSH client fingerprints of the bots that connected |
| `wallets.txt` | crypto payout addresses requested from fake RPC endpoints |
| `contacted-domains.txt` | domains a payload would actually contact — only ones inside URLs |
| `payload-urls.txt` | full URLs a payload fetches, including `IP:port` hosts |
| `domains.txt` | every domain referenced by a sample, context only |
| `ai-crawlers.json` | what GPTBot/ClaudeBot/OAI-SearchBot fetched, and whether they honoured robots |
| `cves.json` | CVE probe counts — which exploit paths were tried, and how often |
| `asns.json` | source ASNs ranked by volume, without any addresses |
| `paths.txt` | `count<TAB>path` for what was requested — WAF food |
| `useragents.txt` | `count<TAB>user-agent`, scanners and crawlers included |
| `iocs.csv` | everything above in one table, with first and last seen |
| `iocs.stix.json` | the same as a STIX 2.1 bundle |
| `wallet-sweeps.json` | addresses that emptied a published bait wallet — attacker infrastructure |
| `index.json` | generation time and counts, so you can poll without downloading everything |

Weekly, there is also `summary/<start>_<end>.md` — one page of prose about the week,
in the repo root rather than under `feeds/`.

### Whose address is it?

A scanner's IP on a public honeypot is nearly always a compromised camera, router or
shared host with two hundred other tenants. Publishing those blocklists punishes
victims and goes stale within days — report them to the provider's abuse contact
(found via RDAP) or to AbuseIPDB instead.

An address **inside a payload** is the opposite: when malware carries
`http://45.9.2.239:24381/bins/adb/akuma.arm`, the operator chose that host and serves
binaries from it. Those URLs are published in `payload-urls.txt`, because they are the
most actionable thing a sample contains. The rule is whose address it is: a victim's
is withheld, the attacker's is not.

The exception is infrastructure: an address that appears *inside a payload* is the
attacker's own host, and those are published in `payload-urls.txt` — that is C2 and
staging, not a victim. A source address is the connection, not the tool, and it is never
published.

What else is here — file hashes, wallet addresses, SSH client fingerprints, injected
public keys — describes the tooling. It stays true longer and hurts nobody.

### Consuming it

```sh
# hashes with family names
curl -fsS https://raw.githubusercontent.com/unerror/security/main/feeds/honeypot/hashes.txt

# which CVEs are being probed this week
curl -fsS https://raw.githubusercontent.com/unerror/security/main/feeds/honeypot/cves.json \
  | jq -r '.[] | "\(.probes)\t\(.cve)"'

# STIX into MISP or OpenCTI
curl -fsS https://raw.githubusercontent.com/unerror/security/main/feeds/honeypot/iocs.stix.json \
  -o bundle.json
```

## What this is not

- Not a full picture. One IP, one 24-hour window. A quiet week here means a quiet week
  for this address, nothing more.
- The `family` names come from VirusTotal and MalwareBazaar and are sometimes wrong.
- `cves.json` counts probes against paths associated with a CVE. It is not proof that
  anyone exploited it, and it says nothing about targets other than this box.
- Presence in these files is evidence of activity on one honeypot. Absence means
  nothing at all.

## app/config

Client configs and credentials — OpenAI-compatible, Anthropic, MCP, a kubeconfig, a
`.env`, a deploy script and a `.docker/config.json` — pointing at the honeypot's decoys,
with keys and tokens that authenticate nothing. They are bait for credential harvesters;
`app/config/README.md` says what gets logged. Do not use them in anything real, and do
not point an agent at them.

The `.env` also carries a BIP39 phrase, published so that seed-phrase sweepers find it.
Its addresses are watched and every sweep is recorded in `feeds/honeypot/wallet-sweeps.json`.
Money sent to them is taken; it does not come back.

## Contact

`unerrorlabs@proton.me` for corrections, takedown requests or a false positive.
Include the file and the value; I can pull anything that is wrong.

## Use

Use it however you like. No warranty, no support, no obligation to attribute. If you
need a formal licence, treat it as CC0.

The honeypot is T-Pot with Cowrie, Dionaea, a Caddy front end and a handful of custom
decoys (fake Docker, Kubernetes, Ethereum and MCP endpoints). The lab notes are
private; only the machine-generated output is here.
