# Terraform test setup

##Goal
Setup a simple server on AWS provisioned by Terraform, that upon request would return Hello World message.

##How to run  
Set up environment variables

```
export DOCKER_USERNAME=username  
export DOCKER_PASSWORD=pass  
export AWS_ACCESS_KEY_ID=aws_key  
export AWS_SECRET_ACCESS_KEY=aws_secret_key
```

and then  
```
make run-all
```

Checking hello world message from server `curl http://<<public_ip from terraform apply output>>:8080`  
Currently it should be `curl http://52.56.204.37:8080/`

***

  
To run app locally  
```
cd app
pip install -r requirements.txt
flask run
```

Hello World will appear on `http://localhost:5000/`

***

To run dockerized app locally use  
```
make run-local
```

Checking Hello World message from Docker `curl http://localhost:8080/`  

***

To rebuild Docker image and push it to DockerHub run  
```
make push-to-dockerhub
```

To initialize Terraform  
```
make init
```

To apply new plan 
```
make infra
```

To destroy
```
make infra-destroy
```


##Debugging
For the sake of testing I was SSHing to the instance with
```
ssh -i "{file}" ubuntu@{address}
```

where `file` was .pem file associated with **tf-task-key** for terraform_test aws_instance  
and `address` was public DNS address for that instance
