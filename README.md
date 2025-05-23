# 🚨 Advanced Endpoint Detection via PowerShell & Sysmon

> 🛡️ Detect fileless payloads, memory injections, stealthy backdoors, and execution tricks — all in native PowerShell.

This script is designed for **blue teams, incident responders, and cybersecurity researchers** looking to monitor advanced techniques used in post-exploitation phases.

> ⚠️ For **ethical and legal reasons**, we do **not** list every evasion vector it detects.  
> What we can say: it covers **the most advanced fileless and in-memory evasion tactics known today**.

---

## ✅ Features

- 📦 Automatic Sysmon download and installation from Microsoft
- 🔍 Monitors **key Sysmon EventIDs** used by advanced attackers
- 🧠 Captures stealthy behavior (injection, pipe abuse, image loading, etc.)
- 🧾 Logs every detection locally to:
