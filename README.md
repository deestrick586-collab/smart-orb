# 🪐 Smart Orb Network ™ — NSP × DSP Partnership Edition (v1.2)

**What’s new**
- ✅ GitHub Action: `.github/workflows/security-scan.yml` (CodeQL + Appknox stub)  
- 🔔 Orb Notifications: automatic summaries + logs (`notifications/`)  
- 🌈 Mood Engine prototype (`visuals/mood_engine.py`)  
- 🎙️ Voice Engine placeholder (`voice/voice_engine.py`)  
- 🧠 Personality core: *calm & visionary* (`ai/personality_core.json`)  

**Run locally (test notifications)**  
```bash
python - <<'PY'
from notifications.orb_notify import OrbNotifier
n = OrbNotifier()
n.notify({"type":"workflow_passed","meta":{"ref":"local-test","job":"demo"}})
print("Logged to logs/orb_notifications.log")
PY
```

**Enable email/Slack/Discord**  
Edit `notifications/notifications.json` and flip `"enabled": true` for the channels you want, then wire secrets in GitHub.

© 2025 NSP (New Star Player) & DSP Partnership. All Rights Reserved.
