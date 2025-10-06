Smart Orb Network — GitHub Pages Launch Pack (Futuristic)

This folder is ready to upload to a GitHub repository and serve at https://smartorb.network

Steps (first time):
1) Create a new GitHub repo (e.g., smartorb-network-site)
2) Upload all files/folders from this package (keep CNAME at root)
3) In GitHub: Settings → Pages → Build and deployment
   - Source: Deploy from branch
   - Branch: main (root)
4) Wait ~1–3 minutes for Pages to build
5) Ensure your DNS points your domain to GitHub Pages:
   - In Namecheap: Advanced DNS → add CNAME record
     Host: www  |  Target: <your-username>.github.io
     Host: @    |  ALIAS/ANAME to <your-username>.github.io (or use A records to GitHub Pages IPs)
6) Visit https://smartorb.network (HTTPS auto via GitHub after DNS propagates)

Notes:
- Audio is muted by default to respect browser autoplay policies; click 🔇 to enable.
- Toggle dark/light with 🌓.
- You can customize copy or styles in index.html / style.css.
