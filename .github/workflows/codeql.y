name: CodeQL Advanced
permissions:
  contents: read
  security-events: write

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 0'

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v3
        with:
          languages: javascript, python, java

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v3
name: Appknox
permissions:
  contents: read
  security-events: write

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  appknox:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Grant execute permission for gradlew
        run: chmod +x gradlew || echo "gradlew not found, skipping"

      - name: Build the app
        run: ./gradlew build || echo "Build skipped"

      - name: Appknox GitHub action
        uses: appknox/github-action@v1
        with:
          token: ${{ secrets.APPKNOX_TOKEN }}
          app_id: ${{ secrets.APPKNOX_APP_ID }}

      - name: Upload SARIF to GHAS
        if: success() && exists('report.sarif')
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: report.sarif
