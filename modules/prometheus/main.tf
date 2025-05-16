global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'agi-services'
    static_configs:
      - targets: ['bigagi:3000', 'browserless:3001']
