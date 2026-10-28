# security

Feeds produced by a honeypot I run on a single VPS, plus the notes that come out of it.

Nothing here is hand-curated. A timer on the box takes what arrived in the last 24
hours and commits whatever changed, every three hours. A stretch of commits with no
file changes is normal — it means nothing new arrived, not that something broke.

## feeds/honeypot

Honeypot indicators. Refreshed every three hours.

| file | contents |
|---|---|
| `hashes.txt` | SHA-256 of captured payloads, with the family name where one is known |
| `hassh.txt` | SSH client fingerprints of the bots that connected |
| `wallets.txt` | crypto payout addresses requested from fake RPC endpoints |
| `cves.json` | CVE probe counts — which exploit paths were tried, and how often |
| `asns.json` | source ASNs ranked by volume, without any addresses |
| `iocs.csv` | everything above in one table, with first and last seen |
| `iocs.stix.json` | the same as a STIX 2.1 bundle |
| `index.json` | generation time and counts, so you can poll without downloading everything |

### No IP addresses, on purpose

A source IP on a public honeypot is nearly always a compromised camera, router or
shared host with two hundred other tenants. Publishing those blocklists punishes
victims and goes stale within days. Report scanner IPs to the provider's abuse contact
(found via RDAP) or to AbuseIPDB, where they belong.

What is here — file hashes, wallet addresses, SSH client fingerprints, injected public
keys — describes the tooling. It stays true longer and hurts nobody.

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

## Use

Use it however you like. No warranty, no support, no obligation to attribute. If you
need a formal licence, treat it as CC0.

The honeypot is T-Pot with Cowrie, Dionaea, a Caddy front end and a handful of custom
decoys (fake Docker, Kubernetes, Ethereum and MCP endpoints). The lab notes are
private; only the machine-generated output is here.
