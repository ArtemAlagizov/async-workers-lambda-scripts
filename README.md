# async-workers-lambda-scripts

How to use the repo:
* for creating and updating aws lambda functions in python ([aws_docs](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html)):
    * install python3
    * install aws cli
        ```
        npm i -g aws-cli
        ```
    * create function in a directory
    * run "py -m pip install --target ./package GitPython"
    * package function and packages into a zip archive
      ```
      cd package
      zip -r9 C:\Users\artem\IdeaProjects\async-workers-lambda-scripts\lambdas\function.zip .
      zip -g function.zip e2e_test_function.py
      ```
    * upload the archive to aws:
      ```
      aws lambda update-function-code --function-name e2e_tests --zip-file fileb://function.zip
      ```
