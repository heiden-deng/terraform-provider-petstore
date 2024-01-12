fork from github.com/TyunTech/terraform-provider-petstore
# A Provider for Terraform

## 测试

```bash
➜  terraform-provider-petstore git:(dev) ✗ export PETSTORE_ADDRESS=http://localhost:8000
➜  terraform-provider-petstore git:(dev) ✗ make test                                    
?       github.com/heiden-deng/terraform-provider-petstore [no test files]
=== RUN   TestProvider
--- PASS: TestProvider (0.00s)
=== RUN   TestProvider_impl
--- PASS: TestProvider_impl (0.00s)
=== RUN   TestAccPSPet_basic
--- PASS: TestAccPSPet_basic (0.26s)
PASS
ok      github.com/heiden-deng/terraform-provider-petstore/petstore        0.633s
```
