<div align="center">

<img src="https://img.shields.io/badge/⚡-ServerKit-0A0A0A?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+PGNpcmNsZSBjeD0iMTIiIGN5PSIxMiIgcj0iMTAiLz48cGF0aCBkPSJNMTIgNnY2bDQgMiIvPjwvc3ZnPg==" alt="ServerKit Logo" />

# 🚀 **ServerKit**

### ☁️ _Your server, ready in one line._

**Stop configuring. Start shipping.**

---

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu-orange?style=for-the-badge&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](https://github.com/luckywirasakti/serverkit/pulls)

---

<sup>From zero to production in the time it takes to brew coffee. ☕</sup>

</div>

---

## 📦 What's Inside

| Script | Description | One-Liner |
| :--- | :--- | :--- |
| 🌐 **9Router** | Node.js router with dashboard & systemd auto-start | `curl ... \| bash` |
| 🔒 **Caddy** | Reverse proxy with automatic HTTPS | `curl ... \| bash -s -- domain:port` |

---

## 🌐 9Router — Routing, Reinvented

> _Spin up a Node.js router that runs forever. Auto-restarts, auto-boots, auto-magic._

### 🎯 What You Get

- ⚡ Auto-installs **Node.js 22** if missing
- 📦 Global npm install of `9router`
- 🔁 Systemd service with `Restart=always`
- 🚀 Boots on system startup

### 🔥 Fire It Up

```bash
curl -fsSL https://raw.githubusercontent.com/luckywirasakti/serverkit/main/9router.sh | bash
```

### 🌍 Where to Find It

| Resource | URL |
| :--- | :--- |
| 🎛️ Dashboard | `http://localhost:20128/dashboard` |
| 🔌 API | `http://localhost:20128/v1` |

### 🎛️ Mission Control

```bash
# Tail logs in real time
journalctl -u 9router -f

# Restart the service
sudo systemctl restart 9router

# Stop the service
sudo systemctl stop 9router

# Check status
sudo systemctl status 9router
```

---

## 🔒 Caddy — HTTPS on Autopilot

> _Reverse proxy + automatic SSL. Point a domain, run a command, get HTTPS for free._

### 🎯 What You Get

- 🔐 Automatic **Let's Encrypt** SSL certificates
- 🛡️ UFW firewall configured (SSH, HTTP, HTTPS)
- 🌍 Multi-domain support in a single command
- ✅ Config validation before reload

### 🔥 Fire It Up

**One domain, one command:**

```bash
curl -fsSL https://raw.githubusercontent.com/luckywirasakti/serverkit/main/caddy.sh | bash -s -- example.com:8080
```

**Need more? Stack 'em:**

```bash
curl -fsSL https://raw.githubusercontent.com/luckywirasakti/serverkit/main/caddy.sh | bash -s -- \
  example.com:8080 \
  api.example.com:3000 \
  admin.example.com:5000
```

### ⚠️ Before You Roll

- ✅ Domain DNS already pointing to this server's IP
- ✅ Application running on the specified port
- ✅ User has `sudo` privileges

### 🎛️ Mission Control

```bash
# Tail logs in real time
journalctl -u caddy -f

# Restart Caddy
sudo systemctl restart caddy

# Edit configuration
sudo nano /etc/caddy/Caddyfile

# Validate configuration
sudo caddy validate --config /etc/caddy/Caddyfile
```

---

## 🤯 The Difference

<table>
<tr>
<td>

**😩 The Old Way**

```text
1. Read 5 docs
2. Copy-paste 20 commands
3. Debug why something failed
4. Google obscure error
5. Finally working (1 hour later)
```

</td>
<td>

**🚀 The ServerKit Way**

```bash
curl ... | bash
```

```text
Done. ☕
```

</td>
</tr>
</table>

---

## 🤝 Join the Crew

Got a script that fits the **one-liner philosophy**? Drop a PR.

1. 🍴 Fork the repo
2. 🌿 Create your feature branch (`git checkout -b feature/amazing-script`)
3. 💾 Commit your changes (`git commit -m 'Add amazing-script'`)
4. 🚀 Push to the branch (`git push origin feature/amazing-script`)
5. 🎉 Open a Pull Request

---

## 📄 The Fine Print

[MIT](./LICENSE) © [luckywirasakti](https://github.com/luckywirasakti)

<div align="center">
<sub>Built with ❤️ for developers who'd rather ship than configure.</sub>
</div>