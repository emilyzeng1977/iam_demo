// Lambda lambda which gets an Overlay request JWT and
// Convert it into an IAM policy with matching customer ID
//
// The plan is for this lambda to be generalized and possibly reused
// as lambda for other lambdas
package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws/session"
    "github.com/aws/aws-sdk-go/service/s3"
)

func GetAllBuckets(sess *session.Session) (*s3.ListBucketsOutput, error) {
    svc := s3.New(sess)

    result, err := svc.ListBuckets(&s3.ListBucketsInput{})
    if err != nil {
        return nil, err
    }

    return result, nil
}

type SampleEvent struct {
	ID   string `json:"id"`
	Val  int    `json:"val"`
	Flag bool   `json:"flag"`
}

func HandleRequest(ctx context.Context, event SampleEvent) (string, error) {
    sess := session.Must(session.NewSessionWithOptions(session.Options{
        SharedConfigState: session.SharedConfigEnable,
    }))

    result, err := GetAllBuckets(sess)
    if err != nil {
        fmt.Println(err)
    }

    fmt.Println("Buckets:")

    for _, bucket := range result.Buckets {
        fmt.Println(*bucket.Name + ": " + bucket.CreationDate.Format("2006-01-02 15:04:05 Monday"))
    }

	return fmt.Sprintf("%+v", event), nil
}

func main() {
	lambda.Start(HandleRequest)
}
