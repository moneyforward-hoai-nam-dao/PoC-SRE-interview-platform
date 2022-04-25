package main

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cloudwatch"
)

func main() {
	URL := "http://test.example.com/"
	ping_server(URL)
}

func ping_server(URL string) {
	deduction_time_by_sleep := 0
	for { // loop forever
		// reset number of request
		number_request_OK_per_10_senconds := 0.0
		// after 10 second put metic to CloudWatch
		real_time_elapse := time.Now().Add(-time.Millisecond * time.Duration(deduction_time_by_sleep*100000))
		for start := time.Now(); time.Since(real_time_elapse) < 10*time.Second; {
			resp, have_err := http.Get(URL)

			if have_err != nil {
				fmt.Println("Request HTTP have error!")
			} else {
				if resp.StatusCode != http.StatusOK {
					time.Sleep(time.Second)
					for {
						new_resp, _ := http.Get(URL)
						new_status := new_resp.StatusCode

						if time.Since(start) > 10*time.Second {
							put_me_tric(number_request_OK_per_10_senconds)
							fmt.Println("Elapse 10s. Put metric!")
							break
						}

						if new_status == 200 {
							number_request_OK_per_10_senconds += 1
							fmt.Println("Retry success!")
							break
						}
					}
					time.Sleep(100 * time.Millisecond)
				} else {
					number_request_OK_per_10_senconds += 1
					if time.Since(start) > 10*time.Second {
						fmt.Println("Success! Put metric")
						put_me_tric(number_request_OK_per_10_senconds)
					}
					time.Sleep(100 * time.Millisecond)
				}
			}

		}
	}

}

func put_me_tric(number_status_OK float64) {
	AWS_ACCESS_KEY_ID := os.Getenv("AWS_ACCESS_KEY_ID")
	AWS_SECRET_ACCESS_KEY := os.Getenv("AWS_SECRET_ACCESS_KEY")
	sess, error := session.NewSession(&aws.Config{
		Region:      aws.String("ap-southeast-1"),
		Credentials: credentials.NewStaticCredentials(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, ""),
	})

	if error != nil {
		fmt.Println("Error authenticate :", error.Error())
	}

	// Create new cloudwatch client.
	svc := cloudwatch.New(sess)

	_, err := svc.PutMetricData(&cloudwatch.PutMetricDataInput{
		Namespace: aws.String("Site/Traffic"),
		MetricData: []*cloudwatch.MetricDatum{
			&cloudwatch.MetricDatum{
				MetricName: aws.String("RequestPer10Seconds"),
				Unit:       aws.String("Count"),
				Value:      aws.Float64(number_status_OK),
				Dimensions: []*cloudwatch.Dimension{
					&cloudwatch.Dimension{
						Name:  aws.String("SiteName"),
						Value: aws.String("example.com"),
					},
				},
			},
		},
	})
	if err != nil {
		fmt.Println("Error adding metrics:", err.Error())
		return
	}
}
