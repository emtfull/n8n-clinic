# README.md
# n8n Self-Hosted (Render + Supabase)

This repo runs a self-hosted n8n instance with:
- ✅ Free Supabase database (no Render DB cost)
- 🔒 Secure `.env` and `render.yaml` configuration
- ☁️ Deployable via [Render.com](https://render.com)
- 📦 Workflow export script

---

## 🚀 Deployment Steps

### 1. 📦 Clone This Repo
If you haven't yet:
```bash
git clone https://github.com/your-username/n8n-render-supabase.git
cd n8n-render-supabase
```

### 2. 🛠 Create a Free Supabase Project
- Go to [https://app.supabase.com](https://app.supabase.com)
- Create a new project
- Go to **Project Settings → Database → Connection Info**
- Note the connection string (looks like `postgresql://postgres:[password]@db.[host].supabase.co:5432/postgres`)

### 3. 🔐 Update Your Environment Variables
Open your `.env` file:
```env
POSTGRES_PASSWORD=your_real_supabase_password
WEBHOOK_URL=https://n8n-your-app.onrender.com
VUE_APP_URL_BASE_API=https://n8n-your-app.onrender.com
N8N_ENCRYPTION_KEY=generate_a_secure_key
```

Generate a secure key with:
```bash
openssl rand -base64 32
```

Then update `render.yaml` with the same values under `envVars`. Replace:
```yaml
value: your_real_supabase_password
value: https://n8n-your-app.onrender.com/
```
With your actual info.

### 4. 🚀 Push to GitHub
Commit your changes and push to GitHub:
```bash
git add .
git commit -m "Initial Render deploy"
git push origin main
```

### 5. ☁️ Deploy on Render
- Go to [https://dashboard.render.com](https://dashboard.render.com)
- Click **New Web Service** → Connect your GitHub repo
- Render auto-detects `render.yaml`
- Click **Deploy**

### 6. 🔄 Update Render Environment (UI)
After initial deployment:
1. Go to your Render service dashboard
2. Click **Environment** tab
3. Update these environment variables manually (if not set from YAML):

| Key                     | Value                                |
|------------------------|--------------------------------------|
| POSTGRES_PASSWORD      | Your Supabase DB password            |
| WEBHOOK_URL            | https://your-app-name.onrender.com/  |
| VUE_APP_URL_BASE_API   | https://your-app-name.onrender.com/  |
| N8N_ENCRYPTION_KEY     | Your secure 32-byte key              |

Then click **Deploy latest commit** to apply changes.

---

## 🧪 Test Your n8n
Once deployed, open your Render app URL:
```bash
https://your-app-name.onrender.com
```

Log in and create your first workflow!

---

## 💾 Export Workflows
To backup workflows locally:
```bash
chmod +x export_workflows.sh
./export_workflows.sh
```
Exports will be saved under `/backup/` as `.json` files and compressed into `.tar.gz`.

---

## 🔄 Restore Workflows *(coming soon)*
You can import workflows later with:
```bash
n8n import:workflow --input=/path/to/export.json
```

---

Let me know if you want GitHub Action backups or import automation!
