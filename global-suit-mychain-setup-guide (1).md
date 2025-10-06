# Global Suit — MyChain Setup Guide
**Sepolia Testnet • MetaMask • Build Your Ecosystem (Wallet + Membership + Rewards)**  
**Generated:** October 04, 2025 (UTC)

---

## 0) What you’ll build
- Deploy your **NSP token (UUPS)** with **Timelock + Multisig governance**
- Add **Reward Pool + Loyalty Vault + Manager**
- (Optional) Deploy **MembershipVault** for monthly tiers and boosts
- Run the **AI Watcher** (auto-pause on whale anomalies)
- Launch the **Portal** (status, claims, membership, policy) and **Wallet app**

> You can repeat these steps for mainnet by just changing RPC + keys.

---

## 1) Prereqs
- Node.js 18+ and npm
- Git (optional but recommended)
- A Sepolia RPC URL (Alchemy/Infura/QuickNode etc.)
- MetaMask with a **Sepolia** account + a bit of test ETH (get from a faucet)

---

## 2) Unpack the suite
Download and unzip the latest bundle (R2.2 or newer). You should see:
```
nsp-r2.2/
  portal/
  wallet-app/
  (optional) hardhat/ and contracts in previous R2 bundles
```
If you are using the **R2 full bundle** with Hardhat + contracts:
```
nsp/
  hardhat/
  contracts/
  portal/
  ai-watcher/
```

---

## 3) Deploy base contracts (Sepolia)
> Skip this section if your token is already deployed and you only want to connect the portal/wallet.

```bash
cd nsp/hardhat
npm i
cp .env.sample .env
# Edit .env (example)
# RPC_URL=https://sepolia.infura.io/v3/<YOUR_KEY>
# PRIVATE_KEY=0x<your_deployer_private_key>
# ETHERSCAN_API_KEY=<your_key>      # optional for verify
# MULTISIG_OWNER=0xYourSafeOrEOA
# TOKEN_NAME=NSP Global
# TOKEN_SYMBOL=NSP
# TOKEN_CAP=1000000000000000000000000000
# INITIAL_MINT=10000000000000000000000000
npx hardhat run scripts/deploy_base.ts --network sepolia
```
**Output:** JSON with `timelock` and `tokenProxy`. Save these addresses.

---

## 4) Add rewards + loyalty (optional upgrade path)
```bash
# Set env in one line (or write into .env and read it)
TOKEN_PROXY=<your token proxy> \
USDC=<testnet usdc or mock> \
MULTISIG_OWNER=<your multisig or EOA> \
npx hardhat run scripts/upgrade_to_whale_loyalty.ts --network sepolia
```
**Output:** addresses for `EcosystemRewardPoolV2`, `LoyaltyVault`, `LoyaltyManager`.

---

## 5) Add membership (optional)
```bash
TOKEN_PROXY=<your token proxy> \
MULTISIG_OWNER=<your safe or EOA> \
npx hardhat run scripts/deploy_membership.ts --network sepolia
```
**Output:** `MembershipVault` address.

---

## 6) Run the AI Watcher (guardian auto-pause)
```bash
cd ../ai
cp .env.sample .env
# RPC_URL=... (Sepolia)
# BOT_PRIVATE_KEY=0x<operator key>
# TOKEN_ADDR=<your token proxy>
# GUARDIAN_ADDR=<UpgradeGuardian address, if used>
# CONFIG_URL=<optional JSON with thresholds>
npm i
node watcher.js
```
The watcher listens for large transfers/accumulations and (optionally) pauses upgrades via Guardian.

---

## 7) Launch the Portal
```bash
cd ../portal
npm i
npm run dev
# Open http://localhost:3000
```
### 7.1 Status page
Set env vars or use a config file:
- `NSP_RPC` — your Sepolia RPC URL  
- `NSP_TOKEN_PROXY` — token address  
- `NSP_GUARDIAN` — (optional) guardian address  
- `NSP_REWARD_POOL` — (optional) reward pool address  

Or visit **/setup** (in R2.1+) to generate `public/config.json`:
```json
{
  "rpc": "https://sepolia.infura.io/v3/YOUR_KEY",
  "token": "0xYourTokenProxy",
  "guardian": "0xYourGuardian",
  "rewardPool": "0xYourRewardPool"
}
```
Place this file into `portal/public/`.

### 7.2 Claims page (R2.2)
Visit **/claims** and paste:
- Airdrop contract address
- Amount (wei)
- Merkle `proof[]` JSON array

### 7.3 Membership page (R2.2)
Visit **/membership** to read a wallet’s tier and **subscribe** with MetaMask.

### 7.4 Policy Guardian page (R2.2)
Visit **/policy-guardian** to view/toggle safe switches.

---

## 8) Wallet app (Expo React Native)
- Unlock with **biometrics + pattern**  
- Read token **name/symbol/supply**  
- Get DEX swap **quote stub** (wire up Uniswap/0x later)

```bash
cd ../wallet-app
npm i
# Start with Expo CLI (on your dev machine):
# npx expo start
```
In the app, enter **RPC URL** and **Token Address** → tap **Refresh**.

---

## 9) Safety checklist
- Use a separate **deployer key** for test deployments
- Store mint/admin roles behind **Timelock + Multisig**
- Keep **PRIVATE_KEY** out of git (in `.env` only)
- Verify contracts on Etherscan when possible
- Configure whale limits and reward pool vaults carefully
- Back up Merkle airdrop CSVs + roots

---

## 10) Troubleshooting
- **Portal shows “Set envs…”** → Provide envs or `public/config.json`
- **Wallet shows no supply** → Check RPC URL and token proxy are correct
- **AI watcher can’t pause** → Ensure `GUARDIAN_ADDR` is set and the bot has permissions
- **Etherscan verify fails** → Confirm constructor args, try again after a few minutes

---

## Appendix A — Example `.env` (Hardhat)
```
RPC_URL=https://sepolia.infura.io/v3/<KEY>
PRIVATE_KEY=0x<deployer>
ETHERSCAN_API_KEY=<key>
MULTISIG_OWNER=0xYourSafeOrEOA
TIMELOCK_DELAY_SECONDS=172800
TOKEN_NAME=NSP Global
TOKEN_SYMBOL=NSP
TOKEN_CAP=1000000000000000000000000000
INITIAL_MINT=10000000000000000000000000
USDC=0xYourTestnetUSDC
```

## Appendix B — Example `config.json` (Portal)
```
{
  "rpc": "https://sepolia.infura.io/v3/YOUR_KEY",
  "token": "0xYourTokenProxy",
  "guardian": "0xYourGuardian",
  "rewardPool": "0xYourRewardPool"
}
```

---

**All set — once you’ve completed Sepolia, you can repeat these steps on mainnet by switching RPC + keys and re-running the scripts.**
