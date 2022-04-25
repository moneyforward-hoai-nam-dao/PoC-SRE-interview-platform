<p align="center">
  <img src="https://github.com/moneyforward-hoai-nam-dao/PoC-SRE-interview-platform/blob/main/images/PoC-SRE-interview-platform.png?raw=true" alt="Sublime's custom image"/>
</p>

* [About](#About) 
* [Prerequisites](#Prerequisites)
* [Configure](#Configure)
* [Test Procedure En](#test-procedure-en)
* [Tes Procedure Ja](#test-procedure-ja)
* [Expect En](#expect-en)
* [Expect Ja](#expect-ja)
* [How to check interviewee passed the test En](#how-to-check-interviewee-has-passed-the-test-en)
* [How to check interviewee passed the test Ja](#how-to-check-interviewee-has-passed-the-test-ja)
* [Step to check passed](#step-to-check-passed)
* [Expect state](#expect-state)
* [Author and intructors](#author-and-intructors)


## Qoute 
<p align="center">
  <em>
 We can't know the candidate without testing them
   </em>
<p>

## About
This project is built as Proof of Concept. Aim to create a test environment that checks whether SRE candidates meet the basic requirements of the cloud. In a test environment where there are some design flaws (on purpose), the candidate needs to fix the bugs in order for the system to run stably.


このプロジェクトは、Proof of Concept として構築されています。 SRE候補がクラウドの基本要件を満たしているかどうかをチェックするテスト環境の作成を目指します。 （意図的に）設計上の欠陥があるテスト環境では、システムを安定して実行するために、候補者はバグを修正する必要があります。

## Prerequisites 
  * Docker 
  * Kubernets
  * Terraform 
  * AWS basic 
  
## Configure
  We split the terraform code into 2 parts: code for base state and code for scenario 1. When interviewee complete the test, only resources related to test scenario are deleted and code for base state is preserved


 1. Install
  ```
   git clone https://github.com/moneyforward-hoai-nam-dao/PoC-SRE-interview-platform.git 
  ```
  2. MUST run terraform code in base folder BEFORE run terraform code in scenario 1 !

  3. Follow the instruction in base folder and scenario folder
 
## Test procedure [En]
1. Interviewer apply terraform to start this scenario.
2. Interviewer will receive output from terraform which is the IAM key and IAM password.
3. Interviewer send Interviewee the IAM key and IAM password and AWS account login url.
4. Interviewee can login to AWS console.
5. Interviewee can login into EKS and apply manifests.
6. Interviewer can check if problem is solved.
7. Interviewer can run terraform to reset to base state.

## Test procedure [Ja]
1. 審査官 は、このシナリオを開始するためにテラフォームを適用します。
2. 審査官 は、IAMキーとIAMパスワードであるterraformからの出力を受け取ります。
3. 審査官 はインタビュイーにIAMキーとIAMパスワードおよびAWSアカウントのログインURLを送信します。
4. 候補者 は AWSコンソールにログインできます。
5. 候補者 は EKSにログインして、マニフェストを適用できます。
6. 審査官 は、問題が解決したかどうかを確認できます。
7. 審査官 は、テラフォームを実行して基本状態にリセットできます。


## Expect [En]
1. Interviewee can check the log in CloudWatch to see the metrics
2. Interviewee can check the active status of the pod in K8S
3. Interviewee can check Policy, Security Group, Node port, ALB,  etc
4. Interviewee will then apply the changes to make the system work properly

## Expect [Ja]
1. 候補者 は CloudWatchのログをチェックして、メトリクスを確認できます
2. 候補者 は K8Sでポッドのアクティブステータスを確認できます
3. 候補者 は、ポリシー、セキュリティグループ、ノードポート、ALBなどを確認できます。
4. 候補者 は、システムが正しく機能するように変更を適用します

## How to check interviewee has passed the test [En]
1. No pods died
2. The number of successful requests in 10s must be greater than X(X>10)

## How to check interviewee has passed the test [Ja]
1. ポッドは死にませんでした
2. 10秒間に成功したリクエストの数は、X（X> 10）より大きくなければなりません。

## Step to check passed 
1. AWS configure 
```
 Type your AWS_ACCESS_KEY  and AWS_SECRET_KEY
```
2. Update kubeconfig 
```
   aws eks update-kubeconfig --region ap-southeast-1 --name pbl-04-2022-cluster
```
3.  Get all pods in go-server namespace 
```
    kubectl get pods --namespace="go-server"
```

4. Check pods status and number of pods. if node have X(eg: X >= 3) pods above and all pods are running => OK 
Interviewee can scale vertically(not encourage this solution)

5. Check security group of ALB (allow ingress on port 80)

6. Check CloudWatch to see number success request per 10s greater than threshold(eg: X >= 10) => OK

## Expect state

1. CloudWatch image
<p align="center">
  <img src="https://github.com/moneyforward-hoai-nam-dao/PoC-SRE-interview-platform/blob/main/images/cloud_watch_normal_state.png?raw=true" alt="Sublime's custom image"/>
</p>

2. Desgin normal state
<p align="center">
  <img src="https://github.com/moneyforward-hoai-nam-dao/PoC-SRE-interview-platform/blob/main/images/design_normal_state.png?raw=true" alt="Sublime's custom image"/>
</p>



## Author and intructors
Many thanks to  [yuyuvn](https://github.com/yuyuvn)  who gave the idea and design of the system