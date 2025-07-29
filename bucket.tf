resource "aws_s3_bucket" "buck-web" {
  bucket = "unique-bucket-by-siya-123400"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_ownership_controls" "own" {
  bucket = aws_s3_bucket.buck-web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.buck-web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.own,
    aws_s3_bucket_public_access_block.access,
  ]

  bucket = aws_s3_bucket.buck-web.id
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.buck-web.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.buck-web.id
  key    = "index.html"
  content = "<html><h1> Welcome to my website </h1></html>"
  content_type = "text/html"


}
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.buck-web.id

  depends_on = [aws_s3_bucket_public_access_block.access]

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::unique-bucket-by-siya-123400/*"
    }
  ]
}
POLICY
}
