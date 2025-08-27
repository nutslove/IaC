#!/usr/bin/env python3
"""
Grafana Alert Manager Webhook Receiver
GrafanaのAlert ManagerからのアラートをJSONで出力するHTTPサーバー
このPythonコードを実行した状態で、GrafanaのAlert ManagerのWebhook通知先に
http://<サーバーのIPアドレス>:8080 を設定してください。
"""

from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import datetime
from urllib.parse import urlparse

class AlertHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        """POSTリクエストを処理してアラートJSONを出力"""
        try:
            # リクエストボディを読み取り
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            
            # JSONをパース
            alert_data = json.loads(post_data.decode('utf-8'))
            
            # タイムスタンプ付きでアラートを出力
            timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            print(f"\n{'='*60}")
            print(f"Alert received at: {timestamp}")
            print(f"{'='*60}")
            
            # JSONを整形して出力
            print(json.dumps(alert_data, indent=2, ensure_ascii=False))
            print(f"{'='*60}\n")
            
            # レスポンスを返す
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(b'{"status": "ok", "message": "Alert received"}')
            
        except json.JSONDecodeError as e:
            print(f"JSON decode error: {e}")
            self.send_response(400)
            self.end_headers()
            self.wfile.write(b'{"error": "Invalid JSON"}')
            
        except Exception as e:
            print(f"Error processing alert: {e}")
            self.send_response(500)
            self.end_headers()
            self.wfile.write(b'{"error": "Internal server error"}')
    
    def do_GET(self):
        """GETリクエストに対してステータスページを返す"""
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        html = b"""
        <html>
        <head><title>Grafana Alert Receiver</title></head>
        <body>
            <h1>Grafana Alert Manager Webhook Receiver</h1>
            <p>Server is running and ready to receive alerts.</p>
            <p>Send POST requests with Alert Manager format to this endpoint.</p>
        </body>
        </html>
        """
        self.wfile.write(html)
    
    def log_message(self, format, *args):
        """ログメッセージをカスタマイズ"""
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] {format % args}")

def main():
    # サーバー設定
    host = '0.0.0.0'  # 全てのインターフェースでリッスン
    port = 8080       # ポート番号
    
    try:
        # HTTPサーバーを作成
        server = HTTPServer((host, port), AlertHandler)
        
        print(f"Grafana Alert Manager Webhook Receiver")
        print(f"Server starting on http://{host}:{port}")
        print(f"Ready to receive alerts...")
        print(f"Press Ctrl+C to stop the server")
        print("-" * 50)
        
        # サーバーを開始
        server.serve_forever()
        
    except KeyboardInterrupt:
        print("\nServer stopped by user")
    except Exception as e:
        print(f"Error starting server: {e}")

if __name__ == "__main__":
    main()


# 使用例とテスト用の関数
def test_alert_format():
    """
    Alert Managerの典型的なフォーマット例
    テスト時に参考にしてください
    """
    sample_alert = {
        "receiver": "web.hook",
        "status": "firing",
        "alerts": [
            {
                "status": "firing",
                "labels": {
                    "alertname": "HighCPUUsage",
                    "instance": "server01:9100",
                    "job": "node-exporter",
                    "severity": "warning"
                },
                "annotations": {
                    "description": "CPU usage is above 80% for more than 5 minutes",
                    "summary": "High CPU usage detected"
                },
                "startsAt": "2024-01-01T12:00:00.000Z",
                "endsAt": "0001-01-01T00:00:00Z",
                "generatorURL": "http://grafana:3000/graph"
            }
        ],
        "groupLabels": {
            "alertname": "HighCPUUsage"
        },
        "commonLabels": {
            "alertname": "HighCPUUsage",
            "job": "node-exporter",
            "severity": "warning"
        },
        "commonAnnotations": {},
        "externalURL": "http://alertmanager:9093",
        "version": "4",
        "groupKey": "{}:{alertname=\"HighCPUUsage\"}"
    }
    
    print("Sample Alert Manager format:")
    print(json.dumps(sample_alert, indent=2, ensure_ascii=False))

# テスト用のcurlコマンド例をコメントで記載
"""
テスト用curlコマンド:

curl -X POST http://localhost:8080 \
  -H "Content-Type: application/json" \
  -d '{
    "receiver": "web.hook",
    "status": "firing",
    "alerts": [
      {
        "status": "firing",
        "labels": {
          "alertname": "TestAlert",
          "severity": "critical"
        },
        "annotations": {
          "summary": "This is a test alert"
        }
      }
    ]
  }'
"""