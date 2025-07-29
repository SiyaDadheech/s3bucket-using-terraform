# s3bucket-using-terraform
🔧 Steps Performed
1. Set up AWS S3 Bucket via Terraform
   
Created a uniquely named S3 bucket with:  


Website hosting configuration  

Public access policy  

ACL and ownership rules  


Optional versioning (recommended for future)  


2. Created Static Website Files
   
Built simple index.html and style.css files inside website/ directory.  


Used basic HTML + CSS to design a welcome page.  


3. Uploaded Files to S3 with Terraform
   
Used aws_s3_bucket_object to upload:  


index.html  

style.css  

Ensured correct content_type values like text/html and text/css.  

4. Handled File Updates
   
Used terraform taint to force updates when file changes were not detected. 

Added source_hash = filemd5(...) to ensure file changes are always recognized.    


5. Verified and Accessed the Website
   object url: https://unique-bucket-by-siya-123400.s3.ap-south-1.amazonaws.com/index.html
   

After terraform apply, accessed the live website via: 
