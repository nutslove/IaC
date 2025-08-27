#!/usr/bin/env python3
import requests
import json
import sys
import os

"""
<概要>
GrafanaのAlertルール定義から、alertnameに一致するルールを取得し、クエリ部分を抽出するスクリプト

<使い方>
python get-grafana-alert.py <alertname>
"""

# GrafanaのURLを設定
GRAFANA_URL = "http://192.168.0.241:30000"

# Viewer権限(Role)のService Account Tokenを設定
SERVICE_ACCOUNT_TOKEN = "<YOUR_SERVICE_ACCOUNT_TOKEN>"

HEADERS = {
    "Authorization": f"Bearer {SERVICE_ACCOUNT_TOKEN}",
    "Content-Type": "application/json",
}

def get_alert_rules():
    """Grafanaからすべてのアラートルールを取得"""
    url = f"{GRAFANA_URL}/api/v1/provisioning/alert-rules"
    resp = requests.get(url, headers=HEADERS)
    resp.raise_for_status()
    return resp.json()

def find_rule_by_alertname(alertname: str):
    """alertnameに一致するルールを探す"""
    rules = get_alert_rules()
    for rule in rules:
        if rule.get("title") == alertname:
            return rule
    return None

def extract_queries(rule):
    """ルール定義からクエリ部分を抽出"""
    queries = []
    for cond in rule.get("data", []):
        expr = cond.get("model", {}).get("expr")
        refId = cond.get("refId")
        datasource = cond.get("datasourceUid")
        queries.append({
            "refId": refId,
            "expr": expr,
            "datasourceUid": datasource,
        })
    return queries

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"使い方: {sys.argv[0]} <alertname>")
        sys.exit(1)

    alertname = sys.argv[1]
    rule = find_rule_by_alertname(alertname)
    if not rule:
        print(f"アラート '{alertname}' のルールが見つかりませんでした")
        sys.exit(1)

    print(f"=== Alert Rule: {rule['title']} ===")
    queries = extract_queries(rule)
    for q in queries:
        print(json.dumps(q, ensure_ascii=False, indent=2))