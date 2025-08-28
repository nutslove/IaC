package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
)

// Prometheus / Thanos API のレスポンス構造体
type QueryResponse struct {
	Status string `json:"status"`
	Data   struct {
		ResultType string `json:"resultType"`
		Result     []struct {
			Metric map[string]string `json:"metric"`
			Values  [][2]interface{}   `json:"values"` // [ <timestamp>, <value> ]
		} `json:"result"`
	} `json:"data"`
}

func main() {
	// Thanos QueryFrontのエンドポイント
	baseURL := "http://192.168.0.241:31600/api/v1/query_range" // curl "http://192.168.0.241:31600/api/v1/query_range?query=node_cpu_seconds_total\{mode=\"idle\"\}&start=1756397922&end=1756398922&step=60s" | jq 

	// 取得したい PromQL クエリ
	query := `node_cpu_seconds_total{mode="idle"}`
	start := "1756397922" // Example start time (Unix timestamp)
	end := "1756398922" // Example end time (Unix timestamp)
	step := "60s"

	// URLを構築
	params := url.Values{}
	params.Add("query", query)
	params.Add("start", start)
	params.Add("end", end)
	params.Add("step", step)

	resp, err := http.Get(baseURL + "?" + params.Encode())
	if err != nil {
		log.Fatalf("failed to query thanos: %v", err)
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)

	var result QueryResponse
	if err := json.Unmarshal(body, &result); err != nil {
		log.Fatalf("failed to parse response: %v", err)
	}

	// 結果を表示
	if result.Status == "success" {
		for _, r := range result.Data.Result {
			for _, value := range r.Values {
				fmt.Printf("Metric: %v, Value: %v\n", r.Metric, value[1])
			}
		}
	} else {
		fmt.Println("Query failed:", string(body))
	}
}
