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
			Value  [2]interface{}    `json:"value"` // [ <timestamp>, <value> ]
		} `json:"result"`
	} `json:"data"`
}

func main() {
	// Thanos QueryFrontのエンドポイント
	baseURL := "http://192.168.0.241:31600/api/v1/query"

	// 取得したい PromQL クエリ
	query := "up"

	// URLを構築
	params := url.Values{}
	params.Add("query", query)

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
			fmt.Printf("Metric: %v, Value: %v\n", r.Metric, r.Value[1])
		}
	} else {
		fmt.Println("Query failed:", string(body))
	}
}
