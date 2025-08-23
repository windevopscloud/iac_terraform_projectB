flowchart LR
%% Bastion Access
C8[Bastion Host] --> C2[EKS (4 nodes MNG)]

%% ECR Access
C2 --> C10[ECR Repo Pull]
C2 --> C11[ECR Repo Push]
C10 --> ECR[ECR]
C11 --> ECR

%% Network Services Account D
subgraph Net[Account D: Network Services]
N1[Transit Gateway]
N2[Route53 Private Zones + Resolver In/Out]
N3[AWS Network Firewall / Inspection VPC]
end

%% External API Account A
subgraph Ext[Account A: External API]
A1[Route53 Public Zone\napi.example.com]
A2[API Gateway (Regional)\n+ WAF + Shield]
A3[Cognito User Pool (External)]
A4[VPC-A]
A5[Interface Endpoints: SSM, STS, CloudWatch]
end

%% Internal API Account B
subgraph Int[Account B: Internal API]
B1[Route53 Private Hosted Zone\nint.example.internal]
B2[API Gateway (Private)\nVPC Endpoint Policy]
B3[Cognito User Pool (Internal Service Accounts)]
B4[VPC-B]
B5[Interface VPCE: execute-api, S3, ECR, STS]
end

%% EKS + Data Account C
subgraph App[Account C: EKS + Data]
C1[VPC-C\nPrivate Subnets AZ-a/b/c]
C2[EKS (4 nodes MNG)]
C3[NLB: app-svc]
C4[Endpoint Service (PrivateLink)]
C5[Aurora (Multi-AZ, read replica)]
C6[S3 Buckets (Private, KMS)]
C7[Secrets Manager, KMS CMKs]
C8[Bastion Host]
C10[ECR Repo Pull]
C11[ECR Repo Push]
end

%% Networking relations
A4 <-->|TGW Attach| N1
B4 <-->|TGW Attach| N1
C1 <-->|TGW Attach| N1

N1 --> N3
N2 --> A4
N2 --> B4
N2 --> C1

%% API Gateway Integrations
A2 -->|VPC Link / PrivateLink| C3
B2 -->|VPC Link / PrivateLink| C3

%% Cognito Authorizers
A2 -->|Cognito Authorizer| A3
B2 -->|Cognito Authorizer| B3

%% Route53 associations
A1 --- A2
B1 --- B2